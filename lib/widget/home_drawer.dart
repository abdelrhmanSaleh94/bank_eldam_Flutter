import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../screen/contact_screen.dart';
import '../screen/notificationSetting_screen.dart';
import '../screen/information_screen.dart';
import '../screen/home_screen.dart';

class HomeDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            AppBar(
              title: Text('Hello Friend'),
              automaticallyImplyLeading: false,
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
              Navigator.of(context).pushReplacementNamed(HomeScreen.routename);
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(FontAwesomeIcons.info),
              title: Text('Information'),
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(InformationScreen.routeName);
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.notifications_active),
              title: Text('Manage Notification'),
              onTap: () {
                Navigator.of(context).pushReplacementNamed(NetficationSettingScreen.routeName);
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(FontAwesomeIcons.solidBookmark),
              title: Text('Favorite'),
              onTap: () {},
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.rate_review),
              title: Text('Rate App'),
              onTap: () {},
            ),
            Divider(),
            ListTile(
              leading: Icon(FontAwesomeIcons.headphonesAlt),
              title: Text('Contatc Us'),
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(ContactUsScreen.routeName);
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(
                FontAwesomeIcons.powerOff,
                color: Colors.red,
              ),
              title: Text('Logout'),
              onTap: () {},
            )
          ],
        ),
      ),
    );
  }
}
