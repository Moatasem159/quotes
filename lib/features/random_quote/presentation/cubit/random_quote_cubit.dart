import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quotes/core/error/failures.dart';
import 'package:quotes/core/usecases/usecases.dart';
import 'package:quotes/features/random_quote/domain/entities/quotes.dart';
import 'package:quotes/features/random_quote/domain/usecases/get_random_quote.dart';
import 'package:quotes/features/random_quote/presentation/cubit/random_quote_states.dart';

class RandomQuoteCubit extends Cubit<RandomQuoteStates>{
  RandomQuoteCubit({required this.getRandomQuote})
      : super(RandomQuoteInitialState());


  final GetRandomQuote getRandomQuote;

  Future<void> getRandomQuotes()async{

    emit(RandomQuoteLoadingState());
    Either<Failure,Quote> response= await getRandomQuote(NoParams());


    emit(response.fold((failure) =>
        RandomQuoteErrorState(msg: _mapFailureToMsg(failure)), (quote) =>
        RandomQuoteSuccessState(quote: quote)));

  }


  String _mapFailureToMsg(Failure failure){
    switch(failure.runtimeType){
      case ServerFailure:
        return "Server Failure";
      case CacheFailure:
        return "Cache Failure";

      default: return" error";
    }
  }
}