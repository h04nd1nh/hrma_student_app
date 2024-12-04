import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

class MockInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // Print request details for debugging
    print('Request: ${options.method} ${options.uri}');
    if (options.path.isNotEmpty && options.path.endsWith("json")) {
      // Load mock JSON from assets
      var assetPath = "assets/jsons/" + options.path;
      if (!assetPath.endsWith("json")) {
        assetPath = assetPath + ".json";
      }
      final response = await rootBundle.loadString(assetPath);
      final jsonResponse = json.decode(response);

      // Delay 5s
      // await Future.delayed(const Duration(seconds: 3));

      // Create a mock response
      handler.resolve(Response(
        requestOptions: options,
        data: jsonResponse,
        statusCode: 200,
      ));
    } else {
      // Proceed with the real network call if necessary
      super.onRequest(options, handler);
    }
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    // TODO: implement onError
    super.onError(err, handler);
  }
}
