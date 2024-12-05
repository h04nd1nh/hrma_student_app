// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SessionResponse _$SessionResponseFromJson(Map<String, dynamic> json) =>
    SessionResponse(
      json['success'] as bool,
      json['session'] == null
          ? null
          : Session.fromJson(json['session'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SessionResponseToJson(SessionResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'session': instance.session,
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
