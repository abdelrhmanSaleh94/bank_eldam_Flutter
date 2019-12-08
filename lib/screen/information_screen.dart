import 'package:flutter/material.dart';
import '../thems/app_theme.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../widget/home_drawer.dart';
import 'dart:math';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../provider/country_provider.dart';
import '../provider/blood_provider.dart';

class InformationScreen extends StatefulWidget {
  static final routeName = '/InformationScreen';

  @override
  _InformationScreenState createState() => _InformationScreenState();
}

class _InformationScreenState extends State<InformationScreen> {
  bool _isPhoneEdite = false;
  bool _isNameEdite = false;
  bool _isEmailEdite = false;
  bool _isCityEdite = false;
  bool _isBloodTypeEdite = false;
  bool _isPassEdite = false;
  String _mySelection;
  String _mySelectionCity;
  String _mySelectionBloodType = 'A+';
  var _cityFuture;
  DateTime _selectedDate;

  final _phoneController = TextEditingController();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _birthdateController = TextEditingController();

  @override
  void initState() {
    _phoneController.text = '01098046024';
    _nameController.text = 'Abdelrhman Saleh';
    _emailController.text = 'abdelrhman94saleh@gamil.com';
    _birthdateController.text = DateFormat.yMMMd().format(DateTime.now());
    super.initState();
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _birthdateController.dispose();
    super.dispose();
  }

