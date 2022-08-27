import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiffy/jiffy.dart';
import 'package:quotes/core/widget/color_loader.dart';
import 'package:quotes/features/favourites_quotes/presentation/cubit/favourite_quote_cubit.dart';
import 'package:quotes/features/favourites_quotes/presentation/cubit/favourite_quote_states.dart';
import 'package:quotes/features/random_quote/domain/entities/quotes.dart';
import 'package:quotes/core/widget/error.dart';
import 'package:quotes/features/random_quote/presentation/widgets/quote_content.dart';

class FavoriteQuotesScreen extends StatefulWidget {
  const FavoriteQuotesScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteQuotesScreen> createState() => _FavoriteQuotesScreenState();
}

class _FavoriteQuotesScreenState extends State<FavoriteQuotesScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<FavoriteQuotesCubit>(context).getFavQuoteList();
  }

  Widget _buildBody({required List<Quote> quotes}) {


    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 24.0,top: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  Jiffy().yMMMEd.toString(),
                  style: TextStyle(
                    color: Theme.of(context)
                        .textTheme
                        .bodyText1
                        ?.color
                        ?.withOpacity(
                      .5,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  "Your favorite quotes 😋",
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyText1?.color,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          quotes.isEmpty
              ? Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 24,
                ),
                // Image.asset(
                //   "assets/images/empty_$currentTheme.png",
                //   height: 250,
                //   // width: 100,
                //   fit: BoxFit.contain,
                // ),
                const SizedBox(
                  height: 24,
                ),
                Text(
                  "No saved quotes",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyText1?.color,
                  ),
                ),
              ],
            ),
          )
              : Container(
            height: MediaQuery.of(context).size.height - 200,
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: ListView.builder(
                itemCount: quotes.length,
                itemBuilder: (context, index) {
                  return QuoteCard(
                      isFavScreen: true,
                      quote: quotes[index],
                      deleteQuote: () {
                        BlocProvider.of<FavoriteQuotesCubit>(context)
                            .deleteQuoteFromFavQuotes(id: quotes[index].quoteId!);
                      });
                }),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {


    return BlocConsumer<FavoriteQuotesCubit, FavoriteQuotesState>(
      listener: (context, state) {
        if (state is FavoriteQuoteIsDeletedSuccessfully)
        {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.message),
          ));
        }
        else if (state is FailedToDeleteFavoriteQuote)
        {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.message),
          ));
        }
      },
      builder: (context, state) {
        if (state is FavoriteQuotesIsLoading)
        {
          return Scaffold(
            body:
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Center(
                      child: ColorLoader(
                        radius: 20.0,
                        dotRadius: 5.0,
                      )),
                ],
              ),
            ),
          );
        }
        else if (state is FavoriteQuotesLoaded)
        {
          return Scaffold(
            appBar: AppBar(title: const Text("Favourite Quotes"),),
              body: _buildBody(quotes: state.quotes));
        }
        else if (state is FavoriteQuotesError)
        {
          return Error(
            errorMessage: state.message,
          );
        }
        return const Center(
            child: ColorLoader(
              radius: 25.0,
              dotRadius: 6.0,
            ));
      },
    );
  }
}
