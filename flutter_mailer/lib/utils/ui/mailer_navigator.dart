import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MailerNavigator {
  final GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();

  Future<dynamic> openScreen(Widget screen, {bool removeOthers: false}) async {
    if (removeOthers) {
      return navKey.currentState.pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => screen),
        (Route<dynamic> route) => false,
      );
    } else {
      return navKey.currentState.push(
        MaterialPageRoute(builder: (context) => screen),
      );
    }
  }

  Future<dynamic> openScreenAndRemoveOthers(Widget page) {
    return openScreen(page, removeOthers: true);
  }

  bool goBackWithData(dynamic result) {
    return navKey.currentState.pop(result);
  }

  bool goBack({String from}) {
    return navKey.currentState.pop();
  }
}
