import 'package:flutter/material.dart';
import 'package:user_profile/utility/constant.dart';

class MyThemeData {
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: kDarkColor,
    primaryColor: Colors.purple.shade200,
    colorScheme: const ColorScheme.dark(),
    fontFamily: 'OnePlus-Regular',
    iconTheme: IconThemeData(color: Colors.purple.shade200, opacity: 0.8),
  );

  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: kLightColor,
    primaryColor: Colors.grey[700],
    colorScheme: const ColorScheme.light(),
    fontFamily: 'OnePlus-Regular',
    iconTheme: const IconThemeData(color: Colors.red, opacity: 0.8),
  );
}
