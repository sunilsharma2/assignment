import 'package:flutter/material.dart';
class VerticalInBetweenSpacer extends StatelessWidget {
  const VerticalInBetweenSpacer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.01,
    );
  }
}