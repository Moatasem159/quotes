


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Constants{



  static void showErrorDialog({
    required BuildContext context,
    required String msg})
  {
    showDialog(context: context, builder:(context)=>CupertinoAlertDialog(
      title: Text(msg),
      actions: [
        TextButton(onPressed: ()=>Navigator.pop(context), child: const Text("ok"))
      ],

    ));
  }
}