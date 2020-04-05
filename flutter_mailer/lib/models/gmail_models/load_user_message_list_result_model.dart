import 'dart:convert';

import 'gmail_message_result_model.dart';

LoadUserMessageListResultModel loadUserListResultModelFromJson(String str) =>
    LoadUserMessageListResultModel.fromJson(json.decode(str));

String loadUserListResultModelToJson(LoadUserMessageListResultModel data) =>
    json.encode(data.toJson());

class LoadUserMessageListResultModel {
  List<GmailMessageResultModel> messages;
  String nextPageToken;
  int resultSizeEstimate;

  @override
  String toString() {
    return 'LoadUserMessageListResultModel{messages: $messages, nextPageToken: $nextPageToken, resultSizeEstimate: $resultSizeEstimate}';
  }

  LoadUserMessageListResultModel({
    this.messages,
    this.nextPageToken,
    this.resultSizeEstimate,
  });

  factory LoadUserMessageListResultModel.fromJson(Map<String, dynamic> json) =>
      LoadUserMessageListResultModel(
        messages: List<GmailMessageResultModel>.from(
            json["messages"].map((x) => GmailMessageResultModel.fromJson(x))),
        nextPageToken: json["nextPageToken"],
        resultSizeEstimate: json["resultSizeEstimate"],
      );

  Map<String, dynamic> toJson() => {
        "messages": List<dynamic>.from(messages.map((x) => x.toJson())),
        "nextPageToken": nextPageToken,
        "resultSizeEstimate": resultSizeEstimate,
      };
}
