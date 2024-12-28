// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timetable_teacher_current.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimetableTeacherCurrentResponse _$TimetableTeacherCurrentResponseFromJson(
        Map<String, dynamic> json) =>
    TimetableTeacherCurrentResponse(
      json['success'] as bool,
      json['data'] == null
          ? null
          : TimeTableTeacher.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TimetableTeacherCurrentResponseToJson(
        TimetableTeacherCurrentResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.timeTable,
    };
