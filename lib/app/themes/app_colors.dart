import 'package:flutter/material.dart';

class AppColors {
  static const Color backgroundColor = Color(0xFFFFFFFF);
  static const Color biegeBGColor = Color(0xFFF5F5F5);
  // static const Color primaryColor = Color.fromRGBO(198, 40, 40, 1);
  static const Color primaryColor = Color.fromRGBO(0, 0, 0, 1);
  static const Color secondaryColor = Color(0xFF00A693);
  static const Color blackColor = Color(0xFF212121);
  static const Color greyColor = Color(0xFFF5F5F5);
  static const Color blackshadowColor = Color.fromARGB(255, 42, 41, 41);

  static const Color textFieldColor = Color(0xFFFAFAFA);
  // static const Color textFieldColor = Color
  static const Color textWhiteColor = Color(0xFFFFFFFF);
  static const Color textBlackColor = Color(0xFF212121);
  static const Color textGreyColor = Color(0xFF9E9E9E);
  static const Color dividerColor = Color(0xFFEEEEEE);
  static const Color hashTagColor = Color(0xFF246BFD);
  static const Color alertColor = Color(0xFFFF0000);
  static const Color orangeColor = Color(0xFFFF981F);
  static const Color btnGreyColor = Color(0xFF5E5A5B);

  static const Color greenSuccessColor = Color(0xFF4AAF57);

  static LinearGradient linearGradient = const LinearGradient(
    colors: [Color(0xFF02AEA4), Color(0xFF2DD0C6)],
    begin: Alignment.bottomRight,
    end: Alignment.bottomLeft,
  );

  static LinearGradient imageGradient = const LinearGradient(
    colors: [Colors.black12, Colors.black87],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
