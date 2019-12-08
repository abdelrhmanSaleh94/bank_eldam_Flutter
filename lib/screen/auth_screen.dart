import 'package:flutter/material.dart';
import './login_screen.dart';
import './sing_up_screen.dart';
import './login_screenFinaly.dart';

class AuthScreen2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: Container(
            color: Colors.blueGrey,
            child: SafeArea(
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Container(),
                  ),
                  TabBar(
                    tabs: <Widget>[
                      Tab(
                        text: 'Login',
                      ),
                      Tab(
                        text: 'Singup',
                      )
                    ],
                    unselectedLabelColor: Colors.grey,
                    unselectedLabelStyle: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            LoginScreenF(),
            SignUpScreen(),
          ],
        ),
      ),
    );
  }
}
