import 'package:dio/src/response.dart';

class NetworkException {
  final int httpCode;
  final int subCode;
  final String message;
  final int detailCode;

  NetworkException({
    this.httpCode,
    this.subCode,
    this.message,
    this.detailCode: -1,
  });

  @override
  String toString() {
    return "NetworkException{httpCode:$httpCode,subCode:$subCode,message:$message,detailCode:$detailCode}";
  }

  factory NetworkException.fromRequestException(Response response,
      Exception e) {
    return NetworkException(
      message: "Default Exception",
    );
  }
}
