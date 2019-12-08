import '../thems/app_theme.dart';
import 'package:flutter/material.dart';
import '../provider/bloodDonation_provider.dart';
import 'package:provider/provider.dart';
import '../helper/location_helper.dart';
import 'dart:core';
import '../widget/userInformation.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class DonationaDetails extends StatefulWidget {
  static final routeName = '/DonationaDetails';

  @override
  _DonationaDetailsState createState() => _DonationaDetailsState();
}

class _DonationaDetailsState extends State<DonationaDetails> {
  String _imagePath;
  @override
  Widget build(BuildContext context) {
    final donationId = ModalRoute.of(context).settings.arguments as String;
    final donationaDetails =
        Provider.of<BloodDonationProvider>(context, listen: false)
            .findById(donationId);
    setState(() {
      _imagePath = LocationHelper.generateLocationPreviewImage(
          latitude: double.parse(donationaDetails.longitude),
          longitude: double.parse(donationaDetails.latitude));
      print(donationaDetails.latitude);
    });
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
              title: Text('بنك الدم'),
              pinned: true,
              expandedHeight: 220.0,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.network(
                  _imagePath,
                  fit: BoxFit.cover,
                ),
              ),
              ),
          SliverList(
            delegate: SliverChildListDelegate([
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                    padding:
                        EdgeInsets.only(top: 5, right: 5, left: 5, bottom: 5),
                    child: Card(
                      elevation: 8,
                      child: Container(
                        margin: EdgeInsets.only(
                            top: 10, bottom: 10, right: 5, left: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Icon(Icons.schedule),
                                SizedBox(
                                  width: 6,
                                ),
                                Text(
                                  donationaDetails.createdAt,
                                  style: AppTheme.subtitle,
                                )
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Icon(FontAwesomeIcons.userInjured),
                                SizedBox(
                                  width: 6,
                                ),
                                Text(
                                  donationaDetails.bloodType.name,
                                  style: AppTheme.display1,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  UserInformation(donationaDetails),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.all(15),
                    child: RaisedButton.icon(
                      icon: Icon(
                        Icons.call,
                        color: AppTheme.nearlyWhite,
                      ),
                      label: Text(
                        'Call',
                        style: AppTheme.bottomWhite,
                      ),
                      onPressed: () {
                        UrlLauncher.launch('tel:${donationaDetails.phone}');
                      },
                      elevation: 5,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      color: AppTheme.call_green,
                    ),
                  )
                ],
              )
            ]),
          )
        ],
      ),
    );
  }
}
