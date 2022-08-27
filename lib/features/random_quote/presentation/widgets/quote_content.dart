import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quotes/config/themes/cubit/theme_cubit.dart';
import 'package:quotes/core/utils/app_colors.dart';
import 'package:quotes/features/random_quote/domain/entities/quotes.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tinycolor2/tinycolor2.dart';


class QuoteCard extends StatelessWidget {
  final Quote quote;
  final bool isFavScreen;
  final VoidCallback? likeQuote;
  final VoidCallback? onReload;
  final Color? heartColor;
  final VoidCallback? deleteQuote;
  const QuoteCard(
      {Key? key,
        required this.quote,
        this.isFavScreen = false,
        this.onReload,
        this.likeQuote,
        this.deleteQuote, this.heartColor=Colors.white
      }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
    margin: const EdgeInsets.symmetric(vertical: 10),
    padding: const EdgeInsets.symmetric(
      vertical: 12,
      horizontal: 18,
    ),
    decoration: BoxDecoration(
      color: BlocProvider.of<ThemeCubit>(context).dark
          ? TinyColor.fromColor(Theme.of(context).backgroundColor).color.tint(5)
          : TinyColor.fromColor(Theme.of(context).backgroundColor).color.lighten(15),
      borderRadius: BorderRadius.circular(
        20,
      ),
      border: Border.all(
        color: BlocProvider.of<ThemeCubit>(context).dark
            ? whiteBackgroundColor.withOpacity(.09)
            : screenBackgroundColor.withOpacity(.008),
        width: .8,
      ),
      boxShadow: [
        BoxShadow(
          offset: const Offset(0, 5),
          blurRadius: 10,
          color:
          BlocProvider.of<ThemeCubit>(context).dark
              ? whiteBackgroundColor.withOpacity(.02)
              : screenBackgroundColor.withOpacity(.02),
        )
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const SizedBox(
          height: 16,
        ),
        Text(
          quote.quote!,
          softWrap: true,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          maxLines: 8,
          style: TextStyle(
            color: Theme.of(context).textTheme.bodyText1?.color,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          "By ${quote.author!}",
          style: TextStyle(
            color: Theme.of(context)
                .textTheme
                .bodyText1
                ?.color
                ?.withOpacity(.8),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          children: [
            IconButton(
              onPressed: () {
                Share.share(quote.quote!);
              },
              color: Theme.of(context).iconTheme.color,
              icon: const Icon(
                Icons.share,
                size: 24,
              ),
            ),
            const Spacer(),
            !isFavScreen
                ? IconButton(
              onPressed: () => onReload!(),
              color: Theme.of(context).iconTheme.color,
              icon: const Icon(
                Icons.refresh,
                size: 28,
              ),
            )
                : const SizedBox(),
            const Spacer(),
            !isFavScreen
                ? Container(
                 decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary,
              ),
                  child: IconButton(
              onPressed: () => likeQuote!(),
              color: Theme.of(context).iconTheme.color,
              icon: Icon(
                  Icons.favorite_border,
                  color:heartColor,
                  size: 25,
              ),
            ),
                )
                : IconButton(
              onPressed: () => deleteQuote!(),
              color: Theme.of(context).iconTheme.color,
              icon: const Icon(
                Icons.remove_circle_rounded,
                size: 22,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
