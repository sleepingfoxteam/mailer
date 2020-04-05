import 'package:dio/dio.dart';
import 'package:fluttermailer/models/model_index.dart';
import 'package:fluttermailer/services/base_network_object.dart';

class LoadUserMessageListNetworkObject extends BaseGetObject {
  String uid;
  bool includeSpamTrash;
  int maxResults;
  String pageToken;
  String q;

  LoadUserMessageListNetworkObject({
    this.uid,
    this.includeSpamTrash: false,
    this.q: "",
    this.pageToken: "",
    this.maxResults: 5,
  });

  @override
  String apiPath() {
    return "/$uid/messages";
  }

  @override
  Map<String, dynamic> buildQueryParams() {
    return {
      "maxResults": maxResults,
      "includeSpamTrash": includeSpamTrash,
      "pageToken": pageToken,
      "maxResults": maxResults,
      "q": q,
    };
  }

  @override
  parseJson(Response response) {
    return LoadUserMessageListResultModel.fromJson(response.data);
  }

  @override
  String requestName() {
    return "loadUserMessageList";
  }
}
