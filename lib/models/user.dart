import 'package:flutter/material.dart';

class User with ChangeNotifier {
  final String? id;
  final String? fname;
  final String? lname;
  final String? email;
  final String imageUrl;

  User({
    required this.id,
    required this.fname,
    required this.lname,
    required this.email,
    required this.imageUrl,
  });
}
