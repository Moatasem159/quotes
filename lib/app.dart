import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quotes/config/locale/app_localizations_setup.dart';
import 'package:quotes/config/routes/app_routes.dart';
import 'package:quotes/config/themes/app_theme.dart';
import 'package:quotes/core/utils/app_strings.dart';
import 'package:quotes/features/splash/presentation/cubit/locale_cubit.dart';
import 'package:quotes/features/splash/presentation/cubit/locale_states.dart';
import 'package:quotes/injection_container.dart' as di;

class QuoteApp extends StatelessWidget {
  const QuoteApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => di.sl<LocaleCubit>()..getSavedLang(),
          ),
        ],
        child: BlocBuilder<LocaleCubit, LocaleStates>(
          buildWhen: (previous, current) {
           return previous!=current;
          },
          builder: (context, state) {
            return MaterialApp(
              title: AppStrings.appName,
              locale: state.locale,
              debugShowCheckedModeBanner: false,
              theme: appTheme(),
              onGenerateRoute: AppRoute.onGenerateRoute,
              supportedLocales: AppLocalizationsSetup.supportedLocales,
              localeResolutionCallback:
                  AppLocalizationsSetup.localeResolutionCallback,
              localizationsDelegates:
                  AppLocalizationsSetup.localizationsDelegates,
            );
          },
        ));
  }
}
