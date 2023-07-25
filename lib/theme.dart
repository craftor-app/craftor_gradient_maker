// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class AppTheme {
  static const Color selectedColor = Color(0xFF2E2E30);
  static const Color unselectedBgColor = Color(0xFF0D0D0D);
  static const Color selectedSelectedColor = Color(0xFF555556);
  static const Color bgColor = Color(0xFF252525);
  static const Color textColor = Color(0xFF959595);
  static const Color barsColor = Color(0xFF111111);

  static const Color primaryColor = Colors.blue;
  static const Color secondaryColor = Colors.blueAccent;

  static const double elementsMapBarWidth = 220;
  static const double navBarHeight = 45;
  static const double elementControllerWidth = 280;
  static const EdgeInsets elementControllerPadding =
      EdgeInsets.symmetric(horizontal: 12);

  static const BorderRadius defaultRadius =
      BorderRadius.all(Radius.circular(8));

  static double windowWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double windowHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static double canvasWidth(BuildContext context) {
    return MediaQuery.of(context).size.width -
        elementsMapBarWidth -
        elementControllerWidth;
  }

  static double canvasHeight(BuildContext context) {
    return MediaQuery.of(context).size.height - navBarHeight;
  }

  static Size canvasSize(BuildContext context) {
    return Size(canvasWidth(context), canvasHeight(context));
  }

  static ThemeData getThemeData(BuildContext context) {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: bgColor,
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: primaryColor,
      ),
    );
  }
}
