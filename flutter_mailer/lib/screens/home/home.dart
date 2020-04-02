import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttermailer/blocs/bloc_index.dart';
import 'package:fluttermailer/screens/inbox/inbox.dart';
import 'package:fluttermailer/utils/utils_index.dart';
import 'package:get_it/get_it.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _bloc = GetIt.I<HomeBloc>();
  final _navigator = GetIt.I<MailerNavigator>();

  @override
  void initState() {
    super.initState();

    // Navigate to Inbox if use had logged in
    _bloc.streamAccessToken.listen((value) {
      if (value != null && value.isNotEmpty) {
        _navigator.openScreenAndRemoveOthers(Inbox());
      }
    });

    // check user login
    _bloc.checkUserLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: RaisedButton(
            child: Text("Sign in with Google"),
            onPressed: () {
              _bloc.doGoogleSignIn();
            },
          ),
        ),
      ),
    );
  }
}
