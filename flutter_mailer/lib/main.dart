import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'mailer.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(Mailer());
}
