import 'package:json_annotation/json_annotation.dart';

part 'session_response.g.dart';

@JsonSerializable()
class SessionResponse {
  @JsonKey(name: "success")
  final bool success;

  @JsonKey(name: "session")
  final Session? session;

  SessionResponse(this.success, this.session);

  factory SessionResponse.fromJson(Map<String, dynamic> json) =>
      _$SessionResponseFromJson(json);
  Map<String, dynamic> toJson() => _$SessionResponseToJson(this);
}

@JsonSerializable()
class Session {
  @JsonKey(name: "id")
  final int id;

  @JsonKey(name: "timetable_id")
  final int timeTableTeacherId;

  @JsonKey(name: "start_time")
  final String startTime;

  Session(this.id, this.timeTableTeacherId, this.startTime);

  factory Session.fromJson(Map<String, dynamic> json) =>
      _$SessionFromJson(json);
  Map<String, dynamic> toJson() => _$SessionToJson(this);
}
