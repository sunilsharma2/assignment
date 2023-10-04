import 'package:flutter/material.dart';
class ErrorScreen extends StatelessWidget {
  final Object e;
  final StackTrace trace;
  const ErrorScreen(this.e, this.trace, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("the object is $e\n the trace is $trace");
    return Scaffold(
      body: Container(
        child: Center(
          child: Text("data"),
        ),
      ),
    );
  }
}
