part of 'student_cubit.dart';

abstract class StudentState extends Equatable {
  const StudentState();

  @override
  List<Object?> get props => [];
}

class StudentInitial extends StudentState {}

class StudentLoading extends StudentState {}

class StudentTimeTableLoaded extends StudentState {
  final List<TimeTableStudent?> events;

  const StudentTimeTableLoaded(this.events);

  @override
  List<Object?> get props => [events];
}

class StudentCurrentTimeTableLoaded extends StudentState {
  final TimeTableStudent? events;

  const StudentCurrentTimeTableLoaded(this.events);

  @override
  List<Object?> get props => [events];
}

class StudentSessionLoaded extends StudentState {
  final Session? events;

  const StudentSessionLoaded(this.events);

  @override
  List<Object?> get props => [events];
}

class StudentFaceIdentifySuccess extends StudentState {}

class StudentCheckinSuccess extends StudentState {}

class StudentError extends StudentState {
  final String? message;

  const StudentError(this.message);

  @override
  List<Object?> get props => [message];
}
