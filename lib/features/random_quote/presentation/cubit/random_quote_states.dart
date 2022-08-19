import 'package:equatable/equatable.dart';
import 'package:quotes/features/random_quote/domain/entities/quotes.dart';
abstract class RandomQuoteStates extends Equatable{

  const RandomQuoteStates();
  @override
  List<Object>get props=>[];
}


class RandomQuoteInitialState extends RandomQuoteStates{}
class RandomQuoteLoadingState extends RandomQuoteStates{}
class RandomQuoteSuccessState extends RandomQuoteStates{

  final Quote quote;

  const RandomQuoteSuccessState({required this.quote});

  @override
  List<Object>get props=>[quote];
}

class RandomQuoteErrorState extends RandomQuoteStates{

  final String msg;

  const RandomQuoteErrorState({required this.msg});

  @override
  List<Object>get props=>[msg];
}