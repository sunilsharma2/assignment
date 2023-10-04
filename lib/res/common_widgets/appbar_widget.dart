import 'package:assignment/res/constantcolors.dart';
import 'package:flutter/material.dart';
class AppBarWidget extends StatelessWidget implements PreferredSizeWidget{
  const AppBarWidget({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
     style: const TextStyle(
          color: ConstantColors.secondaryColor,
          fontWeight: FontWeight.w600
      ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
