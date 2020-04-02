import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttermailer/blocs/bloc_index.dart';
import 'package:get_it/get_it.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _bloc = GetIt.I<HomeBloc>();
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
