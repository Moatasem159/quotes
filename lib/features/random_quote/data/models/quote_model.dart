import 'package:quotes/features/random_quote/domain/entities/quotes.dart';

class QuoteModel extends Quote{


  const QuoteModel(
      {required super.author,
      required super.id,
      required super.content,
      required super.permalink});

  factory QuoteModel.fromJson(Map<String, dynamic> json) => QuoteModel(
        author: json["author"],
        id: json["id"],
        content: json["quote"],
        permalink: json["permalink"],
    );

      Map<String, dynamic> toJson() => {
        "author": author,
        "id": id,
        "quote": content,
        "permalink": permalink,
      };
}