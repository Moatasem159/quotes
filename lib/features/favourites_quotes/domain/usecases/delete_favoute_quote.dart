import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:quotes/core/error/failures.dart';
import 'package:quotes/core/usecases/usecases.dart';
import 'package:quotes/features/favourites_quotes/domain/repositories/favourite_quotes_repository.dart';


class DeleteQuote implements UseCase<bool, Params> {
  final FavoriteQuotesRepository favoriteQuotesRepository;

  DeleteQuote({required this.favoriteQuotesRepository});

  @override
  Future<Either<Failure, bool>> call({Params ?params}) async =>
      await favoriteQuotesRepository.removeQuoteFromFavList(params!.id);
}

class Params extends Equatable {
  final int id;

  const Params({required this.id});

  @override
  List<Object> get props => [id];
}
