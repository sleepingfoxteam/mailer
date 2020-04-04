import 'package:dio/src/response.dart';
import 'package:flutter/foundation.dart';

import '../../base_network_object.dart';

class GetUserProfileNetworkObject extends BaseGetObject {
  String uid;

  GetUserProfileNetworkObject({@required this.uid});

  @override
  String apiPath() {
    return "/$uid/profile";
  }

  @override
  Map<String, dynamic> buildQueryParams() {
    return {};
  }

  @override
  parseJson(Response response) {
    return response;
  }

  @override
  String requestName() {
    return "getUserProfile";
  }
}
