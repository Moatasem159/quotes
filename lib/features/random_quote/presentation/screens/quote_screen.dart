import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:quotes/config/locale/app_localizations.dart';
import 'package:quotes/config/routes/app_routes.dart';
import 'package:quotes/config/themes/cubit/theme_cubit.dart';
import 'package:quotes/core/utils/app_colors.dart';
import 'package:quotes/core/utils/app_strings.dart';
import 'package:quotes/core/widget/error_widget.dart';
import 'package:quotes/features/favourites_quotes/presentation/cubit/favourite_quote_cubit.dart';
import 'package:quotes/features/favourites_quotes/presentation/cubit/favourite_quote_states.dart';
import 'package:quotes/features/random_quote/data/models/quote_model.dart';
import 'package:quotes/features/random_quote/presentation/cubit/random_quote_cubit.dart';
import 'package:quotes/features/random_quote/presentation/cubit/random_quote_states.dart';
import 'package:quotes/features/random_quote/presentation/widgets/quote_content.dart';
import 'package:quotes/features/splash/presentation/cubit/locale_cubit.dart';

class QuoteScreen extends StatefulWidget {
  const QuoteScreen({Key? key}) : super(key: key);

  @override
  State<QuoteScreen> createState() => _QuoteScreenState();
}

class _QuoteScreenState extends State<QuoteScreen> {

  _getRandomQuote() =>
      BlocProvider.of<RandomQuoteCubit>(context).getRandomQuotes(context);

  @override
  void initState() {
    super.initState();
    _getRandomQuote();
  }

  Widget _buildBodyContent() {
    return BlocBuilder<RandomQuoteCubit, RandomQuoteStates>(
      builder: (context, state) {
        if (state is RandomQuoteLoadingState)
        {
          return Center(
            child: SpinKitFadingCircle(
              color: AppColors.primary,
            ),
          );
        }
        else if (state is RandomQuoteErrorState)
        {
          return MyErrorWidget(
            onPress: () => _getRandomQuote(),
          );
        }
        else if (state is RandomQuoteSuccessState)
        {
          return BlocListener<FavoriteQuotesCubit, FavoriteQuotesState>(
            listener: (context, state) {
              if (state is FavoriteQuoteIsAddedSuccessfully)
              {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(state.message),
                ));
              }
              else if (state is FailedToAddFavoriteQuote)
              {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(state.message),
                ));
              }
              else if (state is FavoriteQuoteIsDeletedSuccessfully)
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
            child: BlocBuilder<FavoriteQuotesCubit,FavoriteQuotesState>(builder: (context, fState) {
              return Column(
                children: [
                  QuoteCard(
                      heartColor:
                          BlocProvider.of<FavoriteQuotesCubit>(context).isLiked
                              ? Colors.red
                              : Colors.white,
                      quote: state.quote,
                    onReload: _getRandomQuote,
                    likeQuote: (){
                      if(!BlocProvider.of<FavoriteQuotesCubit>(context).isLiked){
                        BlocProvider.of<FavoriteQuotesCubit>(context).addQuoteToFavQuotes(QuoteModel(
                            author: state.quote.author!,
                            quote: state.quote.quote,
                            permalink: state.quote.permalink,
                            quoteId: state.quote.quoteId));
                      }
                      else{
                        BlocProvider.of<FavoriteQuotesCubit>(context)
                            .deleteQuoteFromFavQuotes(id:  state.quote.quoteId!);
                      }

                    }

                  ),
                  // Container(
                  //   margin: const EdgeInsets.symmetric(vertical: 15),
                  //   padding: const EdgeInsets.all(10),
                  //   decoration: BoxDecoration(
                  //     shape: BoxShape.circle,
                  //     color: AppColors.primary,
                  //   ),
                  //   child: InkWell(
                  //       onTap: () => _getRandomQuote(),
                  //       child: const Icon(
                  //         Icons.refresh, size: 22, color: Colors.white,)),
                  // ),
                ],
              );
            },));
        }
        else
        {
          return Center(
            child: SpinKitFadingCircle(
              color: AppColors.primary,
            ),
          );
        }
      },);
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(

      leading: IconButton(
        onPressed: () {
          if (AppLocalizations.of(context)!.isEnLocale) {
            BlocProvider.of<LocaleCubit>(context).toArabic();
          }
          else {
            BlocProvider.of<LocaleCubit>(context).toEnglish();
          }
        },
        icon: Icon(Icons.translate_outlined, color: AppColors.primary,),
      ),
      actions: [

        IconButton(
          onPressed: () {
            Navigator.pushNamed(context, Routes.favouritesQuoteRoute);
          },
          icon: Icon(Icons.favorite_outlined, color: AppColors.primary,),
        ),
        IconButton(
          onPressed: () =>
              BlocProvider
                  .of<ThemeCubit>(context)
                  .changeThemeMode(),
          icon: BlocProvider
              .of<ThemeCubit>(context)
              .icon,
          color: Theme
              .of(context)
              .iconTheme
              .color,
        ),
      ],
      title: Text(AppLocalizations.of(context)!.translate(AppStrings.appName)!),
    );


    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme
            .of(context)
            .backgroundColor,
        appBar: appBar,
        body: _buildBodyContent(),
      ),
    );
  }
}



