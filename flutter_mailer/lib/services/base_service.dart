import 'package:dio/dio.dart';
import 'package:fluttermailer/services/network_exception.dart';
import 'package:get_it/get_it.dart';

import 'base_api_service.dart';
import 'base_network_object.dart';

class BaseService {
  BaseApiService _apiService;

  BaseService({BaseApiService baseApiService}) {
    _apiService = baseApiService ?? GetIt.I<BaseApiService>();
  }

  Future<dynamic> execute(BaseNetworkObject baseNetworkObject) async {
    Response response;
    try {
      response = await _apiService.executeRequest(baseNetworkObject);
    } on Exception catch (e) {
      var error = NetworkException.fromRequestException(response, e);
      print('${baseNetworkObject.requestName()} FAILED: $error');
      return error;
    }
  }
}
