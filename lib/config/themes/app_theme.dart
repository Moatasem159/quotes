import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:quotes/core/utils/app_colors.dart';
import 'package:quotes/core/utils/app_strings.dart';
import 'package:tinycolor2/tinycolor2.dart';


class AppTheme {
  const AppTheme._();

  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    fontFamily: AppStrings.fontFamily,
    backgroundColor: whiteBackgroundColor.darken(4),
    scaffoldBackgroundColor: whiteBackgroundColor,
    primarySwatch: Colors.grey,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    iconTheme: IconThemeData(color: screenBackgroundColor),
    textTheme: TextTheme(
      bodyText1: TextStyle(
        color: screenBackgroundColor,
      ),
      bodyText2: TextStyle(
        color: screenBackgroundColor,
      ),
    ),
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: Colors.grey,
      brightness: Brightness.light,
    ).copyWith(
      secondary: accentColor,
    ),
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    fontFamily: AppStrings.fontFamily,
    backgroundColor: screenBackgroundColor,
    scaffoldBackgroundColor: screenBackgroundColor,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    textTheme: const TextTheme(
      bodyText1: TextStyle(
        color: Colors.white,
      ),
      bodyText2: TextStyle(
        color: Colors.white,
      ),
    ),
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: Colors.grey,
      brightness: Brightness.dark,
    ).copyWith(secondary: accentColor),
  );

  static Brightness get currentSystemBrightness =>
      SchedulerBinding.instance.window.platformBrightness;

  static setStatusBarAndNavigationBarColors(bool dark) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: dark
          ? screenBackgroundColor
          : whiteBackgroundColor.darken(4),
      statusBarIconBrightness:dark
          ? Brightness.light
          : Brightness.dark,


    ));
  }
}
