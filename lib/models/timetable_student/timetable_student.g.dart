// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timetable_student.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimeTableStudent _$TimeTableStudentFromJson(Map<String, dynamic> json) =>
    TimeTableStudent(
      id: (json['id'] as num).toInt(),
      studentId: (json['student_id'] as num).toInt(),
      timeTableTeacherId: (json['time_table_teacher_id'] as num).toInt(),
      teacherName: json['teacher_name'] as String,
      title: json['title'] as String,
      periodId: (json['period_id'] as num).toInt(),
      periodName: json['period_name'] as String,
      roomId: (json['room_id'] as num).toInt(),
      roomName: json['room_name'] as String,
      date: json['date'] as String,
      isCheckin: json['is_checkin'] as bool,
    );

Map<String, dynamic> _$TimeTableStudentToJson(TimeTableStudent instance) =>
    <String, dynamic>{
      'id': instance.id,
      'student_id': instance.studentId,
      'time_table_teacher_id': instance.timeTableTeacherId,
      'teacher_name': instance.teacherName,
      'title': instance.title,
      'period_id': instance.periodId,
      'period_name': instance.periodName,
      'room_id': instance.roomId,
      'room_name': instance.roomName,
      'date': instance.date,
      'is_checkin': instance.isCheckin,
    };
