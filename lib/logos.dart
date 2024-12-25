import 'package:flutter/material.dart';

class Logos {
  static const String logoPath = 'assets/images/main_logo.png';
  static Widget appLogo() {
    return Image.asset(
      logoPath,
      width: 160,
      height: 160,
    );
  }
}
