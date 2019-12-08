import 'package:flutter/foundation.dart';
import 'dart:async';
import 'dart:core';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CountryItem {
  final int id;
  final String name;
  CountryItem({@required this.id, @required this.name});
}

class CountryProvider with ChangeNotifier {
  List _items = [];
  List get items {
    return [..._items];
  }

  List _cityItems = [];
  List get cityItems {
    return [..._cityItems];
  }

  void clearCityList() {
    _cityItems.clear();
  }

  Future<String> getCounrtyData() async {
    final url = 'http://ipda3.com/blood-bank/api/v1/governorates';
    final response = await http.get(url);
    final extractData = json.decode(response.body) as Map<String, dynamic>;
    _items = extractData['data'];
    notifyListeners();
    return 'sucess';
  }

  

  Future<void> getCityData(int cityId) async {
    final url =
        'http://ipda3.com/blood-bank/api/v1/cities?governorate_id=$cityId';
    final response =
        await http.get(url, headers: {"Accept": "application/json"});
    final extractData = json.decode(response.body) as Map<String, dynamic>;
    _cityItems = extractData['data'];
    notifyListeners();
  }
}
