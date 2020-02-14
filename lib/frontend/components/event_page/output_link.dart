import 'package:flutter/material.dart';
import 'package:project_fomo/style.dart';
import 'package:url_launcher/url_launcher.dart';

class OutputLink extends StatelessWidget {
  final String url;
  final String title;
  final IconData urlIcon;
  final IconData displayIcon;

  OutputLink({@required this.title, @required this.url, @required this.urlIcon, @required this.displayIcon});

  _launchURL  (String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch \$url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(color: Color(0xFF343434)))
        ),
        child: Padding(
            padding: EdgeInsets.all(15),
            child: Row(

              children: <Widget>[
                Expanded(
                    flex: 1,
                    child:Icon(
                        displayIcon,
                        color: Colors.white
                    )
                ),
                SizedBox(
                  width: 8,
                ),
                Expanded(
                    flex: 6,
                    child: Text(
                        title,
                        style: TextStyle(
                            fontFamily: AppFontFamily.family,
                            color: AppTextColor.highEmphasis,
                            fontSize: AppFontSize.size18
                        )
                    )
                ),

                Expanded(
                    flex: 6,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        icon: Icon(
                            urlIcon,
                            color: Colors.white
                        )
                        ,
                        onPressed: () {
                          _launchURL(url);
                        },
                      ),
                    )
                )
              ],
            )
        )
    );

  }
}