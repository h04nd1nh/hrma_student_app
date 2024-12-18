import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrm_app/models/action/action_response.dart';
import 'package:hrm_app/models/session/session_response.dart';
import 'package:hrm_app/models/timetable_student/timetable_student.dart';
import 'package:hrm_app/models/timetable_student/timetable_student_current.dart';
import 'package:hrm_app/models/timetable_student/timetable_student_response.dart';
import 'package:hrm_app/services/network/dio/result.dart';
import 'package:hrm_app/services/repository/student_repository/student_repository.dart';

part 'student_state.dart';

class StudentCubit extends Cubit<StudentState> {
  StudentCubit() : super(StudentInitial());

  final StudentRepository _studentRepository = StudentRepositoryImp();

  Future<void> getTimeTable(
      {required int? day, required int month, required int year}) async {
    emit(StudentLoading()); // Thay đổi state sang Loading

    Result<TimetableStudentResponse> result = await _studentRepository
        .getStudentTimeTable(day: day, month: month, year: year);

    result.when(
      success: (response) {
        emit(StudentTimeTableLoaded(response.timeTable));
      },
      error: (error) {
        emit(const StudentError("Có lỗi xảy ra, vui lòng thử lại sau"));
      },
    );
  }

  Future<void> getCurrentTimeTable() async {
    emit(StudentLoading()); // Thay đổi state sang Loading

    Result<TimetableStudentCurrentResponse> result =
        await _studentRepository.getCurrentStudentTimeTable();

    result.when(
      success: (response) {
        emit(StudentCurrentTimeTableLoaded(response.timeTable));
      },
      error: (error) {
        emit(const StudentError("Có lỗi xảy ra, vui lòng thử lại sau"));
      },
    );
  }

  Future<void> getSession({required int timeTableTeacherId}) async {
    emit(StudentLoading()); // Thay đổi state sang Loading

    Result<SessionResponse> result = await _studentRepository.getSession(
        timeTableTeacherId: timeTableTeacherId);

    result.when(
      success: (response) {
        if (response.success == true) {
          emit(StudentSessionLoaded(response.session));
        }
      },
      error: (error) {
        emit(const StudentError("Có lỗi xảy ra, vui lòng thử lại sau"));
      },
    );
  }

  Future<void> checkinSession(
      {required File image, required int sessionId}) async {
    emit(StudentLoading()); // Thay đổi state sang Loading

    Result<ActionResponse> faceIdentifyProcess =
        await _studentRepository.faceIdentify(image: image);

    faceIdentifyProcess.when(
      success: (response) async {
        if (response.success == true) {
          emit(StudentFaceIdentifySuccess());

          Result<ActionResponse> checkinProcess =
              await _studentRepository.checkinSession(sessionId: sessionId);
          checkinProcess.when(
            success: (response) {
              if (response.success == true) {
                emit(StudentCheckinSuccess());
              } else {
                emit(StudentError(response.message));
              }
            },
            error: (error) {
              emit(const StudentError("Có lỗi xảy ra, vui lòng thử lại sau"));
            },
          );
        } else {
          emit(StudentError(response.message));
        }
      },
      error: (error) {
        emit(const StudentError("Có lỗi xảy ra, vui lòng thử lại sau"));
      },
    );
  }
}
