import 'package:dio/dio.dart';
import 'package:hrm_app/services/local_data_source/authentication_local_data_source.dart';

class DioConfig {
  static final DioConfig _instance = DioConfig._internal();
  late final Dio dio;

  DioConfig._internal() {
    dio = Dio(BaseOptions(
      baseUrl: 'https://5223-171-224-181-92.ngrok-free.app/hrmstudent/api/v1/',
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
        try {
          final accessToken = await AuthLocalDataSource().getAccessToken();

          if (accessToken?.isNotEmpty ?? false) {
            options.headers['Authorization'] = 'Bearer $accessToken';
          }
        } catch (e) {
          print('Error fetching access token: $e');
        }

        return handler.next(options); // Tiếp tục request
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
