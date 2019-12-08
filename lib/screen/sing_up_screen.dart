import 'package:flutter/material.dart';
import 'dart:math';
import 'package:intl/intl.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import '../provider/blood_provider.dart';
import '../provider/country_provider.dart';

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Stack(
      children: <Widget>[
        Container(
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
        ),
        SingleChildScrollView(
          child: Container(
            width: deviceSize.width,
            height: deviceSize.height - 80,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Flexible(
                  child: Container(
                    margin: EdgeInsets.only(bottom: 20.0, top: 10),
                    padding:
                        EdgeInsets.symmetric(vertical: 6.0, horizontal: 34.0),
                    transform: Matrix4.rotationZ(-8 * pi / 180)
                      ..translate(-10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.deepOrange.shade900,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 8,
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
                ),
                // Flexible(
                //  // flex: deviceSize.width > 600 ? 2 : 1,
                //   child: SingUPCard(),
                // )
                SingUPCard()
              ],
            ),
          ),
        )
      ],
    );
  }
}

class SingUPCard extends StatefulWidget {
  @override
  _SingUPCardState createState() => _SingUPCardState();
}

class _SingUPCardState extends State<SingUPCard> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  Map<String, String> _authData = {
    'phone': '',
    'password': '',
    'password_confirmation': '',
    'name': '',
    'email': '',
    'birth_date': '',
    'date_lastDonation': '',
  };
  final _passwordController = TextEditingController();
  final _dateController = TextEditingController();
  final _dateLastDonController = TextEditingController();
  DateTime _selectedDate;
  String _mySelection;
  String _mySelectionCity;
  String _mySelectionBloodType;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  var _isInit = true;
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    if (_isInit) {
      Provider.of<CountryProvider>(context, listen: false).getCounrtyData();
      Provider.of<BloodProvider>(context, listen: false).getBloodType();
    }
    _isInit = false;
    super.didChangeDependencies();
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
    var _isLoading = false;
    void _submit() async {
      if (!_formKey.currentState.validate()) {
        return;
      }
      _formKey.currentState.save();
      setState(() {
        _isLoading = true;
      });
    }

    return Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        elevation: 8.0,
        child: Container(
          height: deviceSize.height * 0.70,
          width: deviceSize.width * 0.85,
          padding: EdgeInsets.all(10.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Name'),
                    keyboardType: TextInputType.text,
                    validator: (value) =>
                        value.isEmpty ? 'Invalid Name!' : null,
                    onSaved: (value) => _authData['name'] = value,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'email'),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) =>
                        value.isEmpty ? 'Invalid email!' : null,
                    onSaved: (value) => _authData['email'] = value,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Phone'),
                    keyboardType: TextInputType.phone,
                    validator: (value) =>
                        value.isEmpty ? 'Invalid phone!' : null,
                    onSaved: (value) => _authData['phone'] = value,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Birth Date'),
                    keyboardType: TextInputType.datetime,
                    onTap: () {
                      FocusScope.of(context).requestFocus(new FocusNode());
                      _presentDatePicker(_dateController, 1990);
                    },
                    controller: _dateController,
                    validator: (value) =>
                        value.isEmpty ? 'Invalid Birth Date!' : null,
                    onSaved: (value) {
                      _authData['birth_date'] = value;
                    },
                  ),
                  TextFormField(
                    decoration:
                        InputDecoration(labelText: 'Date Last Donation'),
                    keyboardType: TextInputType.datetime,
                    onTap: () {
                      FocusScope.of(context).requestFocus(new FocusNode());
                      _presentDatePicker(_dateLastDonController, 2019);
                    },
                    controller: _dateLastDonController,
                    validator: (value) =>
                        value.isEmpty ? 'Invalid date last Donation!' : null,
                    onSaved: (value) {
                      _authData['date_lastDonation'] = value;
                    },
                  ),
                  Container(
                      height: 65,
                      child: InputDecorator(
                          decoration: InputDecoration(labelText: 'Country'),
                          child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                            hint: Text('Plese Select one'),
                            onChanged: (newValue) {
                              setState(() {
                                _mySelection = newValue;
                                _mySelectionCity = null;
                                Provider.of<CountryProvider>(context,
                                        listen: false)
                                    .clearCityList();
                                Provider.of<CountryProvider>(context,
                                        listen: false)
                                    .getCityData(int.parse(_mySelection));
                              });
                            },
                            value: _mySelection,
                            items: Provider.of<CountryProvider>(context,
                                    listen: false)
                                .items
                                .map((item) {
                              return DropdownMenuItem(
                                value: item['id'].toString(),
                                child: new Text(item['name']),
                              );
                            }).toList(),
                          )))),
                  Container(
                    height: 65,
                    child: InputDecorator(
                      decoration: InputDecoration(labelText: 'City'),
                      child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                        hint: Text('Plese Select one'),
                        isDense: true,
                        onChanged: (newValue) {
                          setState(() {
                            _mySelectionCity = newValue;
                          });
                        },
                        value: _mySelectionCity,
                        items:
                            Provider.of<CountryProvider>(context, listen: false)
                                .cityItems
                                .map((item) {
                          return DropdownMenuItem(
                            value: item['id'].toString(),
                            child: new Text(item['name']),
                          );
                        }).toList(),
                      )),
                    ),
                  ),
                  Container(
                    height: 65,
                    child: InputDecorator(
                      decoration: InputDecoration(labelText: 'BloodType'),
                      child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                        hint: Text('Plese Select one'),
                        onChanged: (newValue) {
                          setState(() {
                            _mySelectionBloodType = newValue;
                          });
                        },
                        value: _mySelectionBloodType,
                        items:
                            Provider.of<BloodProvider>(context, listen: false)
                                .items
                                .map((item) {
                          return DropdownMenuItem(
                            value: item['id'].toString(),
                            child: new Text(item['name']),
                          );
                        }).toList(),
                      )),
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Password'),
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    controller: _passwordController,
                    validator: (value) =>
                        value.isEmpty ? 'Invalid Password!' : null,
                    onSaved: (value) => _authData['password'] = value,
                  ),
                  TextFormField(
                    decoration:
                        InputDecoration(labelText: 'Password Confirmation'),
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    validator: (value) {
                      value.isEmpty ? 'Invalid Password Confirmation!' : null;
                      if (value != _passwordController.text) {
                        return 'Passwords do not match!';
                      }
                    },
                    onSaved: (value) =>
                        _authData['password_confirmation'] = value,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  if (_isLoading)
                    SpinKitWave(
                      color: Theme.of(context).primaryColor,
                      size: 35.0,
                    )
                  else
                    RaisedButton(
                      child: Text('Singup'),
                      onPressed: _submit,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
                      color: Theme.of(context).primaryColor,
                      textColor:
                          Theme.of(context).primaryTextTheme.button.color,
                    ),
                ],
              ),
            ),
          ),
        ));
  }
}
