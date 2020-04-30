import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_fomo/blocs/bloc.dart';
import 'package:project_fomo/models/event.dart';
import 'package:project_fomo/services/event_service.dart';
import 'package:rxdart/rxdart.dart';

class ViewAllBloc extends Bloc {
  EventService _eventService;
  DocumentSnapshot _lastDocument;
  String _category;
  List<Event> _events;
  List<String> _ids; // TODO: Addresses bug of showing last event infinitely
  final PublishSubject<List<Event>> _viewAllPageEventsSubject =
      PublishSubject<List<Event>>();
  final BehaviorSubject<String> _viewAllPageCategorySubject =
      BehaviorSubject<String>();

  Stream<List<Event>> get events => _viewAllPageEventsSubject.stream;
  Stream<String> get category => _viewAllPageCategorySubject.stream;

  ViewAllBloc({EventService eventService}) : _eventService = eventService;

  void setCategory(String category) {
    _category = category;
    _lastDocument = null;
    _events = []; // TODO : Potentially cache these events
    _ids = [];
    _viewAllPageCategorySubject.sink.add(_category);
  }

  void loadMoreEvents() async {
    print("loading events from $_category...");
    switch (_category) {
      case 'upcoming':
        getMoreUpcomingEvents();
        break;
      case 'popular':
        getMorePopularEvents();
        break;
      case '':
        throw FormatException("Category has not been set");
        break;
      default:
        throw FormatException("Category: $_category is not recognized");
        break;
    }
    _lastDocument = _eventService.lastDocument;
  }

  void getMoreUpcomingEvents() async {
    List<Event> nextEvents =
        await _eventService.getUpcomingEvents(startAfter: _lastDocument);
    for (Event event in nextEvents) {
      // This bug fix could be improved
      if (_ids.contains(event.id))
        return;
      else
        _ids.add(event.id);
    }
    if (nextEvents.isEmpty) return;
    _events.addAll(nextEvents);
    _viewAllPageEventsSubject.sink.add(_events);
  }

  void getMorePopularEvents() async {
    List<Event> nextEvents =
        await _eventService.getPopularEvents(startAfter: _lastDocument);
    if (nextEvents.isEmpty) return;
    for (Event event in nextEvents) {
      // This bug fix could be improved
      if (_ids.contains(event.id))
        return;
      else
        _ids.add(event.id);
    }
    _events.addAll(nextEvents);
    _viewAllPageEventsSubject.sink.add(_events);
  }

  @override
  void dispose() {
    print('Disposing view all bloc...');
    _viewAllPageEventsSubject.close();
    _viewAllPageCategorySubject.close();
  }
}