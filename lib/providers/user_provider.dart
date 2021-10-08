import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserProvider with ChangeNotifier {
  Future<void> fetchAndSetUser() async {
    var url = 'https://reqres.in/api/users?page=1';

    try {
      final response = await http.get(Uri.parse(url));
      print(response);
    } catch (e) {}
  }
}
