import 'package:flutter/material.dart';
import '../thems/app_theme.dart';
import '../widget/home_drawer.dart';
import '../screen/artical_screen.dart';
import '../screen/demandBlood.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  static String routename = '/HomeScreen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, Object>> _pages = [];
  int _selectedIndex = 0;
  @override
  void initState() {
    _pages = [
      {'page': ArticalScreen(), 'title': 'Articlas'},
      {'page': DemandBlood(), 'title': 'DemandBlood'}
    ];
    shardPref();
    super.initState();
  }

  void shardPref() async {
    final prefs = await SharedPreferences.getInstance();
    print('pfref:  ' + prefs.getString('userData'));
  }

  @override
  Widget build(BuildContext context) {
    void _selectedPage(int index) {
      setState(() {
        _selectedIndex = index;
      });
    }

    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        backgroundColor: AppTheme.nearlyWhite,
        appBar: AppBar(
          title: Text('بنك الدم'),
        ),
        body: _pages[_selectedIndex]['page'],
        drawer: HomeDrawer(),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: AppTheme.nearlyWhite,
          onTap: _selectedPage,
          unselectedItemColor: AppTheme.grey,
          selectedItemColor: AppTheme.dismissibleBackground,
          selectedFontSize: 16,
          unselectedFontSize: 12,
          currentIndex: _selectedIndex,
          items: [
            BottomNavigationBarItem(
              // backgroundColor: Theme.of(context).primaryColor,
              icon: Icon(FontAwesomeIcons.addressBook),
              title: Text('Articlas'),
            ),
            BottomNavigationBarItem(
              backgroundColor: AppTheme.lightText,
              icon: Icon(FontAwesomeIcons.notesMedical),
              title: Text('Demand Blood'),
            ),
          ],
        ),
      ),
    );
  }
}
