import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:quotes/config/themes/cubit/theme_cubit.dart';
import 'package:quotes/core/api/api_consumer.dart';
import 'package:quotes/core/api/app_interceptors.dart';
import 'package:quotes/core/api/dio_consumer.dart';
import 'package:quotes/core/database/database_manager.dart';
import 'package:quotes/core/network/network_info.dart';
import 'package:quotes/features/favourites_quotes/data/datasource/favourite_quotes_data_source.dart';
import 'package:quotes/features/favourites_quotes/data/repositories/favourite_quote_repository_impl.dart';
import 'package:quotes/features/favourites_quotes/domain/repositories/favourite_quotes_repository.dart';
import 'package:quotes/features/favourites_quotes/domain/usecases/add_quote_to_favourite_usecase.dart';
import 'package:quotes/features/favourites_quotes/domain/usecases/delete_favoute_quote.dart';
import 'package:quotes/features/favourites_quotes/domain/usecases/get_favourite_quotes_usecase.dart';
import 'package:quotes/features/favourites_quotes/presentation/cubit/favourite_quote_cubit.dart';
import 'package:quotes/features/random_quote/data/datasources/random_quote_local_data_source.dart';
import 'package:quotes/features/random_quote/data/datasources/random_quote_remote_data_source.dart';
import 'package:quotes/features/random_quote/data/repositories/quote_repository_impl.dart';
import 'package:quotes/features/random_quote/domain/repositories/quote_repository.dart';
import 'package:quotes/features/random_quote/domain/usecases/get_random_quote.dart';
import 'package:quotes/features/random_quote/presentation/cubit/random_quote_cubit.dart';
import 'package:quotes/features/splash/data/datasources/lang_locale_data_source.dart';
import 'package:quotes/features/splash/data/repositories/lang_repository_impl.dart';
import 'package:quotes/features/splash/domain/repositories/lang_repository.dart';
import 'package:quotes/features/splash/domain/usecases/change_lang_usecase.dart';
import 'package:quotes/features/splash/domain/usecases/get_saved_lang.dart';
import 'package:quotes/features/splash/presentation/cubit/locale_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  ///features

  //blocs

  sl.registerFactory<RandomQuoteCubit>(() => RandomQuoteCubit(getRandomQuote: sl()));
  sl.registerFactory<LocaleCubit>(() => LocaleCubit(changeLangUseCase: sl(),getSavedLangUseCase: sl()));
  sl.registerFactory<ThemeCubit>(() => ThemeCubit(sharedPreferences: sl()));
  sl.registerFactory<FavoriteQuotesCubit>(() => FavoriteQuotesCubit(likeQuote: sl(), deleteQuote: sl(),
        getFavQuotes: sl()),);



  //useCases

  sl.registerLazySingleton<GetRandomQuote>(() => GetRandomQuote(quoteRepository: sl()));
  sl.registerLazySingleton<GetSavedLangUseCase>(() => GetSavedLangUseCase(langRepository: sl()));
  sl.registerLazySingleton<ChangeLangUseCase>(() => ChangeLangUseCase(langRepository:sl()));
  sl.registerLazySingleton<LikeQuote>(() => LikeQuote(
    favoriteQuotesRepository: sl(),
  ));
  sl.registerLazySingleton<DeleteQuote>(() => DeleteQuote(
    favoriteQuotesRepository: sl(),
  ));
  sl.registerLazySingleton<GetFavQuotes>(() => GetFavQuotes(
    favQuotesRepository: sl(),
  ));



  // Repository

  sl.registerLazySingleton<QuoteRepository>(() => QuoteRepositoryImpl(
      networkInfo: sl(),
      randomQuoteRemoteDataSource: sl(),
      randomQuoteLocalDataSource: sl()));
  sl.registerLazySingleton<LangRepository>(() => LangRepositoryImpl(langLocaleDataSource: sl()));
  sl.registerLazySingleton<FavoriteQuotesRepository>(
          () => FavoriteQuotesRepositoryImpl(favoriteQuotesLocalDataSource: sl()));


  //dataSource

  sl.registerLazySingleton<RandomQuoteLocalDataSource>(
      () => RandomQuoteLocalDataSourceImpl(sharedPreferences: sl()));
  sl.registerLazySingleton<RandomQuoteRemoteDataSource>(
      () => RandomQuoteRemoteDataSourceImpl(apiConsumer: sl()));
  sl.registerLazySingleton<LangLocaleDataSource>(
          () => LangLocaleDataSourceImpl(sharedPreferences:  sl()));
  sl.registerLazySingleton<FavoriteQuotesLocalDataSource>(
        () => FavoriteQuoteLocalDataSourceImpl(databaseManager: sl()),
  );


  ///core

  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(connectionChecker: sl()));




  ///External

  final sharedPreference = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreference);
  sl.registerLazySingleton(() => DatabaseManager());
  sl.registerLazySingleton<ApiConsumer>(() => DioConsumer(client: sl()));
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton(() => AppInterceptors());
  sl.registerLazySingleton(() => LogInterceptor(
        request: true,
        requestBody: true,
        requestHeader: true,
        responseBody: true,
        responseHeader: true,
        error: true,
      ));
}
