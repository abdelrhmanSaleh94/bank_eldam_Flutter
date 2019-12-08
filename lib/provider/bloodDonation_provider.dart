import 'package:flutter/foundation.dart';
import 'dart:async';
import 'dart:core';
import 'dart:convert';
import 'package:http/http.dart' as http;

class DonationItem {
  final String id;
  final String createdAt;
  final String clientId;
  final String patientName;
  final String patientAge;
  final BloodTypeDon bloodType;
  final String bagsNum;
  final String hospitalName;
  final String hospitalAddress;
  final CityDon city;
  final String phone;
  final String notes;
  final String latitude;
  final String longitude;

  DonationItem(
      {@required this.id,
      @required this.createdAt,
      @required this.clientId,
      @required this.patientName,
      @required this.patientAge,
      @required this.bloodType,
      @required this.bagsNum,
      @required this.hospitalName,
      @required this.hospitalAddress,
      @required this.city,
      @required this.phone,
      @required this.notes,
      @required this.latitude,
      @required this.longitude});
}

class BloodTypeDon {
  final String id;
  final String name;
  BloodTypeDon({@required this.name, @required this.id});
}

class CityDon {
  final String id;
  final String name;
  final GovernorateDon governorate;
  CityDon({@required this.name, @required this.id, @required this.governorate});
}

class GovernorateDon {
  final String id;
  final String name;
  GovernorateDon({@required this.name, @required this.id});
}

class BloodDonationProvider with ChangeNotifier {
  List<DonationItem> _doanationItesms = [];
  int lastPage;
  List<DonationItem> get doanationItesm {
    return [..._doanationItesms];
  }

  void addDoanationItem(DonationItem donationItem) {
    _doanationItesms.add(donationItem);
    notifyListeners();
  }

  int get finalPage {
    return this.lastPage;
  }

  Future<void> postDonation(Map<String, String> donationDetils) async {
    try {
      final url = 'http://ipda3.com/blood-bank/api/v1/donation-request/create';
      final response = await http.post(url,
          headers: {"Content-Type": "application/json"},
          body: json.encode({
            'api_token':
                'gmJvWU4h4yS1RRYPm1k8BLTrU9LYZFJ1jZuus7DMXIvf9WGgx57BLECg7sw0',
            'patient_name': donationDetils['patient_name'],
            'patient_age': donationDetils['patient_age'],
            'blood_type_id': donationDetils['blood_type_id'],
            'bags_num': donationDetils['bags_num'],
            'hospital_name': donationDetils['hospital_name'],
            'hospital_address': donationDetils['hospital_address'],
            'phone': donationDetils['phone'],
            'latitude': donationDetils['latitude'],
            'longitude': donationDetils['longitude'],
            'city_id': donationDetils['city_id'],
            'notes': donationDetils['notes']
          }),
          encoding: Encoding.getByName("utf-8"));
      final responseData = json.decode(response.body);
      print(responseData['msg']);
      print(responseData['data']);
    //   var data = responseData['data']['donationRequest'];
    // //  await _doanationItesms.add(DonationItem(
    // //     id: data['id'].toString(),
    // //     bagsNum: data['bags_num'],
    // //     bloodType: BloodTypeDon(
    // //         id: data['blood_type']['id'].toString(),
    // //         name: data['blood_type']['name']),
    // //     phone: data['phone'],
    // //     city: CityDon(
    // //         name: data['city']['name'],
    // //         id: data['city']['id'].toString(),
    // //         governorate: GovernorateDon(
    // //           name: data['city']['governorate']['name'],
    // //           id: data['city']['governorate']['id'].toString(),
    // //         )),
    // //     clientId: data['client_id'].toString(),
    // //     createdAt: data['created_at'],
    // //     hospitalAddress: data['hospital_address'],
    // //     hospitalName: data['hospital_name'],
    // //     latitude: data['latitude'],
    // //     longitude: data['longitude'],
    // //     notes: data['notes'],
    // //     patientAge: data['patient_age'],
    // //     patientName: data['patient_name'],
    // //   ));
     // notifyListeners();
     _doanationItesms.clear();
     fetchDonations(1);
    } catch (error) {
      throw error;
    }
  }

  DonationItem findById(String id) {
    return _doanationItesms.firstWhere((post) => post.id == id);
  }

  Future<void> fetchDonations(int page) async {
    var url =
        'http://ipda3.com/blood-bank/api/v1/donation-requests?api_token=W4mx3VMIWetLcvEcyF554CfxjZHwdtQldbdlCl2XAaBTDIpNjKO1f7CHuwKl&page=$page';
    try {
      final response = await http.get(url);
      final List<DonationItem> loadDonation = [];
      final extractData = json.decode(response.body) as Map<String, dynamic>;
      if (extractData['status'] != 1) {
        return;
      }
      lastPage = extractData['data']['last_page'];
      List data = extractData['data']['data'];

      for (var i = 0; i < data.length; i++) {
        loadDonation.add(DonationItem(
            id: data[i]['id'].toString(),
            bagsNum: data[i]['bags_num'],
            notes: data[i]['notes'],
            bloodType: BloodTypeDon(
                id: data[i]['blood_type']['id'].toString(),
                name: data[i]['blood_type']['name']),
            createdAt: data[i]['created_at'],
            hospitalAddress: data[i]['hospital_address'],
            hospitalName: data[i]['hospital_name'],
            latitude: data[i]['latitude'],
            longitude: data[i]['longitude'],
            patientAge: data[i]['patient_age'],
            patientName: data[i]['patient_name'],
            phone: data[i]['phone'],
            city: CityDon(
                id: data[i]['city']['id'].toString(),
                name: data[i]['city']['name'],
                governorate: GovernorateDon(
                    id: data[i]['city']['governorate']['id'].toString(),
                    name: data[i]['city']['governorate']['name'])),
            clientId: data[i]['client_id'].toString()));
      }
      _doanationItesms.addAll(loadDonation);
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
}
