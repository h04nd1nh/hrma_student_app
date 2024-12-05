import 'package:hrm_app/core/injectors.dart';
import 'package:hrm_app/models/action/action_response.dart';
import 'package:hrm_app/models/timetable_student/timetable_student_current.dart';
import 'package:hrm_app/models/timetable_student/timetable_student_response.dart';

import 'package:hrm_app/services/network/client/base_client.dart';
import 'package:hrm_app/services/network/dio/result.dart';

abstract class StudentRepository {
  Future<Result<TimetableStudentResponse>> getStudentTimeTable(
      {required int? day, required int month, required int year});

  Future<Result<TimetableStudentCurrentResponse>> getCurrentStudentTimeTable();

  Future<Result<ActionResponse>> checkinSession({required int sessionId});
}

class StudentRepositoryImp extends StudentRepository {
  final BaseClient _baseClient = injector();

  @override
  Future<Result<TimetableStudentResponse>> getStudentTimeTable(
      {required int? day, required int month, required int year}) {
    return runCatchingAsync(() async {
      final response = await _baseClient.getStudentTimeTable(day, month, year);
      return response;
    });
  }

  @override
  Future<Result<TimetableStudentCurrentResponse>> getCurrentStudentTimeTable() {
    return runCatchingAsync(() async {
      final response = await _baseClient.getCurrentStudentTimeTable();
      return response;
    });
  }

  @override
  Future<Result<ActionResponse>> checkinSession({required int sessionId}) {
    return runCatchingAsync(() async {
      final response = await _baseClient.checkinSession(sessionId);
      return response;
    });
  }
}
