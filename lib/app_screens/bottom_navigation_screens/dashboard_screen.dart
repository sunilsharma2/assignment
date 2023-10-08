import 'dart:io';

import 'package:assignment/app_screens/bottom_navigation_screens/form_screen.dart';
import 'package:assignment/app_screens/bottom_navigation_screens/weight_list_screen.dart';
import 'package:assignment/res/constantcolors.dart';
import 'package:assignment/res/strings.dart';
import 'package:flutter/material.dart';
class DashBoardScreen extends StatelessWidget {
   DashBoardScreen({super.key});
  var pressCount = 0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
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
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text(Strings.dashboard,style: TextStyle(
              color: ConstantColors.secondaryColor,
              fontWeight: FontWeight.w600
            ),),
            bottom: const TabBar(
              tabs: <Widget>[
                Tab(text: 'Form'),
                Tab(text: 'Weight List'),
              ],
            ),
          ),
          body:  TabBarView(
            children: <Widget>[
              FormScreen(),
             const WeightListScreen()
            ],
          ),
        ),
      ),
    );
  }
}
