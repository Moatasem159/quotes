import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quotes/core/error/failures.dart';
import 'package:quotes/core/usecases/usecases.dart';
import 'package:quotes/features/favourites_quotes/domain/usecases/add_quote_to_favourite_usecase.dart';
import 'package:quotes/features/favourites_quotes/domain/usecases/delete_favoute_quote.dart';
import 'package:quotes/features/favourites_quotes/domain/usecases/get_favourite_quotes_usecase.dart';
import 'package:quotes/features/favourites_quotes/presentation/cubit/favourite_quote_states.dart';
import 'package:quotes/features/random_quote/data/models/quote_model.dart';
import 'package:quotes/features/random_quote/domain/entities/quotes.dart';


class FavoriteQuotesCubit extends Cubit<FavoriteQuotesState> {
  final LikeQuote likeQuote;
  final DeleteQuote deleteQuote;
  final GetFavQuotes getFavQuotes;
  FavoriteQuotesCubit(
      {required this.likeQuote,
        required this.deleteQuote,
        required this.getFavQuotes})
      : super(FavoriteQuotesInitial());
  bool isLoadingForAdd = false, isLoading = false;


  bool isLiked=false;
  Future<void> addQuoteToFavQuotes(QuoteModel quote) async {
    _changeLoadingViewForAddQuote();
    Either<Failure, bool> response = await likeQuote(params: LikeParams(quote: quote));
    _changeLoadingViewForAddQuote();
    emit(response
        .fold((failure) => const FavoriteQuotesError(message: "Cache Failure"),
            (value){
          if (value == true){
            isLiked=true;
             return const FavoriteQuoteIsAddedSuccessfully(
                message: "Quote is Added to Favorite");
          } else {
            return const FailedToAddFavoriteQuote(message: "Quote is already Added to Favorite");
          }
        }));
  }

  Future<void> deleteQuoteFromFavQuotes({required int id}) async {
    _changeLoadingView();
    Either<Failure, bool> response = await deleteQuote(params: Params(id: id));
    _changeLoadingView();
    emit(response
        .fold((failure) => const FavoriteQuotesError(message: "Cache Failure"),
            (value) {
          if (value == true) {
            isLiked=false;
            return const FavoriteQuoteIsDeletedSuccessfully(
                message: "Quote is Deleted Successfully");
          } else {
            return const FailedToDeleteFavoriteQuote(message: "Failed to Delete Quote");
          }
        }));
    getFavQuoteList();
  }

  void _changeLoadingViewForAddQuote() {
    isLoadingForAdd = !isLoadingForAdd;
    emit(FavoriteQuotesIsLoading(isLoading: isLoadingForAdd));
  }

  void _changeLoadingView() {
    isLoading = !isLoading;
    emit(FavoriteQuotesIsLoading(isLoading: isLoading));
  }


  List<Quote> favQuotes=[];
  Future<void> getFavQuoteList() async {
    _changeLoadingView();
    Either<Failure, List<Quote>> response = await getFavQuotes.call(params: NoParams());
    _changeLoadingView();
    favQuotes=[];
    emit(response
        .fold((failure) => const FavoriteQuotesError(message: "Cache Failure"),
            (quotes) {
          favQuotes=quotes;
              return FavoriteQuotesLoaded(quotes: quotes);
        }));
  }


  // bool isFavouriteQuote({required Quote quote}){
  //
  //   emit(QuoteIsFavourite());
  //   for (var element in favQuotes){
  //
  //     if(element.quote==quote.quote)
  //       {
  //         return true;
  //       }
  //     emit(QuoteIsFavouriteDone());
  //   }
  //   emit(QuoteIsFavouriteDone());
  //   return false;
  //
  // }
}

