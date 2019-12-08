import 'package:flutter/material.dart';
import '../widget/home_drawer.dart';
import '../thems/app_theme.dart';
import 'package:provider/provider.dart';
import '../provider/blood_provider.dart';
import '../provider/country_provider.dart';
import '../widget/simple_round_button.dart';

class NetficationSettingScreen extends StatefulWidget {
  static final routeName = 'NetficationSettingScreen';
  @override
  _NetficationSettingScreenState createState() =>
      _NetficationSettingScreenState();
}

class _NetficationSettingScreenState extends State<NetficationSettingScreen> {
  var future;
  var bloodFuture;

  List _selecteBlood = [];
  List _selectCountry = [];
  @override
  void initState() {
    future =
        Provider.of<CountryProvider>(context, listen: false).getCounrtyData();
    bloodFuture =
        Provider.of<BloodProvider>(context, listen: false).getBloodType();
    super.initState();
  }

  void _onBloodSelected(bool selected, blood_id) {
    if (selected == true) {
      setState(() {
        _selecteBlood.add(blood_id);
      });
    } else {
      setState(() {
        _selecteBlood.remove(blood_id);
      });
    }
  }

  void _onCountrySelected(bool selected, countryId) {
    if (selected == true) {
      setState(() {
        _selectCountry.add(countryId);
      });
    } else {
      setState(() {
        _selectCountry.remove(countryId);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Notification Setting'),
      ),
      drawer: HomeDrawer(),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                color: AppTheme.nearlyWhite,
                elevation: 5,
                // margin: EdgeInsets.all(8),
                child: Column(
                  // mainAxisSize: MainAxisSize.max,
                  // crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      padding:
                          EdgeInsets.only(left: 0, bottom: 5, top: 5, right: 8),
                      child: Text(
                        'Country',
                        style: AppTheme.bottomWhite,
                        textAlign: TextAlign.right,
                      ),
                      color: AppTheme.grey,
                    ),
                    FutureBuilder(
                      future: future,
                      builder: (context, dataSnapshot) {
                        if (dataSnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          if (dataSnapshot.error != null) {
                            return Center(
                              child: Text('Error Data'),
                            );
                          } else {
                            return Consumer<CountryProvider>(
                                builder: (ctx, countrypProvider, child) =>
                                    GridView.count(
                                      shrinkWrap: true,
                                      crossAxisCount:
                                          deviceSize.width >= 600 ? 3 : 2,
                                      mainAxisSpacing: 3.0,
                                      crossAxisSpacing: 3.0,
                                      childAspectRatio: 2.5,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      padding: const EdgeInsets.all(4.0),
                                      children: countrypProvider.items
                                          .map((country) => GridTile(
                                                child: CheckboxListTile(
                                                  title: Text(country['name']),
                                                  onChanged: (bool value) {
                                                    _onCountrySelected(
                                                        value, country['id']);
                                                  },
                                                  value:
                                                      _selectCountry.contains(
                                                              country['id'])
                                                          ? true
                                                          : false,
                                                ),
                                              ))
                                          .toList(),
                                    ));
                            // Center(child: Text('Data')));
                          }
                        }
                      },
                    )
                  ],
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                color: AppTheme.nearlyWhite,
                elevation: 5,
                child: Column(
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      padding:
                          EdgeInsets.only(left: 0, bottom: 5, top: 5, right: 8),
                      child: Text(
                        'Blood Type',
                        style: AppTheme.bottomWhite,
                        textAlign: TextAlign.right,
                      ),
                      color: AppTheme.grey,
                    ),
                    FutureBuilder(
                      future: bloodFuture,
                      builder: (context, dataSnapshot) {
                        if (dataSnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          if (dataSnapshot.error != null) {
                            return Center(
                              child: Text('Error Data'),
                            );
                          } else {
                            return Consumer<BloodProvider>(
                                builder: (ctx, bloodT, child) => GridView.count(
                                      shrinkWrap: true,
                                      crossAxisCount:
                                          deviceSize.width >= 600 ? 3 : 2,
                                      mainAxisSpacing: 1.0,
                                      crossAxisSpacing: 1.0,
                                      childAspectRatio: 2.5,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      padding: const EdgeInsets.all(2.0),
                                      children: bloodT.items
                                          .map((country) => GridTile(
                                                child: CheckboxListTile(
                                                  title: Text(country['name']),
                                                  onChanged: (bool value) {
                                                    _onBloodSelected(
                                                        value, country['id']);
                                                  },
                                                  value: _selecteBlood.contains(
                                                          country['id'])
                                                      ? true
                                                      : false,
                                                ),
                                              ))
                                          .toList(),
                                    ));
                            // Center(child: Text('Data')));
                          }
                        }
                      },
                    ),
                  ],
                ),
              ),
              SimpleRoundIconButton(
                backgroundColor: Colors.orangeAccent,
                buttonText: Text(
                  "Save",
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                textColor: Colors.white,
                icon: Icon(Icons.note_add),
                onPressed: () {
                  print(_selecteBlood);
                  print(_selectCountry);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
