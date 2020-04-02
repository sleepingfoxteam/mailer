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
}
