import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AppUIUtils {
  static void showToast({@required title}) {
    Fluttertoast.showToast(msg: title);
  }
}
