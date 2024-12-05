import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrm_app/components/appbar.dart';
import 'package:hrm_app/cubit/student/student_cubit.dart';
import 'package:hrm_app/models/session/session_response.dart';
import 'package:hrm_app/models/timetable_student/timetable_student.dart';

class CheckinStudentPage extends StatefulWidget {
  const CheckinStudentPage({super.key, required this.timeTableStudent});
  final TimeTableStudent timeTableStudent;
  @override
  State<CheckinStudentPage> createState() => _CheckinStudentPageState();
}

class _CheckinStudentPageState extends State<CheckinStudentPage> {
  Session? checkinSession;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        decoration: const BoxDecoration(color: Color(0xfff9f9f9)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AppBarWidget(title: 'Điểm danh lớp học'),
            BlocProvider(
              create: (context) => StudentCubit()
                ..getSession(
                    timeTableTeacherId:
                        widget.timeTableStudent.timeTableTeacherId),
              child: BlocListener<StudentCubit, StudentState>(
                listener: (context, state) {
                  if (state is StudentSessionLoaded) {
                    setState(() {
                      checkinSession = state.events;
                    });
                  }
                },
                child: Container(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.timeTableStudent.title,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "${widget.timeTableStudent.periodName} - ${widget.timeTableStudent.roomName}",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w400),
                        ),
                        Text(
                          "Giảng viên: ${widget.timeTableStudent.teacherName}",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w400),
                        ),
                        Text(
                          "Trạng thái: ${widget.timeTableStudent.isCheckin ? "Đã checkin" : "Chưa checkin"}",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          "Phiên điểm danh",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        (checkinSession != null)
                            ? Text(
                                "Trạng thái: ${widget.timeTableStudent.isCheckin ? "Đã checkin" : "Chưa checkin"}",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w400),
                              )
                            : Text(
                                "Hiện tại chưa có phiên điểm danh nào",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w400),
                              ),
                      ],
                    )),
              ),
            )
          ],
        ),
      )),
    );
  }
}
