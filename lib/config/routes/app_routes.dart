

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quotes/features/favourites_quotes/presentation/screens/favourite_quotes_screen.dart';
import 'package:quotes/features/random_quote/presentation/cubit/random_quote_cubit.dart';
import 'package:quotes/features/random_quote/presentation/screens/quote_screen.dart';
import 'package:quotes/features/splash/presentation/screens/splash_screen.dart';
import 'package:quotes/injection_container.dart'as di;


class Routes {

  static const String initialRoute= "/";
  static const String randomQuoteRoute= "/randomQuote";
  static const String favouritesQuoteRoute= "/favouriteQuotes";

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
      case Routes.favouritesQuoteRoute:
        return MaterialPageRoute(
          builder: (context) => const FavoriteQuotesScreen(),
        );
      default: undefinedRoute();
    }
    return null;
  }


  static Route<dynamic> undefinedRoute(){
    return MaterialPageRoute(builder: (context) => const Scaffold(),);
  }
}