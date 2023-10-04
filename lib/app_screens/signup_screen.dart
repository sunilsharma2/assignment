import 'package:assignment/app_screens/home_screen.dart';
import 'package:assignment/dialogs/dialog_circular_progress.dart';
import 'package:assignment/mixins/invalidate_mixin.dart';
import 'package:assignment/res/common_widgets/textFormPrefixIconFieldWidget.dart';
import 'package:assignment/res/common_widgets/vertical_widget_spacer.dart';
import 'package:assignment/res/constantcolors.dart';
import 'package:assignment/res/flutterToast_message.dart';
import 'package:assignment/res/strings.dart';
import 'package:assignment/riverpod/future_providers.dart';
import 'package:assignment/riverpod/stateprovider.dart';
import 'package:assignment/services/firebase_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//ignore:must_be_immutable
class SignUpScreen extends StatelessWidget with InvalidateMixin{
  SignUpScreen({super.key});

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
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
                  return   SizedBox(
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
                        child: Text(Strings.signUp,
                        ),
                      ),
                    ),
                  );
                }),
                ],
              ),
            ),
          )
      ),
    );
  }

  Future<void> checkValidation(BuildContext context, WidgetRef ref) async {
    if(_formKey.currentState!.validate())
    {
      showLoaderDialog(context);
      String? userID= await FirebaseService().signUp(email: emailController.text, password: passwordController.text);

      debugPrint("The result is $userID");
      if (userID != null) {
        final sharedPref = ref.watch(sharedPreferencesProvider);
        sharedPref.value!.setString(Strings.userID, userID);
        Future.delayed(const Duration(milliseconds: 1)).then((value) {
          Navigator.pop(context);
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) =>  HomeScreen()));
        });

      } else {
        Future.delayed(const Duration(milliseconds: 1)).then((value) {
          Navigator.pop(context);
          flutterToastMsg("Invalid Login Credential");
        });

      }
    }
  }
}
