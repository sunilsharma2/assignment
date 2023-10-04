import 'package:assignment/app_screens/bottom_navigation_screens/shopping_list_screen.dart';
import 'package:assignment/app_screens/bottom_navigation_screens/todo_list_screen.dart';
import 'package:assignment/res/constantcolors.dart';
import 'package:assignment/res/strings.dart';
import 'package:flutter/material.dart';
class DashBoardScreen extends StatelessWidget {
  const DashBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(Strings.dashboard,style: TextStyle(
            color: ConstantColors.secondaryColor,
            fontWeight: FontWeight.w600
          ),),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(text: 'Shopping List'),
              Tab(text: 'Todo List'),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            ShoppingListScreen(),
            TodoListScreen()
          ],
        ),
      ),
    );
  }
}
