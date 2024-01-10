import 'package:apd_app/styles/color.dart';
import 'package:flutter/material.dart';

ThemeData Style() {
  return ThemeData(
    fontFamily: 'Kanit',
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            fixedSize: Size(150, 70),
            backgroundColor: AppColor.darkWidget,
            foregroundColor: AppColor.darkPrimary,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50)))),
  );
}
