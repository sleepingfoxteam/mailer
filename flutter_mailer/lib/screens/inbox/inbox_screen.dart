import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttermailer/blocs/bloc_index.dart';
import 'package:fluttermailer/blocs/stream_data.dart';
import 'package:fluttermailer/models/gmail_models/load_user_message_list_result_model.dart';
import 'package:fluttermailer/models/model_index.dart';
import 'package:fluttermailer/providers/gmail_provider.dart';
import 'package:fluttermailer/utils/utils_index.dart';
import 'package:get_it/get_it.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

class InboxScreen extends StatefulWidget {
  @override
  _InboxScreenState createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  final _bloc = GetIt.I<InboxBloc>();
  final _gmailProvider = GetIt.I<GmailProvider>();
  ScrollController _controller;

  @override
  void initState() {
    checkMessage();
    _controller = ScrollController();
    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        print("heeeee");
        _bloc.doLoadMoreMessage();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
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
            List list = (value as LoadUserMessageListResultModel)?.messages;
            return ListView.builder(
              controller: _controller,
              itemCount: list?.length ?? 0,
              itemBuilder: (context, index) {
                GmailMessageResultModel gmail = list[index];
                return _getMessageListItem(gmailModel: gmail);
              },
            );
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
    } else {
      _bloc.getGmailMessageProvider();
    }
  }

  Widget _getMessageListItem({GmailMessageResultModel gmailModel}) {
    String from = gmailModel.payload.headers
        .where((i) => i.name == "From")
        .toList()[0]
        .value;
    String subject = gmailModel.payload.headers
        .where((i) => i.name == "Subject")
        .toList()[0]
        .value;
    String snippet = gmailModel.snippet;
    print(subject);
    return GestureDetector(
      onTap: () {
        AppUIUtils.showToast(title: "Implement go to message detail later");
      },
      child: Slidable(
        actionPane: SlidableDrawerActionPane(),
        actionExtentRatio: 0.25,
        actions: <Widget>[
          SlideAction(
            color: Colors.red,
            child: Center(
              child: Icon(Icons.delete),
            ),
            onTap: () {
              AppUIUtils.showToast(title: "Implement delete message later");
            },
          ),
        ],
        secondaryActions: <Widget>[
          SlideAction(
            color: Colors.blue,
            child: Center(
              child: Icon(Icons.archive),
            ),
            onTap: () {
              AppUIUtils.showToast(title: "Implement archived message later");
            },
          )
        ],
        child: Container(
          height: 150,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(from),
              Text(subject),
              Text(snippet),
            ],
          ),
        ),
      ),
    );
  }
}
