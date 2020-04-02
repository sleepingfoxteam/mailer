import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'mailer.dart';
import 'package:flutter_fimber/flutter_fimber.dart';

void main() {
  // Setting for Fimber logging
  Fimber.plantTree(FimberTree(useColors: true));
  Fimber.plantTree(DebugTree(useColors: true));

  // Setting for forcing portrait
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // run app
  runApp(Mailer());
}
