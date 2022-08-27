import 'package:quotes/features/random_quote/domain/entities/quotes.dart';

class QuoteModel extends Quote {
  const QuoteModel({
    required String author,
    required String? quote,
    required String? permalink,
    required int? quoteId,
  }) : super(quote: quote,author: author,permalink: permalink,quoteId: quoteId);

  factory QuoteModel.fromJson(Map<String, dynamic> json) => QuoteModel(
    author: json["author"],
    quoteId: json["id"],
    quote: json["quote"],
    permalink: json["permalink"],
  );

  Map<String, dynamic> toJson() => {
    "author": author,
    "id": quoteId,
    "quote": quote,
    "permalink": permalink,
  };

  // Convert a Quote object into a Map object
  Map<String, dynamic> toDbMap() {
    var map = <String, dynamic>{};
    if (quoteId != null) {
      map['id'] = quoteId;
    }
    map['author'] = author;
    map['quote'] = quote;
    map['permalink'] = permalink;

    return map;
  }
}
