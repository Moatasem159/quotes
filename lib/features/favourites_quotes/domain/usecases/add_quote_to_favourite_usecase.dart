import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:quotes/core/error/failures.dart';
import 'package:quotes/core/usecases/usecases.dart';
import 'package:quotes/features/favourites_quotes/domain/repositories/favourite_quotes_repository.dart';
import 'package:quotes/features/random_quote/data/models/quote_model.dart';



class LikeQuote implements UseCase<bool, LikeParams> {
  final FavoriteQuotesRepository favoriteQuotesRepository;

  LikeQuote({required this.favoriteQuotesRepository});

  @override
  Future<Either<Failure, bool>> call({LikeParams? params}) async =>
      await favoriteQuotesRepository.addQuoteToFavList(params!.quote);

}

class LikeParams extends Equatable {
  final QuoteModel quote;

  const LikeParams({required this.quote});

  @override
  List<Object> get props => [quote];
}