  void _presentDatePicker(TextEditingController controller, int firstYear) {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(firstYear),
            lastDate: DateTime.now())
        .then((value) {
      if (value == null) {
        return;
      }
      setState(() {
        _selectedDate = value;
        controller.text = DateFormat.yMMMd().format(_selectedDate);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      drawer: HomeDrawer(),
      appBar: AppBar(
        title: Text(
          'Information',
          style: AppTheme.bottomWhite,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
            width: deviceSize.width,
            child: Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
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
                      trailing: !_isNameEdite
                          ? IconButton(
                              icon: Icon(FontAwesomeIcons.edit),
                              onPressed: () {
                                setState(() {
                                  _isNameEdite = true;
                                });
                              },
                              iconSize: 25,
                            )
                          : IconButton(
                              icon: Icon(
                                FontAwesomeIcons.solidSave,
                                color: Colors.blueAccent,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isNameEdite = false;
                                });
                              },
                              iconSize: 25,
                            ),
                      title: Text('Name'),
                      subtitle: !_isNameEdite
                          ? Text(_nameController.text)
                          : TextField(
                              //  decoration: InputDecoration(labelText: 'Phone'),
                              controller: _nameController,
                              keyboardAppearance: Brightness.dark,
                              keyboardType: TextInputType.text,
                              maxLines: 1,
                            ),
                    ),
                    ListTile(
                      trailing: !_isPhoneEdite
                          ? IconButton(
                              icon: Icon(FontAwesomeIcons.edit),
                              onPressed: () {
                                setState(() {
                                  _isPhoneEdite = true;
                                });
                              },
                              iconSize: 25,
                            )
                          : IconButton(
                              icon: Icon(
                                FontAwesomeIcons.solidSave,
                                color: Colors.blueAccent,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isPhoneEdite = false;
                                });
                              },
                              iconSize: 25,
                            ),
                      title: Text('Phone'),
                      subtitle: !_isPhoneEdite
                          ? Text(_phoneController.text)
                          : TextField(
                              //  decoration: InputDecoration(labelText: 'Phone'),
                              maxLength: 11,
                              controller: _phoneController,
                              keyboardAppearance: Brightness.dark,
                              keyboardType: TextInputType.phone,
                            ),
                    ),
                    ListTile(
                      trailing: !_isEmailEdite
                          ? IconButton(
                              icon: Icon(FontAwesomeIcons.edit),
                              onPressed: () {
                                setState(() {
                                  _isEmailEdite = true;
                                });
                              },
                              iconSize: 25,
                            )
                          : IconButton(
                              icon: Icon(
                                FontAwesomeIcons.solidSave,
                                color: Colors.blueAccent,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isEmailEdite = false;
                                });
                              },
                              iconSize: 25,
                            ),
                      title: Text('Email'),
                      subtitle: !_isEmailEdite
                          ? Text(_emailController.text)
                          : TextField(
                              //  decoration: InputDecoration(labelText: 'Phone'),
                              controller: _emailController,
                              keyboardAppearance: Brightness.dark,
                              keyboardType: TextInputType.emailAddress,
                            ),
                    ),
                    ListTile(
                      trailing: IconButton(
                        icon: Icon(FontAwesomeIcons.edit),
                        onPressed: () {
                          _presentDatePicker(_birthdateController, 1980);
                        },
                        iconSize: 25,
                      ),
                      title: Text('BirthDate'),
                      subtitle: Text(_birthdateController.text),
                    ),
                    ListTile(
                      trailing: !_isCityEdite
                          ? IconButton(
                              icon: Icon(FontAwesomeIcons.edit),
                              onPressed: () {
                                setState(() {
                                  _isCityEdite = true;
                                });
                              },
                              iconSize: 25,
                            )
                          : IconButton(
                              icon: Icon(
                                FontAwesomeIcons.solidSave,
                                color: Colors.blueAccent,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isCityEdite = false;
                                });
                              },
                              iconSize: 25,
                            ),
                      title: Text('City'),
                      subtitle: _isCityEdite
                          ? Column(
                              children: <Widget>[
                                Container(
                                    height: 65,
                                    child: InputDecorator(
                                        decoration: InputDecoration(
                                            labelText: 'Country'),
                                        child: DropdownButtonHideUnderline(
                                            child: FutureBuilder(
                                          future: Provider.of<CountryProvider>(
                                                  context,
                                                  listen: false)
                                              .getCounrtyData(),
                                          builder: (contxt, dataSnapshot) =>
                                              DropdownButton(
                                            hint: Text('Plese Select one'),
                                            onChanged: (newValue) {
                                              setState(() {
                                                _mySelection = newValue;
                                                _mySelectionCity = null;
                                                Provider.of<CountryProvider>(
                                                        context,
                                                        listen: false)
                                                    .clearCityList();
                                                _cityFuture = Provider.of<
                                                            CountryProvider>(
                                                        context,
                                                        listen: false)
                                                    .getCityData(int.parse(
                                                        _mySelection));
                                              });
                                            },
                                            value: _mySelection,
                                            items: Provider.of<CountryProvider>(
                                                    context,
                                                    listen: false)
                                                .items
                                                .map((item) {
                                              return DropdownMenuItem(
                                                value: item['id'].toString(),
                                                child: Text(item['name']),
                                              );
                                            }).toList(),
                                          ),
                                        )))),
                                Container(
                                  height: 65,
                                  child: InputDecorator(
                                    decoration:
                                        InputDecoration(labelText: 'City'),
                                    child: DropdownButtonHideUnderline(
                                        child: FutureBuilder(
                                      future: _cityFuture,
                                      builder: (context, snapShote) =>
                                          DropdownButton(
                                        hint: Text('Plese Select one'),
                                        isDense: true,
                                        onChanged: (newValue) {
                                          setState(() {
                                            _mySelectionCity = newValue;
                                          });
                                        },
                                        value: _mySelectionCity,
                                        items: Provider.of<CountryProvider>(
                                                context,
                                                listen: false)
                                            .cityItems
                                            .map((item) {
                                          return DropdownMenuItem(
                                            value: item['name'],
                                            child: new Text(item['name']),
                                          );
                                        }).toList(),
                                      ),
                                    )),
                                  ),
                                ),
                              ],
                            )
                          : Text(
                              '$_mySelectionCity,',
                            ),
                    )
                  ],
                ),
              ),
              ListTile(
                trailing: !_isBloodTypeEdite
                    ? IconButton(
                        icon: Icon(FontAwesomeIcons.edit),
                        onPressed: () {
                          setState(() {
                            _isBloodTypeEdite = true;
                          });
                        },
                        iconSize: 25,
                      )
                    : IconButton(
                        icon: Icon(
                          FontAwesomeIcons.solidSave,
                          color: Colors.blueAccent,
                        ),
                        onPressed: () {
                          setState(() {
                            _isBloodTypeEdite = false;
                          });
                        },
                        iconSize: 25,
                      ),
                title: Text('Blood Type'),
                subtitle: !_isBloodTypeEdite
                    ? Text(_mySelectionBloodType)
                    : Container(
                        height: 65,
                        child: InputDecorator(
                          decoration: InputDecoration(labelText: 'BloodType'),
                          child: DropdownButtonHideUnderline(
                              child: FutureBuilder(
                            future: Provider.of<BloodProvider>(context,
                                    listen: false)
                                .getBloodType(),
                            builder: (context, dataSnapShot) => DropdownButton(
                              hint: Text('Plese Select one'),
                              onChanged: (newValue) {
                                setState(() {
                                  _mySelectionBloodType = newValue.toString();
                                });
                              },
                              value: _mySelectionBloodType,
                              items: Provider.of<BloodProvider>(context,
                                      listen: false)
                                  .items
                                  .map((item) {
                                return DropdownMenuItem(
                                  value: item['name'].toString(),
                                  child: new Text(item['name']),
                                );
                              }).toList(),
                            ),
                          )),
                        ),
                      ),
              ),
              ListTile(
                  trailing: !_isPassEdite
                      ? IconButton(
                          icon: Icon(FontAwesomeIcons.edit),
                          onPressed: () {
                            setState(() {
                              _isPassEdite = true;
                            });
                          },
                          iconSize: 25,
                        )
                      : IconButton(
                          icon: Icon(
                            FontAwesomeIcons.solidSave,
                            color: Colors.blueAccent,
                          ),
                          onPressed: () {
                            setState(() {
                              _isPassEdite = false;
                            });
                          },
                          iconSize: 25,
                        ),
                  title: Text('Password'),
                  subtitle: !_isPassEdite
                      ? Text('********************')
                      : Column(
                          children: <Widget>[
                            TextField(
                              decoration:
                                  InputDecoration(labelText: 'Old Password'),
                              obscureText: true,
                              keyboardAppearance: Brightness.dark,
                              keyboardType: TextInputType.visiblePassword,
                            ),
                            TextField(
                              decoration:
                                  InputDecoration(labelText: 'New Password'),
                              obscureText: true,
                              keyboardAppearance: Brightness.dark,
                              keyboardType: TextInputType.visiblePassword,
                            ),
                          ],
                        )),
            ])),
      ),
    );
  }
}
