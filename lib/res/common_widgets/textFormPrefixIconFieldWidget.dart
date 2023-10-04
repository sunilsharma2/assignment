import 'package:flutter/material.dart';

import '../constantcolors.dart';
class TextFormFieldPrefixIconWidget extends StatelessWidget {
  final bool? readonly;
  final int? maxLength;
   final int? maxLines;
  final String textName;
  final Icon prefixIcon;
  final TextInputType textInputType;
  final String hintText;
  final TextEditingController controller;
  final FormFieldValidator validator;
  final bool isObscure;
  final VoidCallback? iconCallBack;
  final Icon? suffixIcon;
  const TextFormFieldPrefixIconWidget({Key? key, required this.textName, required this.prefixIcon, required this.textInputType, required this.hintText, required this.controller, required this.validator, required this.isObscure,this.maxLines,this.maxLength,this.readonly, this.iconCallBack, this.suffixIcon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      Text(textName,
       // style: const TextStyle(color: ConstantColors.secondaryColor),
      ),
      SizedBox(
        height: MediaQuery.of(context).size.height*0.01,
      ),
      TextFormField(
        readOnly: readonly??false,
        autocorrect: false,

        // maxLines: maxLines,
        maxLength: maxLength,

        //enableInteractiveSelection : false,
        controller: controller,
        validator: validator,
        obscureText: isObscure,
        onTapOutside: (event) {
          debugPrint('onTapOutside');
          FocusManager.instance.primaryFocus?.unfocus();
        },
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius:BorderRadius.circular(10.0),
            borderSide: const BorderSide(
              color:ConstantColors.borderLineColor
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius:BorderRadius.circular(10.0),
            borderSide: const BorderSide(
                color:ConstantColors.borderLineColor
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
          prefixIcon: prefixIcon,
          prefixIconColor: ConstantColors.secondaryColor,
          suffixIcon: suffixIcon,
          suffixIconColor: ConstantColors.secondaryColor,
          hintText: hintText,
        ),
        keyboardType: textInputType,
      ),
      ],
    );
  }
}
