// To parse this JSON data, do
//
//     final gmailMessageResultModel = gmailMessageResultModelFromJson(jsonString);

import 'dart:convert';

GmailMessageResultModel gmailMessageResultModelFromJson(String str) =>
    GmailMessageResultModel.fromJson(json.decode(str));

String gmailMessageResultModelToJson(GmailMessageResultModel data) =>
    json.encode(data.toJson());

class GmailMessageResultModel {
  String id;
  String threadId;
  List<String> labelIds;
  String snippet;
  String historyId;
  String internalDate;
  Payload payload;
  int sizeEstimate;

  GmailMessageResultModel({
    this.id,
    this.threadId,
    this.labelIds,
    this.snippet,
    this.historyId,
    this.internalDate,
    this.payload,
    this.sizeEstimate,
  });

  @override
  String toString() {
    return 'GmailMessageResultModel{id: $id, threadId: $threadId, snippet: $snippet, internalDate: $internalDate}';
  }

  factory GmailMessageResultModel.fromJson(Map<String, dynamic> json) =>
      GmailMessageResultModel(
        id: json["id"],
        threadId: json["threadId"],
        labelIds: List<String>.from(json["labelIds"]?.map((x) => x) ?? []),
        snippet: json["snippet"] ?? "",
        historyId: json["historyId"] ?? "",
        internalDate: json["internalDate"] ?? "",
        payload: Payload.fromJson(json["payload"] ?? {}),
        sizeEstimate: json["sizeEstimate"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "threadId": threadId,
        "labelIds": List<dynamic>.from(labelIds.map((x) => x)),
        "snippet": snippet,
        "historyId": historyId,
        "internalDate": internalDate,
        "payload": payload.toJson(),
        "sizeEstimate": sizeEstimate,
      };
}

class Payload {
  String partId;
  String mimeType;
  String filename;
  List<Header> headers;
  PayloadBody body;
  List<Part> parts;

  Payload({
    this.partId,
    this.mimeType,
    this.filename,
    this.headers,
    this.body,
    this.parts,
  });

  factory Payload.fromJson(Map<String, dynamic> json) => Payload(
        partId: json["partId"] ?? "",
        mimeType: json["mimeType"] ?? "",
        filename: json["filename"] ?? "",
        headers: List<Header>.from(
            json["headers"]?.map((x) => Header.fromJson(x)) ?? []),
        body: PayloadBody.fromJson(json["body"] ?? {}),
        parts:
            List<Part>.from(json["parts"]?.map((x) => Part.fromJson(x)) ?? []),
      );

  Map<String, dynamic> toJson() => {
        "partId": partId,
        "mimeType": mimeType,
        "filename": filename,
        "headers": List<dynamic>.from(headers.map((x) => x.toJson())),
        "body": body.toJson(),
        "parts": List<dynamic>.from(parts.map((x) => x.toJson())),
      };
}

class PayloadBody {
  int size;

  PayloadBody({
    this.size,
  });

  factory PayloadBody.fromJson(Map<String, dynamic> json) => PayloadBody(
        size: json["size"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "size": size,
      };
}

class Header {
  String name;
  String value;

  Header({
    this.name,
    this.value,
  });

  factory Header.fromJson(Map<String, dynamic> json) => Header(
        name: json["name"] ?? "",
        value: json["value"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "value": value,
      };
}

class Part {
  String partId;
  String mimeType;
  String filename;
  List<Header> headers;
  PartBody body;

  Part({
    this.partId,
    this.mimeType,
    this.filename,
    this.headers,
    this.body,
  });

  factory Part.fromJson(Map<String, dynamic> json) => Part(
        partId: json["partId"] ?? "",
        mimeType: json["mimeType"] ?? "",
        filename: json["filename"] ?? "",
        headers: List<Header>.from(
            json["headers"]?.map((x) => Header.fromJson(x)) ?? []),
        body: PartBody.fromJson(json["body"] ?? {}),
      );

  Map<String, dynamic> toJson() => {
        "partId": partId,
        "mimeType": mimeType,
        "filename": filename,
        "headers": List<dynamic>.from(headers.map((x) => x.toJson())),
        "body": body.toJson(),
      };
}

class PartBody {
  int size;
  String data;

  PartBody({
    this.size,
    this.data,
  });

  factory PartBody.fromJson(Map<String, dynamic> json) => PartBody(
        size: json["size"] ?? 0,
        data: json["data"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "size": size,
        "data": data,
      };
}
