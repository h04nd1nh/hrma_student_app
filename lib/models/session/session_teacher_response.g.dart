// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_teacher_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SessionTeacherResponse _$SessionTeacherResponseFromJson(
        Map<String, dynamic> json) =>
    SessionTeacherResponse(
      json['success'] as bool,
      json['session'] == null
          ? null
          : Session.fromJson(json['session'] as Map<String, dynamic>),
      (json['checked_in_students'] as List<dynamic>)
          .map((e) => e == null
              ? null
              : StudentInfomation.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['not_checked_in_students'] as List<dynamic>)
          .map((e) => e == null
              ? null
              : StudentInfomation.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SessionTeacherResponseToJson(
        SessionTeacherResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'session': instance.session,
      'checked_in_students': instance.checkedInStudent,
      'not_checked_in_students': instance.notCheckinInStudent,
    };

Session _$SessionFromJson(Map<String, dynamic> json) => Session(
      (json['id'] as num).toInt(),
      (json['timetable_id'] as num).toInt(),
      json['start_time'] as String,
    );

Map<String, dynamic> _$SessionToJson(Session instance) => <String, dynamic>{
      'id': instance.id,
      'timetable_id': instance.timeTableTeacherId,
      'start_time': instance.startTime,
    };

StudentInfomation _$StudentInfomationFromJson(Map<String, dynamic> json) =>
    StudentInfomation(
      (json['id'] as num).toInt(),
      json['fullname'] as String,
      json['email'] as String,
    );

Map<String, dynamic> _$StudentInfomationToJson(StudentInfomation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fullname': instance.fullName,
      'email': instance.email,
    };
