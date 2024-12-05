import 'package:hrm_app/core/injectors.dart';
import 'package:hrm_app/models/action/action_response.dart';
import 'package:hrm_app/models/session/session_request.dart';
import 'package:hrm_app/models/timetable_teacher/timetable_teacher_current.dart';
import 'package:hrm_app/models/timetable_teacher/timetable_teacher_response.dart';

import 'package:hrm_app/services/network/client/base_client.dart';
import 'package:hrm_app/services/network/dio/result.dart';

abstract class TeacherRepository {
  Future<Result<TimetableTeacherResponse>> getTeacherTimeTable(
      {required int? day, required int month, required int year});

  Future<Result<TimetableTeacherCurrentResponse>> getCurrentTeacherTimeTable();

  Future<Result<ActionResponse>> createcheckinSession(
      {required int timeTableTeacherId});
}

class TeacherRepositoryImp extends TeacherRepository {
  final BaseClient _baseClient = injector();

  @override
  Future<Result<TimetableTeacherResponse>> getTeacherTimeTable(
      {required int? day, required int month, required int year}) {
    return runCatchingAsync(() async {
      final response = await _baseClient.getTeacherTimeTable(day, month, year);
      return response;
    });
  }

  @override
  Future<Result<TimetableTeacherCurrentResponse>> getCurrentTeacherTimeTable() {
    return runCatchingAsync(() async {
      final response = await _baseClient.getCurrentTeacherTimeTable();
      return response;
    });
  }

  @override
  Future<Result<ActionResponse>> createcheckinSession(
      {required int timeTableTeacherId}) {
    return runCatchingAsync(() async {
      final response = await _baseClient
          .createSession(SessionBody(timeTableTeacherId: timeTableTeacherId));
      return response;
    });
  }
}
