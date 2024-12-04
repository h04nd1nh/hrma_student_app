import 'package:dio/dio.dart';
import 'package:hrm_app/services/local_data_source/authentication_local_data_source.dart';

class DioConfig {
  static final DioConfig _instance = DioConfig._internal();
  late final Dio dio;

  DioConfig._internal() {
    dio = Dio(BaseOptions(
      baseUrl: 'http://127.0.0.1:8080/hrmstudent/api/v1/',
      connectTimeout: const Duration(minutes: 2),
      receiveTimeout: const Duration(minutes: 2),
      headers: {
        'Access-Control-Allow-Origin': '*',
        'Access-Control-Allow-Credentials': 'true',
        'Access-Control-Allow-Headers': 'Content-Type',
        'Access-Control-Allow-Methods': 'GET,PUT,POST,DELETE',
        'Connection': 'Keep-Alive',
        'Keep-Alive': 'timeout=5, max=1000',
      },
      contentType: 'application/json; charset=utf-8',
      responseType: ResponseType.json,
    ));

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        String? accessToken = await AuthLocalDataSource().getAccessToken();
        if (accessToken != null && accessToken.isNotEmpty) {
          options.headers['access_token'] = accessToken;
        }
        return handler.next(options);
      },
      onError: (error, handler) async {
        if (error.response != null &&
            (error.response!.statusCode ?? 0) >= 400 &&
            (error.response!.statusCode ?? 0) < 500) {
          // Bỏ qua lỗi 40x và trả về phản hồi mặc định
          return handler.resolve(Response(
              requestOptions: error.requestOptions,
              statusCode: error.response?.statusCode,
              data: error.response?.data));
        }
        return handler.next(error); // Tiếp tục với các lỗi khác
      },
    ));
  }

  factory DioConfig() => _instance;
}
