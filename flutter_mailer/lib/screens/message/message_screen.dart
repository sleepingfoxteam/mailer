import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttermailer/models/gmail_models/gmail_message_result_model.dart';

class MessageScreen extends StatelessWidget {
  final GmailMessageResultModel gmailMessageResultModel;

  MessageScreen({this.gmailMessageResultModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          gmailMessageResultModel.snippet,
        ),
      ),
    );
  }
}
