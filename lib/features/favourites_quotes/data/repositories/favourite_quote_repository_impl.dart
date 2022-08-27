import 'package:dartz/dartz.dart';
import 'package:quotes/core/error/exceptions.dart';
import 'package:quotes/core/error/failures.dart';
import 'package:quotes/features/favourites_quotes/data/datasource/favourite_quotes_data_source.dart';
import 'package:quotes/features/favourites_quotes/domain/repositories/favourite_quotes_repository.dart';
import 'package:quotes/features/random_quote/data/models/quote_model.dart';
import 'package:quotes/features/random_quote/domain/entities/quotes.dart';

class FavoriteQuotesRepositoryImpl implements FavoriteQuotesRepository {
  final FavoriteQuotesLocalDataSource favoriteQuotesLocalDataSource;

  FavoriteQuotesRepositoryImpl({
    required this.favoriteQuotesLocalDataSource,
  });

  @override
  Future<Either<Failure, bool>> addQuoteToFavList(QuoteModel quote) async {
    try {
      final response =
      await favoriteQuotesLocalDataSource.addQuoteToFavList(quote);
      return Right(response);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> removeQuoteFromFavList(int id) async {
    try {
      final response =
      await favoriteQuotesLocalDataSource.removeQuoteFromFavList(id);
      return Right(response);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<Quote>>> getFavQuotes() async {
    try {
      final response = await favoriteQuotesLocalDataSource.getFavQuotes();
      return Right(response);
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
