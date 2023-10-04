import 'package:assignment/app_screens/login_screen.dart';
import 'package:assignment/dialogs/dialog_logout.dart';
import 'package:assignment/res/common_widgets/appbar_widget.dart';
import 'package:assignment/res/constantcolors.dart';
import 'package:assignment/res/strings.dart';
import 'package:assignment/riverpod/future_providers.dart';
import 'package:assignment/riverpod/stateprovider.dart';
import 'package:assignment/services/firebase_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return WillPopScope(
      onWillPop: () async{
        ref
            .read(selectedBottomNavIndexProvider.notifier)
            .state = 0;
        return false;
      },
      child: Scaffold(
        appBar: const AppBarWidget(title: Strings.settings),
        body: Consumer(builder: (_,WidgetRef ref,__){
          return InkWell(
            onTap: (){
              getCallLogout(context,ref);
            },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(
                    color: ConstantColors.borderLineColor,
                    width: 2,
                  )
              ),
              margin: const EdgeInsets.all(16.0),
              padding: const EdgeInsets.all(16.0),
              width: MediaQuery.of(context).size.width.toDouble(),
              child: const Text(Strings.logout,style: TextStyle(
                  color: ConstantColors.secondaryColor
              ),),
            ),
          );
        })
      ),
    );
  }

  void getCallLogout(BuildContext context, WidgetRef ref) {
    final sharedPref = ref.watch(sharedPreferencesProvider);
    sharedPref.value!.clear();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return DialogLogoutAlert(
            contextAlert: context,
            description: Strings.alertMessageDetails,
          );
        }).then((value) {
      if(value==true)
        {
          FirebaseService().signOut().then((value) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginScreen(),
                ),
                    (route) => false);
          });
        }
    });

  }
}
