import 'package:flutter/material.dart';
class VerticalWidgetSpacer extends StatelessWidget {
  const VerticalWidgetSpacer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.03,
    );
  }
}