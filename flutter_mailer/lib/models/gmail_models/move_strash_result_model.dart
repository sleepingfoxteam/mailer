import 'dart:convert';

MoveStrashResultModel moveStrashResultModelFromJson(String str) =>
    MoveStrashResultModel.fromJson(json.decode(str));

String moveStrashResultModelToJson(MoveStrashResultModel data) =>
    json.encode(data.toJson());

class MoveStrashResultModel {
  String id;
  String threadId;
  List<String> labelIds;
  String snippet;
  String historyId;
  String internalDate;
  int sizeEstimate;

  MoveStrashResultModel({
    this.id,
    this.threadId,
    this.labelIds,
    this.snippet,
    this.historyId,
    this.internalDate,
    this.sizeEstimate,
  });

  factory MoveStrashResultModel.fromJson(Map<String, dynamic> json) =>
      MoveStrashResultModel(
        id: json["id"],
        threadId: json["threadId"],
        labelIds: List<String>.from(json["labelIds"].map((x) => x)),
        snippet: json["snippet"],
        historyId: json["historyId"],
        internalDate: json["internalDate"],
        sizeEstimate: json["sizeEstimate"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "threadId": threadId,
        "labelIds": List<dynamic>.from(labelIds.map((x) => x)),
        "snippet": snippet,
        "historyId": historyId,
        "internalDate": internalDate,
        "sizeEstimate": sizeEstimate,
      };
}
