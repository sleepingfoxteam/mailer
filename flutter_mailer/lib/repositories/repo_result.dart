import 'package:fluttermailer/repositories/network_exception.dart';

class RepoResult<T> {
  T _data;

  NetworkException _exception;

  T get data => _data;

  NetworkException get exception => _exception;

  RepoResult(T data, NetworkException exception) {
    _data = data;
    _exception = exception;
  }

  bool isSuccess() {
    return _data != null;
  }

  bool isError() {
    return _exception != null;
  }

  factory RepoResult.success(T data) {
    return RepoResult(data, null);
  }

  factory RepoResult.error(NetworkException exception) {
    return RepoResult(null, exception);
  }

  factory RepoResult.from(dynamic value) {
    if (value is NetworkException) {
      return RepoResult.error(value);
    } else {
      return RepoResult.success(value);
    }
  }

  @override
  String toString() {
    if (this.isSuccess()) {
      return "RepoSUCCESS:$_data";
    } else {
      return "RepoERROR:$_exception";
    }
  }
}
