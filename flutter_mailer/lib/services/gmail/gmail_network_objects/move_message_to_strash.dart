import 'package:dio/src/response.dart';
import 'package:fluttermailer/models/model_index.dart';
import 'package:fluttermailer/services/base_network_object.dart';

class MoveMessageToStrashNetworkObject extends BasePostObject {
  final String gmailId;

  MoveMessageToStrashNetworkObject({
    this.gmailId,
  });

  @override
  String apiPath() {
    return "/me/messages/$gmailId/trash";
  }

  @override
  Map<String, dynamic> buildPostData() {
    return {};
  }

  @override
  Map<String, dynamic> buildQueryParams() {
    return {};
  }

  @override
  parseJson(Response response) {
    return MoveStrashResultModel.fromJson(response.data);
  }

  @override
  String requestName() {
    return "moveMessageToTrash";
  }
}
