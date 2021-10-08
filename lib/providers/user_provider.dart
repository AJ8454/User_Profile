import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:user_profile/models/user.dart';

class UserProvider with ChangeNotifier {
// setter
  List<User> _items = [];

// getter
  List<User> get items {
    return [..._items];
  }

  Future<void> fetchAndSetUser() async {
    var url = 'https://reqres.in/api/users?page=1';

    try {
      final response = await http.get(Uri.parse(url));
      final extractedData = json.decode(response.body);
      List value = extractedData['data'];
      List<User> userData = [];
      for (var user in value) {
        userData.add(User(
          id: user['id'].toString(),
          email: user['email'],
          fname: user['first_name'],
          lname: user['last_name'],
          imageUrl: user['avatar'],
        ));
        _items = userData;
        notifyListeners();
      }
    } catch (e) {
      rethrow;
    }
  }
}
