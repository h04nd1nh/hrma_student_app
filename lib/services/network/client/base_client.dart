import 'dart:io';

import 'package:dio/dio.dart' hide Headers;
import 'package:hrm_app/models/DTOs/login_dto.dart';
import 'package:hrm_app/models/action/action_response.dart';
import 'package:hrm_app/models/authentication/authentication_response.dart';
import 'package:hrm_app/models/session/session_request.dart';
import 'package:hrm_app/models/timetable_student/timetable_student_current.dart';
import 'package:hrm_app/models/timetable_student/timetable_student_response.dart';
import 'package:hrm_app/models/timetable_teacher/timetable_teacher_current.dart';
import 'package:hrm_app/models/timetable_teacher/timetable_teacher_response.dart';
import 'package:retrofit/retrofit.dart';

part 'base_client.g.dart';

@RestApi()
abstract class BaseClient {
  factory BaseClient(Dio dio, {String baseUrl}) = _BaseClient;

  @POST("auth/signin")
  Future<HttpResponse<AuthenticationResponse>> login(@Body() LoginDto data);

  @GET("student/timetable")
  Future<TimetableStudentResponse> getStudentTimeTable(
    @Query("day") int? day,
    @Query("month") int month,
    @Query("year") int year,
  );

  @GET("student/timetable_teacher")
  Future<TimetableTeacherResponse> getTeacherTimeTable(
    @Query("day") int? day,
    @Query("month") int month,
    @Query("year") int year,
  );

  @GET("student/current_timetable")
  Future<TimetableStudentCurrentResponse> getCurrentStudentTimeTable();

  @GET("student/current_timetable_teacher")
  Future<TimetableTeacherCurrentResponse> getCurrentTeacherTimeTable();

  @POST("student/checkin_session")
  Future<ActionResponse> createSession(
    @Body() SessionBody body,
  );

  @PUT("student/checkin_session/{id}")
  Future<ActionResponse> checkinSession(
    @Path("id") int sessionId,
  );

  @PUT("student/face_identify")
  @MultiPart()
  Future<ActionResponse> uploadImage(
    @Part(name: "image") File image,
  );
}
