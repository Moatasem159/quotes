

import 'package:dartz/dartz.dart';
import 'package:quotes/core/error/failures.dart';
import 'package:quotes/core/usecases/usecases.dart';
import 'package:quotes/features/random_quote/domain/entities/quotes.dart';
import 'package:quotes/features/random_quote/domain/repositories/quote_repository.dart';

class GetRandomQuote implements UseCase<Quote,NoParams> {


final QuoteRepository quoteRepository;

  GetRandomQuote({required this.quoteRepository});
  // Future<Either<Failure,Quote>>? execute(){
  //   return null;
  // }

  @override
  Future<Either<Failure, Quote>> call(NoParams params) {
     return quoteRepository.getRandomQuote();
  }
}