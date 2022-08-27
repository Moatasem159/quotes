import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:quotes/config/themes/app_theme.dart';
import 'package:quotes/config/themes/cubit/theme_state.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ThemeCubit extends Cubit<ThemesStates> {
  // ThemeCubit() : super(const InitialThemeState(ThemeMode.light));
  //
  // ThemeMode currentThemeMode = ThemeMode.light;
  // bool dark=false;
  //
  // Future<void> updateAppTheme(ThemeMode mode) async {
  //   emit(InitialThemeState(mode));
  //   currentThemeMode = mode;
  //   dark = !dark;
  //   emit(SelectedThemeMode(currentThemeMode));

  // }


  ThemeCubit({required this.sharedPreferences}) : super(AppThemeInitialState());
  final SharedPreferences  sharedPreferences;

  Widget icon=const Icon(Icons.brightness_low_sharp);
  bool dark=false;
  void changeThemeMode({bool? fromShared}) async{
    if(fromShared!=null){
      dark = fromShared;
      icon=dark?const Icon(Icons.brightness_2_outlined):const Icon(Icons.brightness_low_sharp);

      AppTheme.setStatusBarAndNavigationBarColors(dark);
      emit(ChangeAppThemeState());
    }
    else {
      dark = !dark;
     sharedPreferences.setBool("dark", dark).then((value) {
       icon=dark?const Icon(Icons.brightness_2_outlined):const Icon(Icons.brightness_low_sharp);
       AppTheme.setStatusBarAndNavigationBarColors(dark);
        emit(ChangeAppThemeState());
      });
    }

  }
}
