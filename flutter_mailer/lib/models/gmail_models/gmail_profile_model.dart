import 'dart:convert';

GmailProfileModel gmailProfileModelFromJson(String str) =>
    GmailProfileModel.fromJson(json.decode(str));

String gmailProfileModelToJson(GmailProfileModel data) =>
    json.encode(data.toJson());

class GmailProfileModel {
  String emailAddress;
  int messagesTotal;
  int threadsTotal;
  String historyId;

  GmailProfileModel({
    this.emailAddress,
    this.messagesTotal,
    this.threadsTotal,
    this.historyId,
  });

  factory GmailProfileModel.fromJson(Map<String, dynamic> json) =>
      GmailProfileModel(
        emailAddress: json["emailAddress"],
        messagesTotal: json["messagesTotal"],
        threadsTotal: json["threadsTotal"],
        historyId: json["historyId"],
      );

  Map<String, dynamic> toJson() => {
        "emailAddress": emailAddress,
        "messagesTotal": messagesTotal,
        "threadsTotal": threadsTotal,
        "historyId": historyId,
      };
}
