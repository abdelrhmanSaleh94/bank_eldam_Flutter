import 'package:flutter/material.dart';
import '../thems/app_theme.dart';
import 'package:provider/provider.dart';
import '../provider/country_provider.dart';
import '../provider/blood_provider.dart';
import '../widget/simple_round_button.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../provider/bloodDonation_provider.dart';

class AddDonationScreen extends StatefulWidget {
  static final routeName = '/AddDonationScreen';
  @override
  _AddDonationScreenState createState() => _AddDonationScreenState();
}

class _AddDonationScreenState extends State<AddDonationScreen> {
  String _mySelection;
  String _mySelectionCity;
  String _mySelectionBloodType;
  var _bloodFuture;
  var _countryFuture;
  var _cityFuture;
  @override
  void initState() {
    _countryFuture =
        Provider.of<CountryProvider>(context, listen: false).getCounrtyData();
    _bloodFuture =
        Provider.of<BloodProvider>(context, listen: false).getBloodType();

    super.initState();
  }

  final GlobalKey<FormState> _formkey = GlobalKey();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  Map<String, String> _donationData = {
    'patient_name': '',
    'patient_age': '',
    'blood_type_id': '',
    'bags_num': '',
    'hospital_name': '',
    'hospital_address': '',
    'phone': '',
    'latitude': '',
    'longitude': '',
    'city_id': '',
    'notes': '',
    'latitude': '31.7655598',
    'longitude': '30.7541365'
  };
  void showInSnackBar(String value) {
    _scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(value)));
  }

  var _isLoading = false;
  void _submit() async {
    if (!_formkey.currentState.validate() &&
        _mySelectionBloodType == null &&
        _mySelectionCity == null) {
      showInSnackBar('Check Data ! ');
      return;
    }
    _formkey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    try {
      await Provider.of<BloodDonationProvider>(context)
          .postDonation(_donationData);
      showInSnackBar('Added Donation');
      Navigator.of(context).pop();
    } catch (error) {
      showInSnackBar(error.toString());
      print(error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          'Add Donation',
          style: AppTheme.bottomWhite,
        ),
      ),
      body: Align(
        alignment: Alignment.center,
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          elevation: 8,
          child: Container(
            height: deviceSize.height * 0.85,
            width: deviceSize.width * 0.90,
            padding: EdgeInsets.all(10),
            child: Form(
              key: _formkey,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Name'),
                      keyboardType: TextInputType.text,
                      validator: (value) =>
                          value.isEmpty ? 'Invalid Name!' : null,
                      onSaved: (value) =>
                          _donationData['patient_name'] = value.toString(),
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Age'),
                      keyboardType: TextInputType.number,
                      validator: (value) =>
                          value.isEmpty ? 'Invalid Age!' : null,
                      onSaved: (value) =>
                          _donationData['patient_age'] = value.toString(),
                    ),
                    /**
                     * Blood Type
                     */
                    Container(
                      height: 65,
                      child: InputDecorator(
                        decoration: InputDecoration(labelText: 'BloodType'),
                        child: DropdownButtonHideUnderline(
                            child: FutureBuilder(
                          future: _bloodFuture,
                          builder: (context, dataSnapShot) => DropdownButton(
                            hint: Text('Plese Select one'),
                            onChanged: (newValue) {
                              setState(() {
                                _mySelectionBloodType = newValue;

                                _donationData['blood_type_id'] =
                                    newValue.toString();
                              });
                            },
                            value: _mySelectionBloodType,
                            items: Provider.of<BloodProvider>(context,
                                    listen: false)
                                .items
                                .map((item) {
                              return DropdownMenuItem(
                                value: item['id'].toString(),
                                child: new Text(item['name']),
                              );
                            }).toList(),
                          ),
                        )),
                      ),
                    ),
                    TextFormField(
                        decoration: InputDecoration(labelText: 'Bugs Number'),
                        keyboardType: TextInputType.number,
                        validator: (value) =>
                            value.isEmpty ? 'Invalid Number!' : null,
                        onSaved: (value) =>
                            _donationData['bags_num'] = value.toString()),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Hospital Name'),
                      keyboardType: TextInputType.text,
                      validator: (value) =>
                          value.isEmpty ? 'Invalid Hospital Name!' : null,
                      onSaved: (value) =>
                          _donationData['hospital_name'] = value.toString(),
                    ),
                    TextFormField(
                      decoration:
                          InputDecoration(labelText: 'Hospital Address'),
                      keyboardType: TextInputType.text,
                      validator: (value) =>
                          value.isEmpty ? 'Invalid Hospital Address!' : null,
                      onSaved: (value) =>
                          _donationData['hospital_address'] = value.toString(),
                    ),
                    /**
                     * 2 bouttom Chocie Lang and lat
                     */
                    /**
                     * city and govenrate
                     */
                    Container(
                        height: 65,
                        child: InputDecorator(
                            decoration: InputDecoration(labelText: 'Country'),
                            child: DropdownButtonHideUnderline(
                                child: FutureBuilder(
                              future: _countryFuture,
                              builder: (contxt, dataSnapshot) => DropdownButton(
                                hint: Text('Plese Select one'),
                                onChanged: (newValue) {
                                  setState(() {
                                    _mySelection = newValue;
                                    _mySelectionCity = null;
                                    Provider.of<CountryProvider>(context,
                                            listen: false)
                                        .clearCityList();
                                    _cityFuture = Provider.of<CountryProvider>(
                                            context,
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
                              ),
                            )))),
                    Container(
                      height: 65,
                      child: InputDecorator(
                        decoration: InputDecoration(labelText: 'City'),
                        child: DropdownButtonHideUnderline(
                            child: FutureBuilder(
                          future: _cityFuture,
                          builder: (context, snapShote) => DropdownButton(
                            hint: Text('Plese Select one'),
                            isDense: true,
                            onChanged: (newValue) {
                              setState(() {
                                _mySelectionCity = newValue;

                                _donationData['city_id'] = newValue.toString();
                              });
                            },
                            value: _mySelectionCity,
                            items: Provider.of<CountryProvider>(context,
                                    listen: false)
                                .cityItems
                                .map((item) {
                              return DropdownMenuItem(
                                value: item['id'].toString(),
                                child: new Text(item['name']),
                              );
                            }).toList(),
                          ),
                        )),
                      ),
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Phone'),
                      keyboardType: TextInputType.phone,
                      validator: (value) =>
                          value.isEmpty ? 'Invalid Phone!' : null,
                      onSaved: (value) =>
                          _donationData['phone'] = value.toString(),
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Notes'),
                      keyboardType: TextInputType.text,
                      maxLines: 5,
                      validator: (value) =>
                          value.isEmpty ? 'Invalid Notes!' : null,
                      onSaved: (value) =>
                          _donationData['notes'] = value.toString(),
                    ),
                    _isLoading
                        ? SpinKitWave(
                            color: Colors.orangeAccent,
                            size: 35.0,
                            // controller: AnimationController(
                            //     vsync: this,
                            //     duration: const Duration(milliseconds: 1200)),
                          )
                        : SimpleRoundIconButton(
                            backgroundColor: Colors.orangeAccent,
                            buttonText: Text(
                              "SEND REQUEST",
                              style: TextStyle(color: Colors.white),
                            ),
                            textColor: Colors.white,
                            icon: Icon(Icons.note_add),
                            onPressed: _submit,
                          )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
