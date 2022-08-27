import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:quotes/features/random_quote/data/models/quote_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as database_path;


class DatabaseManager {
  static DatabaseManager? _databaseManager; // Singleton DatabaseManager
  static Database? _database; // Singleton Database

  String quoteTable = 'favourite_quote_table';
  String colId = 'id';
   String colAuthor = 'author';
  String colQuotePermalink = 'permalink';
  String colQuoteContent = 'quote';
  DatabaseManager._createInstance();

  factory DatabaseManager() {
    _databaseManager ??= DatabaseManager._createInstance();
    return _databaseManager!;
  }

  Future<Database> get database async {
    _database ??= await initializeDatabase();
    return _database!;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = database_path.join(directory.toString(), 'quotes.db');
    Database database =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return database;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $quoteTable('
            '$colId INTEGER PRIMARY KEY AUTOINCREMENT,'
            '$colAuthor TEXT,'
            '$colQuoteContent TEXT,'
            '$colQuotePermalink TEXT)');
  }

  // Fetch Operation: Get all Quote objects from database
  Future<List<Map<String, dynamic>>> _getQuoteMapList() async {
    Database db = await database;
    var result = await db.query(quoteTable);
    return result;
  }

  // Insert Operation: Insert a Quote object to database
  Future<int> insertQuote(QuoteModel quote) async {
    Database db = await database;
    var result = await db.insert(
      quoteTable,
      quote.toDbMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return result;
  }

  // Update Operation: Update a Quote object and save it to database
  Future<int> updateQuote(QuoteModel quote) async {
    var db = await database;
    var result = await db.update(quoteTable, quote.toDbMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
        where: '$colId = ?',
        whereArgs: [quote.quoteId]);
    return result;
  }

  // Delete Operation: Delete a Quote object from database
  Future<int> deleteQuote(int id) async {
    var db = await database;
    int result =
        await db.rawDelete('DELETE FROM $quoteTable WHERE $colId = $id');
    return result;
  }

  Future<int> deleteAllQuotes() async {
    Database db = await database;
    var result = await db.delete(quoteTable);
    return result;
  }

  // Get number of Quote objects in database
  Future<int?> getCount() async {
    Database db = await database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) from $quoteTable');
    int? result = Sqflite.firstIntValue(x);
    return result;
  }

  // Get the 'Map List' [ List<Map> ] and convert it to 'Quote List' [ List<Quote> ]
  Future<List<QuoteModel>> getQuotesList() async {
    var quoteMapList = await _getQuoteMapList(); // Get 'Map List' from database
    int count =
        quoteMapList.length; // Count the number of map entries in db table

    List<QuoteModel> quotes = [];
    // For loop to create a 'Quote List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      quotes.add(QuoteModel(
        quoteId: quoteMapList[i]['id'],
        author: quoteMapList[i]['author'],
        permalink: quoteMapList[i]['permalink'],
        quote: quoteMapList[i]['quote'],
      ));
    }

    return quotes;
  }

  Future<QuoteModel?> queryQuote(int id) async {
    Database db = await database;
    List<Map> maps =
        await db.query(quoteTable, where: '$colId = ?', whereArgs: [id]);
    if (maps.isNotEmpty) {
      return QuoteModel(
        quoteId: maps.first['id'],
        author: maps.first['author'],
        permalink: maps.first['permalink'],
        quote: maps.first['quote'],
      );
    }
    return null;
  }


}
