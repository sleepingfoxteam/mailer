import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttermailer/providers/provider_index.dart';
import 'package:fluttermailer/repositories/repository_index.dart';
import 'package:fluttermailer/services/base_api_service.dart';
import 'package:fluttermailer/services/gmail/gmail_network_services.dart';
import 'package:fluttermailer/utils/utils_index.dart';
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

    //Singletons
    getIt.registerSingleton<UserInfoProvider>(UserInfoProvider());
    getIt.registerSingleton<MailerNavigator>(MailerNavigator());
    getIt.registerSingleton<GmailProvider>(GmailProvider());

    // Factories
    getIt.registerFactory<HomeBloc>(() => HomeBloc());
    getIt.registerFactory<InboxBloc>(() => InboxBloc());
    getIt.registerFactory<BaseApiService>(() => BaseApiService());
    getIt.registerFactory<GmailRepo>(() => GmailRepo());
    getIt.registerFactory<GmailNetworkService>(() => GmailNetworkService());
  }

  @override
  Widget build(BuildContext context) {
    final getIt = GetIt.I<MailerNavigator>();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: getIt.navKey,
      home: Home(),
    );
  }
}
