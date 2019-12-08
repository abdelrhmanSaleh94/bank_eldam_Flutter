import 'dart:convert';
import 'dart:async';
import 'dart:core';
import 'package:http/http.dart' as http;
import 'package:flutter/widgets.dart';
import '../helper/http_exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  String _token;
  int _status;
  String get userToken {
    return _token;
  }

  int get status {
    return _status;
  }

  String _messaage;
  String get messaage {
    return _messaage;
  }

  Future<void> login(String phone, String password) async {
    try {
      final url = 'http://ipda3-tech.com/blood-bank/api/v1/login';

      final response = await http.post(url,
          headers: {"Content-Type": "application/json"},
          body: json.encode({
            "phone": phone,
            "password": password,
          }),
          encoding: Encoding.getByName("utf-8"));
      final responseData = json.decode(response.body);
      _messaage = responseData['msg'];
      _status = responseData['status'];
      if (_status!=1) {
        throw HttpException(responseData['msg']);
      }
      print(responseData['msg']);
      print(responseData['data']);
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('userData', responseData['data']['api_token']);
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> getData() async {
    final url =
        'http://ipda3.com/blood-bank/api/v1/posts?api_token=Zz9HuAjCY4kw2Ma2XaA6x7T5O3UODws1UakXI9vgFVSoY3xUXYOarHX2VH27&page=1';
    final response = await http.get(url);
    final responseData = json.decode(response.body);

    print(responseData['msg']);
    print(responseData['data']);
    notifyListeners();
  }

  Future<void> contactUs(Map<String, String> contactData) async {
    final url = 'http://ipda3.com/blood-bank/api/v1/contact';
    final response = await http.post(url,
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          'api_token':
              'gmJvWU4h4yS1RRYPm1k8BLTrU9LYZFJ1jZuus7DMXIvf9WGgx57BLECg7sw0',
          'title': contactData['subject'],
          'message': contactData['message']
        }));
    final responseData = json.decode(response.body);

    print(responseData['msg']);
    print(responseData['data']);
    notifyListeners();
  }
}
