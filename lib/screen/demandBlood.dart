import 'package:bank_eldam/thems/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../widget/donetion_card.dart';
import 'package:provider/provider.dart';
import '../provider/bloodDonation_provider.dart';
import './add_donation.dart';

class DemandBlood extends StatefulWidget {
  @override
  _DemandBloodState createState() => _DemandBloodState();
}

class _DemandBloodState extends State<DemandBlood> {
  Future _futur;
  ScrollController controller;
  int page = 1;
  @override
  void initState() {
    controller = new ScrollController()..addListener(_scrollListener);

    _futur = Provider.of<BloodDonationProvider>(context, listen: false)
        .fetchDonations(page);
    super.initState();
  }

  void _scrollListener() {
    var props = Provider.of<BloodDonationProvider>(context, listen: false);
    if (controller.position.pixels == controller.position.maxScrollExtent) {
      print("Reached end");
      if (props.lastPage > page) {
        page++;
        print("UI page: $page");
        props.fetchDonations(page);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: _futur,
          builder: (context, dataSnapshot) {
            if (dataSnapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (dataSnapshot.error != null) {
                return Center(
                  child: Text(dataSnapshot.error.toString()),
                );
              } else {
                return Consumer<BloodDonationProvider>(
                  builder: (ctx, don, child) => ListView.builder(
                    controller: controller,
                    itemCount: don.doanationItesm.length,
                    itemBuilder: (ctx, i) => DonationCard(
                      id: don.doanationItesm[i].id,
                      city: don.doanationItesm[i].city.name,
                      hostpital: don.doanationItesm[i].hospitalName,
                      name: don.doanationItesm[i].patientName,
                      phone: don.doanationItesm[i].phone,
                      bloodType: don.doanationItesm[i].bloodType.name,
                    ),
                  ),
                );
              }
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed( AddDonationScreen.routeName);
        },
        child: Icon(FontAwesomeIcons.notesMedical, color: Colors.red),
        backgroundColor: AppTheme.nearlyWhite,
        elevation: 10,
      ),
    );
  }
}
