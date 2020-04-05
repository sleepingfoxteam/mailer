import 'package:dio/dio.dart';

abstract class BaseNetworkObject {
  /// Use requestName for debug purpose only
  String requestName();

  String apiPath();

  String method();

  Map<String, dynamic> buildQueryParams();

  dynamic parseJson(Response response);
}

abstract class BaseGetObject<T> implements BaseNetworkObject {
  String method() {
    return "GET";
  }
}

abstract class BasePostObject<T> implements BaseNetworkObject {
  String method() {
    return "POST";
  }

  Map<String, dynamic> buildPostData();
}

abstract class BasePutObject<T> implements BaseNetworkObject {
  String method() {
    return "PUT";
  }

  Map<String, dynamic> buildPostData();
}

abstract class BaseDeleteObject<T> implements BaseNetworkObject {
  String method() {
    return "DELETE";
  }

  Map<String, dynamic> buildPostData();
}
