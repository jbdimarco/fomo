import 'package:flutter/material.dart';
import 'package:project_fomo/pages/about_page.dart';
import 'package:project_fomo/pages/account_page.dart';
import 'package:project_fomo/pages/forgot_pass_page.dart';
import 'package:project_fomo/pages/profile_page.dart';
import 'package:project_fomo/pages/unknown_page.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: ProfilePage.pageRoute,
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) {
            switch (settings.name) {
              case ProfilePage.pageRoute:
                return ProfilePage();
              case AccountPage.pageRoute:
                return AccountPage();
              case AboutPage.pageRoute:
                return AboutPage();
              case ForgotPassPage.pageRoute:
                return ForgotPassPage();
              default:
                return UnknownPage();
            }
          },
        );
      },
    );
  }
}
