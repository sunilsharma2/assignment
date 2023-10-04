
import 'package:assignment/res/common_widgets/vertical_in_between_widget.dart';
import 'package:assignment/res/constantcolors.dart';
import 'package:assignment/res/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
class DialogLogoutAlert extends StatelessWidget {
  const DialogLogoutAlert({Key? key, required this.contextAlert, required this.description}) : super(key: key);
  final BuildContext contextAlert;
  final String description;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        //crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(Strings.alertMessage,
            style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18.0
            ),
          ),
          const VerticalInBetweenSpacer(),
          Text(description),
        ],
      ),
      //actionsAlignment: MainAxisAlignment.center,
      actions: [
        TextButton(onPressed: (){
          Navigator.pop(context,true);
        }, child: const Text(Strings.yes,style: TextStyle(color: ConstantColors.secondaryColor,fontWeight: FontWeight.w600),)),
        TextButton(onPressed: (){
          Navigator.pop(context,false);
        }, child: const Text(Strings.cancel,style: TextStyle(color: ConstantColors.secondaryColor,fontWeight: FontWeight.w600),))


      ],
    );
  }
}