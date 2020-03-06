import 'package:flutter/material.dart';
import 'package:project_fomo/backend/services/auth_service.dart';
import 'package:provider/provider.dart';
import 'package:project_fomo/frontend/components/profile/profile_header.dart';
import 'package:project_fomo/frontend/components/profile/settings_list.dart';
import 'package:project_fomo/style.dart';

class ProfilePage extends StatelessWidget {
  static const String pageRoute = '/profilepage';
  static const String name = 'Jack DiMarco';
  static const String email = 'emma.m.chadwick@gmail.com';
  static const String bio = 'I like Atlanta noise. If you like Atlanta noise lets find Atlanta noise together.';
  static const String profileUrl = 'https://twistedsifter.files.wordpress.com/2012/09/trippy-profile-pic-portrait-head-on-and-from-side-angle.jpg?w=800';
  static const String tag = '@jack';

  @override
  Widget build(BuildContext context) {
    AuthService authService = Provider.of<AuthService>(context);

    return Scaffold(
      body: SafeArea(
          child: Center(
              child: Column(
                children: <Widget>[
                  ProfileHeader(
                    name: name,
                    tag: tag,
                    bio: bio,
                    profileUrl: profileUrl,
                  ),
                  Container(
                      height: 2,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        gradient: AppColor.gradient,
                      )
                  ),
                  Padding(
                    padding: EdgeInsets.only(top:20, bottom: 20,),
                    child: Text('Future Friend Work Here')
                  ),
                  Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Color(0xFF343434)),
                        ),
                      )
                  ),
                  SettingList(),
                ],
              ),
            ),
      ),
    );
  }
}
