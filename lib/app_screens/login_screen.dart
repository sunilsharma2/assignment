
import 'dart:io';

import 'package:assignment/app_screens/home_screen.dart';
import 'package:assignment/app_screens/signup_screen.dart';
import 'package:assignment/dialogs/dialog_circular_progress.dart';
import 'package:assignment/mixins/invalidate_mixin.dart';
import 'package:assignment/res/common_widgets/vertical_widget_spacer.dart';
import 'package:assignment/res/constantcolors.dart';
import 'package:assignment/res/flutterToast_message.dart';
import 'package:assignment/res/strings.dart';
import 'package:assignment/riverpod/future_providers.dart';
import 'package:assignment/riverpod/stateprovider.dart';
import 'package:assignment/services/firebase_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/signed_model.dart';
import '../res/common_widgets/appbar_widget.dart';
import '../res/common_widgets/textFormPrefixIconFieldWidget.dart';


//ignore:must_be_immutable
class LoginScreen extends StatelessWidget with InvalidateMixin{
  LoginScreen({Key? key}) : super(key: key);

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var pressCount = 0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        pressCount++;

        if (pressCount == 2) {
          exit(0);
        } else {
          var snackBar = const SnackBar(
              content: Text('press another time to exit from app'));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          Future.delayed(const Duration(seconds: 1, milliseconds: 500), () {
            pressCount--;
          });
          return false;
        }
      },
      child: Scaffold(
        //appBar: const AppBarWidget(title: Strings.appName),
        body: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Consumer(builder: (_, WidgetRef ref, __) {
                  return TextFormFieldPrefixIconWidget(
                    textName: Strings.emailText,
                    prefixIcon: const Icon(Icons.email_outlined),
                    textInputType: TextInputType.emailAddress,
                    hintText: Strings.emailHintText,
                    controller: emailController,
                    validator: (value) {
                      if (!isEmailValid(value)) {
                        return Strings.invalidEmailMessage;
                      }
                      return null;
                    },
                    isObscure: false,
                  );
                }),
                const VerticalWidgetSpacer(),
                Consumer(builder: (_, WidgetRef ref, __) {
                  return TextFormFieldPrefixIconWidget(
                    textName: Strings.passwordText,
                    prefixIcon: const Icon(Icons.lock_outline),
                    // suffixIcon: const Icon(Icons.visibility_off),
                    // iconCallBack: (){
                    //   ref.watch(commonBoolValue)?ref.read(commonBoolValue.notifier).state=true:
                    //   ref.read(commonBoolValue.notifier).state=false;
                    // },
                    textInputType: TextInputType.visiblePassword,
                    hintText: Strings.passwordHintText,
                    controller: passwordController,
                    validator: (value) {
                      if (!isValidPassword(value)) {
                        return Strings.invalidPasswordMessage;
                      }
                      return null;
                    },
                    isObscure: ref.watch(commonBoolValue),
                  );
                }),

                const VerticalWidgetSpacer(),
                Consumer(builder: (_,WidgetRef ref,__){
                  return SizedBox(
                    width: MediaQuery.of(context).size.width.toDouble(),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: ConstantColors.secondaryColor
                      ),
                      onPressed: (){
                        checkValidation(context,ref);
                      },

                      child: const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(Strings.login,

                        ),
                      ),
                    ),
                  );
                }),
                const VerticalWidgetSpacer(),
                TextButton(onPressed: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignUpScreen()));
                },
                    child: const Text(Strings.signUp,
                    style: TextStyle(
                      color: ConstantColors.secondaryColor,
                      fontSize: 16.0
                    ),
                    )
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void checkValidation(BuildContext context, WidgetRef ref) async{
    if(_formKey.currentState!.validate())
      {
        showLoaderDialog(context);
        String? userID=await FirebaseService().signIn(email: emailController.text, password: passwordController.text);


        debugPrint("the userID is ${userID}");
        if(userID!=null)
          {
            final sharedPref = ref.watch(sharedPreferencesProvider);
            sharedPref.value!.setString(Strings.userID, userID);
            Future.delayed(const Duration(microseconds: 1)).then((value) {
              Navigator.of(context).pop();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => HomeScreen()));
            });

          }
        else{
          Future.delayed(const Duration(microseconds: 1)).then((value) {
            Navigator.of(context).pop();
            flutterToastMsg("Invalid Login Credential");
          });

        }
      }
  }
}
