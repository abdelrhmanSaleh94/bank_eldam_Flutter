import '../provider/bloodDonation_provider.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import '../thems/app_theme.dart';

class UserInformation extends StatefulWidget {
  final DonationItem donationaDetails;
  UserInformation(this.donationaDetails);

  @override
  _UserInformationState createState() => _UserInformationState();
}

class _UserInformationState extends State<UserInformation> {
  var _expanded = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height: _expanded ? min(7 * 20.0 + 170, 600) : 95,
      child: Card(
        margin: EdgeInsets.all(10),
        child: Container(
          child: Column(
            children: <Widget>[
              ListTile(
                title: Text(
                  widget.donationaDetails.patientName,
                  style: AppTheme.title,
                  softWrap: true,
                ),
                subtitle: Text(
                  '${widget.donationaDetails.bagsNum}\t,\t${widget.donationaDetails.bloodType.name}',
                  style: AppTheme.subtitle,
                ),
                trailing: IconButton(
                  icon:
                      Icon(!_expanded ? Icons.expand_more : Icons.expand_less),
                  onPressed: () {
                    setState(() {
                      _expanded = !_expanded;
                    });
                  },
                ),
              ),
              AnimatedContainer(
                duration: Duration(milliseconds: 300),
                height: _expanded ? min(10 * 20.0 + 10, 300) : 0,
                padding: EdgeInsets.symmetric(vertical: 4, horizontal: 5),
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        trailing: Text(
                          widget.donationaDetails.patientName,
                          style: TextStyle(
                            fontSize: 18,
                          ),
                          softWrap: true,
                        ),
                        title: Text(
                          'Name',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      //////////////////////////////////////
                      Divider(),
                      ListTile(
                          title: Text(
                            'Age',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          trailing: Text(
                            widget.donationaDetails.patientAge,
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey,
                            ),
                            softWrap: true,
                          )),
                      ///////////////////////////
                      Divider(),
                      ListTile(
                          title: Text(
                            'number Of Bugs',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                            softWrap: true,
                          ),
                          trailing: Text(
                            widget.donationaDetails.bagsNum,
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey,
                            ),
                            softWrap: true,
                          )),
                      Divider(),
                      ListTile(
                          title: Text(
                            'Hospital Name',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                            softWrap: true,
                          ),
                          subtitle: Text(
                            widget.donationaDetails.hospitalName,
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey,
                            ),
                            softWrap: true,
                          )),
                      /////////////////////////////////
                      ///
                      Divider(),

                      ListTile(
                        title: Text(
                          'Phone',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                          softWrap: true,
                        ),
                        subtitle: Text(
                          widget.donationaDetails.phone,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                          ),
                          softWrap: true,
                        ),
                      ),
                      Divider(),

                      ListTile(
                        title: Text(
                          'Hospital Adrress',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(widget.donationaDetails.hospitalAddress,
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey,
                            ),
                            softWrap: true,
                            textAlign: TextAlign.justify),
                      ),
                      ////////////////////////
                      ///
                      Divider(),

                      ListTile(
                        title: Text(
                          'Notes',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.start,
                        ),
                        subtitle: Text(
                          // 'هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربى، حيث يمكنك أن تولد مثل هذا النص أو العديد من النصوص الأخرى إضافة إلى زيادة عدد الحروف التى يولدها التطبيق',
                          widget.donationaDetails.notes,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                          ),
                          softWrap: true,
                          textAlign: TextAlign.justify,
                          textDirection: TextDirection.rtl,
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
