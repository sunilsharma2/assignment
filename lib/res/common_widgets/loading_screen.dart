
import 'package:flutter/material.dart';
class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator(
      //color: ConstantColors.secondaryColor,
      strokeWidth: 5.0,
    );
  }
}
