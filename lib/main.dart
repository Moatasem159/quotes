import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quotes/app.dart';
import 'package:quotes/bloc_observer.dart';
import 'package:quotes/injection_container.dart'as di;


void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer=AppBlocObserver();
  await di.init();
  runApp(const QuoteApp());
}


