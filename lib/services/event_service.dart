import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_fomo/models/event.dart';

class EventService {
  final CollectionReference _eventCollection =
      Firestore.instance.collection('events');

  final String _userId;

  EventService(this._userId);

  Future<List<Event>> getAllEvents() async {
    QuerySnapshot eventSnapshot = await _eventCollection.getDocuments();

    List<Event> events =
        eventSnapshot.documents.map((DocumentSnapshot document) {
      return Event.fromDocSnapshot(document);
    }).toList();

    return events;
  }
}