import 'package:dartz/dartz.dart';
import 'package:quotes/core/error/failures.dart';
import 'package:quotes/features/random_quote/data/models/quote_model.dart';
import 'package:quotes/features/random_quote/domain/entities/quotes.dart';

abstract class FavoriteQuotesRepository {
  Future<Either<Failure, bool>> removeQuoteFromFavList(int id);
  Future<Either<Failure, bool>> addQuoteToFavList(QuoteModel quote);
  Future<Either<Failure, List<Quote>>> getFavQuotes();
}
