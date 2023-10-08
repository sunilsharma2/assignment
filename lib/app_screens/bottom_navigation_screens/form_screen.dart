import 'package:assignment/mixins/invalidate_mixin.dart';
import 'package:assignment/res/common_widgets/vertical_in_between_widget.dart';
import 'package:assignment/res/constantcolors.dart';
import 'package:assignment/res/flutterToast_message.dart';
import 'package:assignment/res/strings.dart';
import 'package:assignment/riverpod/future_providers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
class FormScreen extends StatelessWidget with InvalidateMixin{
 FormScreen({super.key});

  final _formKey = GlobalKey<FormState>();
 final nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
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
                    keyboardType: TextInputType.number,
                  ),
                ),
                const VerticalInBetweenSpacer(),
                Consumer(builder: (_,WidgetRef ref,__){
               return   Align(
                 alignment: Alignment.center,
                 child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: ConstantColors.secondaryColor
                      ),
                      onPressed: (){
                        callPostMethod(context,ref);
                      }, child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(Strings.submitButtonText,),
                    ),

                    ),
               );
                })
              ],
            ),
          )
      )
    );
  }

 void callPostMethod(BuildContext context, WidgetRef ref) {

   if(_formKey.currentState!.validate())
   {
     getCallShoppingListItems(context, ref);
   }

 }

 Future<void> getCallShoppingListItems(BuildContext context, WidgetRef ref) async {
   final sharedPref = ref.watch(sharedPreferencesProvider);
   var userID = sharedPref.value!.getString(Strings.userID);
   final document = FirebaseFirestore.instance
       .collection("users")
       .doc(userID)
       .collection("items")
       .doc();
   await document
       .set({
     'id': document.id,
     'weight': nameController.text,
     'time': DateTime.now()
   })
       .then((value) {
         flutterToastMsg("Weight added successfully");
   })
       .catchError((e) {
     flutterToastMsg(e.toString());
   });
 }
}
