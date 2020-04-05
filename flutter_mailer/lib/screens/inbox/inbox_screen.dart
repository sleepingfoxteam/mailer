import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttermailer/blocs/bloc_index.dart';
import 'package:fluttermailer/blocs/stream_data.dart';
import 'package:fluttermailer/models/gmail_models/load_user_message_list_result_model.dart';
import 'package:fluttermailer/models/model_index.dart';
import 'package:fluttermailer/providers/gmail_provider.dart';
import 'package:fluttermailer/screens/message/message_screen.dart';
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
  final _navigator = GetIt.I<MailerNavigator>();
  ScrollController _controller;

  @override
  void initState() {
    checkMessage();
    _controller = ScrollController();
    _bloc.streamProcessState.listen((value) {
      if (value == true) {
        AppUIUtils.showToast(title: "SUCCESS", color: Colors.green);
      } else {
        AppUIUtils.showToast(title: "FAILED", color: Colors.red);
      }
    });
    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
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
    double width = MediaQuery
        .of(context)
        .size
        .width;
    double height = MediaQuery
        .of(context)
        .size
        .height;
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
    final mainContent = Column(
      children: <Widget>[
        Container(
          height: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text(
                "Inbox",
                style: TextStyle(
                  fontSize: 32.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                width: 15.0,
              ),
              Icon(
                Icons.inbox,
                size: 40.0,
              ),
            ],
          ),
        ),
        Container(
          height: height - 100 - 56,
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
        ),
      ],
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
    String gmailId = gmailModel.id;
    return GestureDetector(
      onTap: () {
        _navigator.openScreen(MessageScreen(
          gmailMessageResultModel: gmailModel,
        ));
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
              _bloc.moveMessageToStrash(gmailId: gmailId);
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

  Future doRefreshMessageList() async {
    await _bloc.refreshMessageList();
  }
}
