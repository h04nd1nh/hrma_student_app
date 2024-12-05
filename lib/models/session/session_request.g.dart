// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SessionBody _$SessionBodyFromJson(Map<String, dynamic> json) => SessionBody(
      timeTableTeacherId: (json['time_table_teacher_id'] as num).toInt(),
    );

Map<String, dynamic> _$SessionBodyToJson(SessionBody instance) =>
    <String, dynamic>{
      'time_table_teacher_id': instance.timeTableTeacherId,
    };
