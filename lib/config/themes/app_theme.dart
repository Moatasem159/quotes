import 'package:flutter/material.dart';
import 'package:quotes/core/utils/app_colors.dart';
import 'package:quotes/core/utils/app_strings.dart';

ThemeData appTheme(){


  return ThemeData(
      primaryColor: AppColors.primary,
      hintColor: AppColors.hint,
      fontFamily:AppStrings.fontFamily,
      appBarTheme: const AppBarTheme(
      centerTitle: true,
      color: Colors.transparent,
      elevation: 0,
        titleTextStyle: TextStyle(
            fontSize: 22,
            fontFamily: AppStrings.fontFamily,
            color: Colors.black,

            fontWeight: FontWeight.bold

        ),

  ),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(
          fontSize: 22,
          color: Colors.white,

          fontWeight: FontWeight.bold

      ),
    )
  );
}