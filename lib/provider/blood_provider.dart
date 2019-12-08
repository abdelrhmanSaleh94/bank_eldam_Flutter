import 'package:flutter/foundation.dart';
import 'dart:async';
import 'dart:core';
import 'dart:convert';
import 'package:http/http.dart' as http;

class BloodProvider with ChangeNotifier {
  List _items = [];
  List get items {
    return [..._items];
  }

  Future<void> getBloodType() async {
    final url = 'http://ipda3.com/blood-bank/api/v1/blood-types';
    final response = await http.get(url);
    final extractData = json.decode(response.body) as Map<String, dynamic>;
    _items = extractData['data'];
    notifyListeners();
  }
}
