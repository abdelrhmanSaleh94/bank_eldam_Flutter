import 'package:flutter/material.dart';
import '../thems/app_theme.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import '../screen/donationDetials_screen.dart';

class DonationCard extends StatelessWidget {
  final String id;
  final String name;
  final String hostpital;
  final String city;
  final String phone;
  final String bloodType;
  DonationCard({
    @required this.name,
    @required this.id,
    @required this.hostpital,
    @required this.city,
    @required this.phone,
    @required this.bloodType,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Card(
        margin: EdgeInsets.all(5),
        elevation: 5,
        color: AppTheme.nearlyWhite,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(0),
                topRight: Radius.circular(50))),
        child: Container(
          width: double.infinity,
          height: 216,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .pushNamed(DonationaDetails.routeName, arguments: id);
                },
                child: Row(
                  textDirection: TextDirection.rtl,
                  children: <Widget>[
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: AppTheme.nearlyWhite,
                      child: Text(
                        bloodType,
                        style: AppTheme.display1,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            leading: Icon(FontAwesomeIcons.userInjured),
                            title: Text(
                              name,
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                          ListTile(
                            leading: Icon(FontAwesomeIcons.hospitalSymbol),
                            title: Text(
                              hostpital,
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                          ListTile(
                            leading: Icon(FontAwesomeIcons.city),
                            title: Text(
                              city,
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(right: 2),
                      child: RaisedButton.icon(
                        icon: Icon(FontAwesomeIcons.phoneAlt),
                        label: Text('Call'),
                        onPressed: () {
                          UrlLauncher.launch('tel:$phone');
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(2),
                        ),
                        color: AppTheme.call_green,
                        elevation: 5,
                        textColor:
                            Theme.of(context).primaryTextTheme.button.color,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
