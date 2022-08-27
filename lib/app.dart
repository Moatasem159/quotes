import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quotes/config/locale/app_localizations_setup.dart';
import 'package:quotes/config/routes/app_routes.dart';
import 'package:quotes/config/themes/app_theme.dart';
import 'package:quotes/config/themes/cubit/theme_cubit.dart';
import 'package:quotes/config/themes/cubit/theme_state.dart';
import 'package:quotes/core/utils/app_strings.dart';
import 'package:quotes/features/favourites_quotes/presentation/cubit/favourite_quote_cubit.dart';
import 'package:quotes/features/splash/presentation/cubit/locale_cubit.dart';
import 'package:quotes/features/splash/presentation/cubit/locale_states.dart';
import 'package:quotes/injection_container.dart' as di;

class QuoteApp extends StatelessWidget {

  final bool ? isDark;

  const QuoteApp({Key? key, this.isDark}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => di.sl<LocaleCubit>()..getSavedLang(),
          ),
          BlocProvider<ThemeCubit>(
            create: (context) => di.sl<ThemeCubit>()..changeThemeMode(fromShared: isDark),
          ),
          BlocProvider<FavoriteQuotesCubit>(create: (context) => di.sl<FavoriteQuotesCubit>()),

        ],
        child: BlocBuilder<LocaleCubit, LocaleStates>(
          buildWhen: (previous, current){
           return previous!=current;
          },
          builder: (context, localeState) {
            return BlocBuilder<ThemeCubit,ThemesStates>(
              buildWhen:(previous, current){
                return previous!=current;
              },
              builder:(context, themeState) {
              return MaterialApp(
                title: AppStrings.appName,
                locale: localeState.locale,
                debugShowCheckedModeBanner: false,
                theme: AppTheme.lightTheme,
                darkTheme: AppTheme.darkTheme,
                themeMode:BlocProvider.of<ThemeCubit>(context).dark?ThemeMode.dark: ThemeMode.light,
                onGenerateRoute: AppRoute.onGenerateRoute,
                supportedLocales: AppLocalizationsSetup.supportedLocales,
                localeResolutionCallback:
                AppLocalizationsSetup.localeResolutionCallback,
                localizationsDelegates:
                AppLocalizationsSetup.localizationsDelegates,
              );
            },);
          },
        ));
  }
}
