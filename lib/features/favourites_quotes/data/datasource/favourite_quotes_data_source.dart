

import 'package:quotes/core/database/database_manager.dart';
import 'package:quotes/features/random_quote/data/models/quote_model.dart';

abstract class FavoriteQuotesLocalDataSource {
  Future<bool> removeQuoteFromFavList(int id);
  Future<bool> addQuoteToFavList(QuoteModel quoteModel);
  Future<List<QuoteModel>> getFavQuotes();
}

class FavoriteQuoteLocalDataSourceImpl implements FavoriteQuotesLocalDataSource {
  final DatabaseManager databaseManager;

  FavoriteQuoteLocalDataSourceImpl({required this.databaseManager});

  @override
  Future<bool> removeQuoteFromFavList(int id) async {
    int result = await databaseManager.deleteQuote(id);
    if (result != 0) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<bool> addQuoteToFavList(QuoteModel quoteToCache) async {
    int result = await databaseManager.insertQuote(quoteToCache);
    if (result != 0) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<List<QuoteModel>> getFavQuotes() => databaseManager.getQuotesList();
}

