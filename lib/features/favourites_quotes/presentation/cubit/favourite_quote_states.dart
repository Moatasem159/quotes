import 'package:equatable/equatable.dart';
import 'package:quotes/features/random_quote/domain/entities/quotes.dart';

abstract class FavoriteQuotesState extends Equatable {
  const FavoriteQuotesState();

  @override
  List<Object> get props => [];
}

class FavoriteQuotesInitial extends FavoriteQuotesState {}

class FavoriteQuotesIsLoading extends FavoriteQuotesState {
  final bool isLoading;

  const FavoriteQuotesIsLoading({required this.isLoading});
}

class FavoriteQuotesLoaded extends FavoriteQuotesState {
  final List<Quote> quotes;
  const FavoriteQuotesLoaded({required this.quotes, quote});

  @override
  List<Object> get props => [quotes];
}

class FavoriteQuoteIsAddedSuccessfully extends FavoriteQuotesState {
  final String message;
  const FavoriteQuoteIsAddedSuccessfully({required this.message});

  @override
  List<Object> get props => [message];
}

class FailedToAddFavoriteQuote extends FavoriteQuotesState {
  final String message;

  const FailedToAddFavoriteQuote({required this.message});

  @override
  List<Object> get props => [message];
}

class FavoriteQuoteIsDeletedSuccessfully extends FavoriteQuotesState {
  final String message;
  const FavoriteQuoteIsDeletedSuccessfully({required this.message});

  @override
  List<Object> get props => [message];
}

class FailedToDeleteFavoriteQuote extends FavoriteQuotesState {
  final String message;
  const FailedToDeleteFavoriteQuote({required this.message});

  @override
  List<Object> get props => [message];
}

class FavoriteQuotesError extends FavoriteQuotesState {
  final String message;
  const FavoriteQuotesError({required this.message});

  @override
  List<Object> get props => [message];
}


class QuoteIsFavourite extends FavoriteQuotesState{}
class QuoteIsFavouriteDone extends FavoriteQuotesState{}