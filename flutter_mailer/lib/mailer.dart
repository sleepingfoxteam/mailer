import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';

import 'blocs/bloc_index.dart';
import 'screens/screens_index.dart';

class Mailer extends StatefulWidget {
  @override
  _MailerState createState() => _MailerState();
}

class _MailerState extends State<Mailer> {
  @override
  void initState() {
    super.initState();
    registerGetIt();
  }

  void registerGetIt() {
    final getIt = GetIt.instance;

    getIt.registerFactory<HomeBloc>(() => HomeBloc());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}
