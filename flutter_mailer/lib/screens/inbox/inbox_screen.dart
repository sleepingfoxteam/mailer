import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttermailer/blocs/bloc_index.dart';
import 'package:fluttermailer/blocs/stream_data.dart';
import 'package:get_it/get_it.dart';

class InboxScreen extends StatefulWidget {
  @override
  _InboxScreenState createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  final _bloc = GetIt.I<InboxBloc>();

  @override
  void initState() {
    _bloc.loadGmailUserProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mainOverlay = createStreamWidget(
        streamData: _bloc.streamIsLoading,
        buildChild: (context, value) {
          return Visibility(
            visible: value ?? true,
            child: Container(
              color: Colors.white,
              child: Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.red,
                ),
              ),
            ),
          );
        });
    final mainContent = Container(
      child: Center(
        child: Text("Inbox screen"),
      ),
    );
    return Stack(
      children: <Widget>[
        mainOverlay,
        mainContent,
      ],
    );
  }
}
