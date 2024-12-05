import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrm_app/models/action/action_response.dart';
import 'package:hrm_app/models/session/session_response.dart';
import 'package:hrm_app/models/timetable_teacher/timetable_teacher.dart';
import 'package:hrm_app/models/timetable_teacher/timetable_teacher_current.dart';
import 'package:hrm_app/models/timetable_teacher/timetable_teacher_response.dart';
import 'package:hrm_app/services/network/dio/result.dart';
import 'package:hrm_app/services/repository/teacher_repository/teacher_repository.dart';

part 'teacher_state.dart';

class TeacherCubit extends Cubit<TeacherState> {
  TeacherCubit() : super(TeacherInitial());

  final TeacherRepository _teacherRepository = TeacherRepositoryImp();

  Future<void> getTimeTable(
      {required int? day, required int month, required int year}) async {
    emit(TeacherLoading()); // Thay đổi state sang Loading

    Result<TimetableTeacherResponse> result = await _teacherRepository
        .getTeacherTimeTable(day: day, month: month, year: year);

    result.when(
      success: (response) {
        emit(TeacherTimeTableLoaded(response.timeTable));
      },
      error: (error) {
        emit(const TeacherError("Có lỗi xảy ra, vui lòng thử lại sau"));
      },
    );
  }

  Future<void> getCurrentTimeTable() async {
    emit(TeacherLoading()); // Thay đổi state sang Loading

    Result<TimetableTeacherCurrentResponse> result =
        await _teacherRepository.getCurrentTeacherTimeTable();

    result.when(
      success: (response) {
        emit(TeacherCurrentTimeTableLoaded(response.timeTable));
      },
      error: (error) {
        emit(const TeacherError("Có lỗi xảy ra, vui lòng thử lại sau"));
      },
    );
  }

  Future<void> getSession({required int timeTableTeacherId}) async {
    emit(TeacherLoading()); // Thay đổi state sang Loading

    Result<SessionResponse> result = await _teacherRepository.getSession(
        timeTableTeacherId: timeTableTeacherId);

    result.when(
      success: (response) {
        emit(TeacherSessionLoaded(response.session));
      },
      error: (error) {
        emit(const TeacherError("Có lỗi xảy ra, vui lòng thử lại sau"));
      },
    );
  }

  Future<void> createSession({required int timeTableTeacherId}) async {
    emit(TeacherLoading()); // Thay đổi state sang Loading

    Result<ActionResponse> result = await _teacherRepository
        .createcheckinSession(timeTableTeacherId: timeTableTeacherId);

    result.when(
      success: (response) {
        emit(TeacherCreateSessionSuccess());
      },
      error: (error) {
        emit(const TeacherError("Có lỗi xảy ra, vui lòng thử lại sau"));
      },
    );
  }
}
