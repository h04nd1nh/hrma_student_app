// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timetable_teacher.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimeTableTeacher _$TimeTableTeacherFromJson(Map<String, dynamic> json) =>
    TimeTableTeacher(
      id: (json['id'] as num).toInt(),
      teacherId: (json['teacher_id'] as num).toInt(),
      teacherName: json['teacher_name'] as String,
      title: json['title'] as String,
      periodId: (json['period_id'] as num).toInt(),
      periodName: json['period_name'] as String,
      roomId: (json['room_id'] as num).toInt(),
      roomName: json['room_name'] as String,
      date: json['date'] as String,
    );

Map<String, dynamic> _$TimeTableTeacherToJson(TimeTableTeacher instance) =>
    <String, dynamic>{
      'id': instance.id,
      'teacher_id': instance.teacherId,
      'teacher_name': instance.teacherName,
      'title': instance.title,
      'period_id': instance.periodId,
      'period_name': instance.periodName,
      'room_id': instance.roomId,
      'room_name': instance.roomName,
      'date': instance.date,
    };
