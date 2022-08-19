

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quotes/features/random_quote/presentation/cubit/random_quote_cubit.dart';
import 'package:quotes/features/random_quote/presentation/screens/quote_screen.dart';
import 'package:quotes/features/splash/presentation/screens/splash_screen.dart';
import 'package:quotes/injection_container.dart'as di;


class Routes {

  static const String initialRoute= "/";
  static const String randomQuoteRoute= "/randomQuote";

}

class AppRoute{


  static Route ? onGenerateRoute(RouteSettings routeSettings){

    switch(routeSettings.name){
      case Routes.initialRoute:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );
      case Routes.randomQuoteRoute:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
              create: (context) =>di.sl<RandomQuoteCubit>(),
              child: const QuoteScreen()),
        );
      default: undefinedRoute();
    }
    return null;
  }


  static Route<dynamic> undefinedRoute(){
    return MaterialPageRoute(builder: (context) => const Scaffold(),);
  }
}