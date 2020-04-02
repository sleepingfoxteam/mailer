import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_fimber/flutter_fimber.dart';
import 'package:fluttermailer/utils/share_preferences_service.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'mailer.dart';

void main() {
  runMyApp();
}

void runMyApp() {
  void _runMyApp() async {
    // Setting for Fimber logging
    Fimber.plantTree(FimberTree(useColors: true));
    Fimber.plantTree(DebugTree(useColors: true));

    // Register share preferences
    SharedPreferences pref = await SharedPreferences.getInstance();
    GetIt getIt = GetIt.instance;
    getIt.registerSingleton<SharePreferenceService>(
        SharePreferenceService(pref: pref));

    // Setting for forcing portrait
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    // run app
    runApp(Mailer());
  }

  WidgetsFlutterBinding.ensureInitialized();

  _runMyApp();
}
