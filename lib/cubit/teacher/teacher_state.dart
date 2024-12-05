part of 'teacher_cubit.dart';

abstract class TeacherState extends Equatable {
  const TeacherState();

  @override
  List<Object?> get props => [];
}

class TeacherInitial extends TeacherState {}

class TeacherLoading extends TeacherState {}

class TeacherTimeTableLoaded extends TeacherState {
  final List<TimeTableTeacher?> events;

  const TeacherTimeTableLoaded(this.events);

  @override
  List<Object?> get props => [events];
}

class TeacherCurrentTimeTableLoaded extends TeacherState {
  final TimeTableTeacher? events;

  const TeacherCurrentTimeTableLoaded(this.events);

  @override
  List<Object?> get props => [events];
}

class TeacherSessionLoaded extends TeacherState {
  final Session? events;

  const TeacherSessionLoaded(this.events);

  @override
  List<Object?> get props => [events];
}

class TeacherCreateSessionSuccess extends TeacherState {}

class TeacherError extends TeacherState {
  final String? message;

  const TeacherError(this.message);

  @override
  List<Object?> get props => [message];
}
