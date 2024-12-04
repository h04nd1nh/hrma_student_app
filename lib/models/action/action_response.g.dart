// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'action_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActionResponse _$ActionResponseFromJson(Map<String, dynamic> json) =>
    ActionResponse(
      json['success'] as bool?,
      json['message'] as String?,
    );

Map<String, dynamic> _$ActionResponseToJson(ActionResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
    };
