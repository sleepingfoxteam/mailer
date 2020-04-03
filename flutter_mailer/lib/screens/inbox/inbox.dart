import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttermailer/utils/ui/app_ui.dart';

DateTime currentBackPressed;

class Inbox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        body: Container(
          child: Center(
            child: Text("inbox"),
          ),
        ),
      ),
      onWillPop: () {
        final now = DateTime.now();
        if (currentBackPressed == null ||
            now.difference(currentBackPressed) > Duration(seconds: 2)) {
          AppUIUtils.showToast(title: "Press again to exit");
          currentBackPressed = now;
          return Future.value(false);
        }
        return Future.value(true);
      },
    );
  }
}
