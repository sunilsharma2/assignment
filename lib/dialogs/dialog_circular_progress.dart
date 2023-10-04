import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../res/constantcolors.dart';
showLoaderDialog(BuildContext context) {
  CupertinoAlertDialog alert=CupertinoAlertDialog(
    content:Row(
      children: [
       const CircularProgressIndicator(
          color: ConstantColors.secondaryColor,
        ),
        Container(margin: const EdgeInsets.only(left: 7),child:const Text(" Loading.....",
          style: TextStyle(fontWeight: FontWeight.bold),
        )
        ),
      ],),
  );
   showDialog(barrierDismissible: false,
    context:context,
    builder:(BuildContext context){
      return WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: alert
      );
    },
  );
}

