import 'package:equatable/equatable.dart';



class Quote extends Equatable {
  const Quote(
       {
    this.quoteId,
    this.author,
    this.quote,
    this.permalink,
  });

  final String? author;
  final int ?quoteId;
  final String? quote;
  final String? permalink;

  @override
  List<Object?> get props => [
    author,quote,
    permalink,quoteId
  ];

}

