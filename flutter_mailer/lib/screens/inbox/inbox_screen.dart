import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttermailer/blocs/bloc_index.dart';
import 'package:fluttermailer/blocs/stream_data.dart';
import 'package:fluttermailer/models/gmail_models/load_user_message_list_result_model.dart';
import 'package:fluttermailer/providers/gmail_provider.dart';
import 'package:get_it/get_it.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

class InboxScreen extends StatefulWidget {
  @override
  _InboxScreenState createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  final _bloc = GetIt.I<InboxBloc>();
  final _gmailProvider = GetIt.I<GmailProvider>();

  @override
  void initState() {
    checkMessage();
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
              child: createStreamWidget(
                streamData: _bloc.streamLoadingPercent,
                buildChild: (context, inValue) {
                  return SizedBox(
                    width: 100,
                    height: 100,
                    child: LiquidCircularProgressIndicator(
                      value: inValue ?? 0,
                      valueColor:
                      AlwaysStoppedAnimation(Colors.black.withOpacity(0.5)),
                      backgroundColor: Colors.white,
                      borderColor: Colors.transparent,
                      borderWidth: 0.5,
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
    final mainContent = Container(
      child: Center(
        child: createStreamWidget(
          streamData: _bloc.streamUserMessages,
          buildChild: (context, value) {
            return Text((value as LoadUserMessageListResultModel)
                ?.messages
                ?.length
                ?.toString() ??
                "Loading...");
          },
        ),
      ),
    );
    return Stack(
      children: <Widget>[
        mainOverlay,
        mainContent,
      ],
    );
  }

  void checkMessage() {
    if (_gmailProvider.loadUserMessageListResultModel == null ||
        _gmailProvider.loadUserMessageListResultModel?.messages?.length == 0) {
      _bloc.loadUserMessageList(
        uid: "me",
        includeSpamTrash: false,
        maxResults: 5,
        pageToken: "",
        q: "",
      );
    }
    else {
      _bloc.getGmailMessageProvider();
    }
  }
}
