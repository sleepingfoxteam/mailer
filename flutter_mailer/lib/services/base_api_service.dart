import 'package:dio/dio.dart';
import 'package:fluttermailer/keys.dart';
import 'package:fluttermailer/providers/provider_index.dart';
import 'package:fluttermailer/services/base_api_urls.dart';
import 'package:fluttermailer/utils/share_preferences_service.dart';
import 'package:get_it/get_it.dart';

import 'base_network_object.dart';

class BaseApiService {
  UserInfoProvider _userInfoProvider;
  Dio _dio;

  BaseApiService(
      {UserInfoProvider userInfoProvider,
      SharePreferenceService sharePreferenceService}) {
    // get userInfoProvider from global
    _userInfoProvider = userInfoProvider ?? GetIt.I<UserInfoProvider>();

    // create BaseOptions
    BaseOptions baseOptions = BaseOptions(
      baseUrl: GMAIL_URL,
      // 60 sec
      connectTimeout: 600000,
      // 60 sec
      receiveTimeout: 600000,
      headers: {
        "authorization": "Bearer ${_userInfoProvider.accessToken}",
      },
    );

    _dio = Dio(baseOptions);
    _dio.interceptors.add(LogInterceptor(
      responseBody: true,
      //true,
      responseHeader: false,
      error: true,
      request: true,
      requestHeader: true,
      requestBody: false,
    ));
  }

  Future<dynamic> executeRequest(BaseNetworkObject networkObject) async {
    var queryParams = networkObject.buildQueryParams();

    // Add API key if it isn't included in the queryParams
    if (!queryParams.containsKey('key')) {
      String key = ANDROID_KEY;
      queryParams['key'] = key;
    }

    Response response;
    if (networkObject is BasePostObject) {
      response = await _dio.post(
        networkObject.apiPath(),
        data: networkObject.buildPostData(),
        queryParameters: queryParams,
      );
    } else {
      // Default is GET request
      response = await _dio.get(
        networkObject.apiPath(),
        queryParameters: queryParams,
      );
    }

    return response;
  }
}
