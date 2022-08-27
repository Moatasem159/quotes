import 'package:dartz/dartz.dart';
import 'package:quotes/core/error/failures.dart';
import 'package:quotes/core/usecases/usecases.dart';
import 'package:quotes/features/favourites_quotes/domain/repositories/favourite_quotes_repository.dart';
import 'package:quotes/features/random_quote/domain/entities/quotes.dart';

class GetFavQuotes implements UseCase<List<Quote>, NoParams> {
 final FavoriteQuotesRepository favQuotesRepository;

 GetFavQuotes({required this.favQuotesRepository});

 @override
 Future<Either<Failure, List<Quote>>> call({NoParams ?params}) async {
  return await favQuotesRepository.getFavQuotes();
 }
}
