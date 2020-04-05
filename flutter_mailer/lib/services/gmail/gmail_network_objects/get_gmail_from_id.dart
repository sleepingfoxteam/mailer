import 'package:dio/src/response.dart';
import 'package:fluttermailer/models/gmail_models/gmail_message_result_model.dart';
import 'package:fluttermailer/services/base_network_object.dart';

class GetGmailFromIdNetworkObject extends BaseGetObject {
  String uid;
  String id;
  String format;

  GetGmailFromIdNetworkObject({
    this.uid,
    this.id,
    this.format,
  });

  @override
  String apiPath() {
    return "/$uid/messages/$id";
  }

  @override
  Map<String, dynamic> buildQueryParams() {
    return {"format": format};
  }

  @override
  parseJson(Response response) {
    return GmailMessageResultModel.fromJson(response.data);
  }

  @override
  String requestName() {
    return "getGmailMessageFromId";
  }
}
