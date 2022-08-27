import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quotes/app.dart';
import 'package:quotes/bloc_observer.dart';
import 'package:quotes/core/database/database_manager.dart';
import 'package:quotes/injection_container.dart'as di;
import 'package:quotes/injection_container.dart';
import 'package:shared_preferences/shared_preferences.dart';



void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  DatabaseManager databaseManager = sl<DatabaseManager>();
  databaseManager.initializeDatabase();
  Bloc.observer=AppBlocObserver();
  SharedPreferences sharedPreferences=sl<SharedPreferences>();
  bool? isMainDark= sharedPreferences.getBool("dark");
  runApp(QuoteApp(isDark:isMainDark,));
}


