import 'package:assignment/mixins/invalidate_mixin.dart';
import 'package:assignment/res/common_widgets/vertical_in_between_widget.dart';
import 'package:assignment/res/strings.dart';
import 'package:flutter/material.dart';

import '../res/constantcolors.dart';

class DialogEditWeight extends StatelessWidget with InvalidateMixin{
  DialogEditWeight( {key, required this.weight}): super(key: key);
  String weight;
 TextEditingController? nameController;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    nameController = TextEditingController(text: weight);
    return AlertDialog(
      // contentPadding: EdgeInsets.zero,
        actions: [
          TextButton(
            onPressed: () {
              callPostMethod(context);
            },
            child: const Text(
              Strings.submitButtonText,
              style: TextStyle(
                  color: ConstantColors.secondaryColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 16.0),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              Strings.cancelButton,
              style: TextStyle(
                  color: ConstantColors.secondaryColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 16.0),
            ),
          )
        ],
        content: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(Strings.addWeight.toUpperCase(),
                  style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      color: ConstantColors.appGreyColor
                  ),
                ),
                const VerticalInBetweenSpacer(),
                Card(
                  elevation: 0.0,
                  color: ConstantColors.transparentColor,
                  child: TextFormField(
                    controller: nameController,
                    validator: (value){
                      if(!isValidText(value!))
                      {
                        return Strings.invalidItem;
                      }
                      return null;
                    },
                    onTapOutside: (event) {
                      debugPrint('onTapOutside');
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                        borderRadius:BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                            color:ConstantColors.secondaryColor
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius:BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                            color:ConstantColors.secondaryColor
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius:BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                            color:Colors.red
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius:BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                            color:Colors.red
                        ),
                      ),
                      prefixIconColor: ConstantColors.secondaryColor,
                    ),
                    keyboardType: TextInputType.name,
                  ),
                ),
              ],
            )
        ));
  }

  void callPostMethod(BuildContext context) {
    if(_formKey.currentState!.validate())
      {
        Navigator.of(context).pop(nameController!.text);
      }
  }
}
