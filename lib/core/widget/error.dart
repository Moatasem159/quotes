import 'package:flutter/material.dart';
import 'package:quotes/config/locale/app_localizations.dart';
import 'package:quotes/core/utils/app_colors.dart';



class Error extends StatelessWidget {
  final String? errorMessage;

   final Function()? onRetryPressed;

  const Error({Key? key, this.errorMessage, this.onRetryPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            errorMessage ??
                  AppLocalizations.of(context)!
                      .translate('something_went_wrong')!,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 18,
            ),
          ),
        const  SizedBox(height: 8),
          ElevatedButton(
                onPressed: () => onRetryPressed,
                style: ElevatedButton.styleFrom(
                  elevation: 500,
                  primary: mainAppColor,
                  onPrimary: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0)),
                ),
                child: Text( AppLocalizations.of(context)!.translate('reload_screen')!, style: const TextStyle(color: Colors.black),
                )
          )
        ],
      ),
    );
  }
}