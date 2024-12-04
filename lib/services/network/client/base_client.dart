import 'package:dio/dio.dart';
import 'package:hrm_app/models/DTOs/login_dto.dart';
import 'package:hrm_app/models/action/action_response.dart';
import 'package:hrm_app/models/authentication/authentication_response.dart';
import 'package:retrofit/retrofit.dart';

part 'base_client.g.dart';

@RestApi()
abstract class BaseClient {
  factory BaseClient(Dio dio, {String baseUrl}) = _BaseClient;

  @POST("auth/signin")
  Future<HttpResponse<AuthenticationResponse>> login(@Body() LoginDto data);
}
