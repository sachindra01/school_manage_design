import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class Logging extends Interceptor {
  final box = GetStorage();
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final box = GetStorage();
    var token = box.read('apiToken');
    options.headers['Authorization'] = 'Bearer $token';
    return super.onRequest(options, handler);
  }

  @override
  Future<void> onResponse(response, ResponseInterceptorHandler handler) async {
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
     var token = box.read('apiToken');
     if (err.response?.statusCode == 403 ||err.response?.statusCode == 401) {
       err.requestOptions.headers["Authorization"] =
                      // ignore: prefer_interpolation_to_compose_strings
                      "Bearer " + token;
            
            }
            
    debugPrint(
      'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}',
    );
    return super.onError(err, handler);
  }
}
