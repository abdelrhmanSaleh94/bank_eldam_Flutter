import 'package:bank_eldam/thems/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../widget/home_drawer.dart';
import 'dart:math';
import '../provider/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import '../widget/simple_round_button.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ContactUsScreen extends StatelessWidget {
  static final routeName = '/ContactUsScreen';
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact With Us '),
      ),
      drawer: HomeDrawer(),
      body: SingleChildScrollView(
        child: Container(
          width: deviceSize.width,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 20.0, top: 20),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40.0),
                transform: Matrix4.rotationZ(-7 * pi / 180)..translate(-10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.deepOrange.shade900,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 10,
                      color: Colors.black26,
                      offset: Offset(0, 2),
                    )
                  ],
                ),
                child: Text(
                  'بنك الدم',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: 'Anton',
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    ListTile(
                      onTap: () {
                        UrlLauncher.launch('tel:01098046024');
                      },
                      leading: Icon(FontAwesomeIcons.phoneSquareAlt),
                      title: Text('Phone'),
                      subtitle: Text('01098046024'),
                    ),
                    ListTile(
                      onTap: () {
                        UrlLauncher.launch(
                            'mailto:abdelrhman94saleh@gmail.com');
                      },
                      leading: Icon(FontAwesomeIcons.mailBulk),
                      title: Text('Email'),
                      subtitle: Text('abdelrhman94saleh@gmail.com'),
                    )
                  ],
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(FontAwesomeIcons.facebookSquare),
                      onPressed: () {},
                      color: Colors.blue,
                      iconSize: (deviceSize.width / 5) - 16,
                    ),
                    IconButton(
                      icon: Icon(FontAwesomeIcons.instagram),
                      onPressed: () {},
                      disabledColor: Colors.red,
                      color: Colors.red[200],
                      iconSize: (deviceSize.width / 5) - 16,
                    ),
                    IconButton(
                      icon: Icon(FontAwesomeIcons.whatsappSquare),
                      onPressed: () {},
                      color: Colors.greenAccent,
                      iconSize: (deviceSize.width / 5) - 16,
                    ),
                    IconButton(
                      icon: Icon(FontAwesomeIcons.youtubeSquare),
                      onPressed: () {},
                      color: Colors.red,
                      iconSize: (deviceSize.width / 5) - 16,
                    ),
                    IconButton(
                      icon: Icon(FontAwesomeIcons.twitterSquare),
                      onPressed: () {},
                      color: Colors.blue,
                      iconSize: deviceSize.width < 600
                          ? (deviceSize.width / 5) - 16
                          : 30,
                    )
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: <Color>[Colors.blueAccent, Colors.blueGrey],
                      begin: Alignment.topLeft,
                      end: Alignment.topRight,
                      stops: [0, 1]),
                ),
                child: Text(
                  'Contact With Us',
                  textAlign: TextAlign.center,
                  style: AppTheme.bottomWhite,
                ),
              ),
              ContactForm()
            ],
          ),
        ),
      ),
    );
  }
}

class ContactForm extends StatefulWidget {
  @override
  _ContactFormState createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  Map<String, String> _contactData = {'subject': '', 'message': ''};
  var _isLoading = false;
  void _submit() {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    Provider.of<Auth>(context).contactUs(_contactData);
    // setState(() {
    //   _isLoading=false;
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(
        colors: [
          Colors.grey[300].withOpacity(0.5),
          Colors.grey.withOpacity(0.9)
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        stops: [0, 1],
      )),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    Container(
                      child: TextFormField(
                        validator: (value) =>
                            value.isEmpty ? 'Subject is invalide' : null,
                        onSaved: (value) =>
                            _contactData['subject'] = value.toString(),
                        decoration: new InputDecoration(
                            border: new OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(10.0),
                              ),
                            ),
                            filled: true,
                            labelText: 'Subject',
                            fillColor: Colors.white70),
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.only(left: 0, right: 0, top: 5, bottom: 0),
                      child: TextFormField(
                        maxLines: 7,
                        onSaved: (value) =>
                            _contactData['message'] = value.toString(),
                        validator: (value) =>
                            value.isEmpty ? 'Message is invalide' : null,
                        decoration: new InputDecoration(
                            border: new OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(10.0),
                              ),
                            ),
                            filled: true,
                            labelText: 'Message',
                            hintMaxLines: 5,
                            fillColor: Colors.white70),
                      ),
                    ),
                    _isLoading
                        ? SpinKitWave(
                            color: Colors.blueAccent,
                            size: 35.0,
                            // controller: AnimationController(
                            //     vsync: this,
                            //     duration: const Duration(milliseconds: 1200)),
                          )
                        : SimpleRoundIconButton(
                            backgroundColor: Colors.blueAccent,
                            buttonText: Text(
                              "SEND Message",
                              style: TextStyle(color: Colors.white),
                            ),
                            textColor: Colors.white,
                            icon: Icon(FontAwesomeIcons.mailBulk),
                            onPressed: _submit,
                          )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
