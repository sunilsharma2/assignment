import 'package:assignment/app_screens/bottom_navigation_screens/dashboard_screen.dart';
import 'package:assignment/app_screens/bottom_navigation_screens/settings_screen.dart';
import 'package:assignment/res/common_widgets/appbar_widget.dart';
import 'package:assignment/res/constantcolors.dart';
import 'package:assignment/res/strings.dart';
import 'package:assignment/riverpod/stateprovider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
class HomeScreen extends ConsumerWidget {
   HomeScreen({super.key});


  final widgetOptions = [
    DashBoardScreen(),
    SettingsScreen(),

  ];

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final selectedIndex = ref.watch(selectedBottomNavIndexProvider);
    return Scaffold(
      // appBar: AppBarWidget(
      //   title: Strings.appName,
      // ),
      body: SafeArea(child: widgetOptions[selectedIndex]),
      bottomNavigationBar: BottomNavigationBar(
          elevation: 32.0,
          type: BottomNavigationBarType.fixed,
          currentIndex: selectedIndex,
          selectedItemColor: ConstantColors.secondaryColor,
          unselectedItemColor: ConstantColors.appGreyColor,
          onTap: (index) {
            ref.read(selectedBottomNavIndexProvider.notifier).state = index;
          },
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: Strings.dashboard,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: Strings.settings,
            ),


          ]
      ),
    );
  }
}
