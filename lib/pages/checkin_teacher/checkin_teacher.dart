import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrm_app/components/appbar.dart';
import 'package:hrm_app/cubit/teacher/teacher_cubit.dart';
import 'package:hrm_app/models/dialog/dialog.dart';
import 'package:hrm_app/models/session/session_teacher_response.dart';
import 'package:hrm_app/models/timetable_teacher/timetable_teacher.dart';
import 'package:hrm_app/utils/dialog_utils.dart';
import 'package:intl/intl.dart';

class CheckinTeacherPage extends StatefulWidget {
  const CheckinTeacherPage({super.key, required this.timeTableTeacher});
  final TimeTableTeacher timeTableTeacher;
  @override
  State<CheckinTeacherPage> createState() => _CheckinTeacherPageState();
}

class _CheckinTeacherPageState extends State<CheckinTeacherPage> {
  final TeacherCubit _teacherCubit = TeacherCubit();
  Session? checkinSession;
  List<StudentInfomation?> checkinStudent = [];
  List<StudentInfomation?> notCheckinStudent = [];
  @override
  void initState() {
    super.initState();
  }

  void createSession() async {
    // Tạo phiên điểm danh
    await _teacherCubit.createSession(
        timeTableTeacherId: widget.timeTableTeacher.id);
    await _teacherCubit.getSession(
        timeTableTeacherId: widget.timeTableTeacher.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        decoration: const BoxDecoration(color: Color(0xfff9f9f9)),
        child: RefreshIndicator.adaptive(
          onRefresh: () async {
            _teacherCubit.getSession(
                timeTableTeacherId: widget.timeTableTeacher.id);
          },
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AppBarWidget(title: 'Điểm danh lớp học'),
                BlocProvider(
                  create: (context) => _teacherCubit
                    ..getSession(
                        timeTableTeacherId: widget.timeTableTeacher.id),
                  child: BlocListener<TeacherCubit, TeacherState>(
                    listener: (context, state) {
                      if (state is TeacherLoading) {
                        DialogUtils.showLoadingAnimation(context: context);
                      }
                      if (state is TeacherSessionLoaded) {
                        DialogUtils.hideLoadingAnimation(context: context);
                        if (state.events != null) {
                          setState(() {
                            checkinSession = state.events!.session;
                            if (state.events!.checkedInStudent != null) {
                              checkinStudent = state.events!.checkedInStudent!;
                            }
                            if (state.events!.notCheckinInStudent != null) {
                              notCheckinStudent =
                                  state.events!.notCheckinInStudent!;
                            }
                          });
                        }
                      }
                      if (state is TeacherError) {
                        Navigator.pop(context);
                        DialogUtils.showToastAnimation(
                            dialog: DialogModel(
                                message: state.message!, isSuccess: false),
                            context: context);
                      }
                      if (state is TeacherCreateSessionSuccess) {
                        DialogUtils.hideLoadingAnimation(context: context);
                        DialogUtils.showToastAnimation(
                            dialog: DialogModel(
                                message: "Tạo phiên điểm danh thành công",
                                isSuccess: true),
                            context: context);
                        _teacherCubit.getSession(
                            timeTableTeacherId: widget.timeTableTeacher.id);
                      }
                    },
                    child: Container(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${widget.timeTableTeacher.subjectId} - ${widget.timeTableTeacher.subjectName}",
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            Text(
                              "${widget.timeTableTeacher.periodName} - ${widget.timeTableTeacher.roomName}",
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w400),
                            ),
                            Text(
                              "Giảng viên: ${widget.timeTableTeacher.teacherName}",
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w400),
                            ),
                            // Text(
                            //   "Trạng thái: ${widget.timeTableTeacher.isCheckin ? "Đã checkin" : "Chưa checkin"}",
                            //   style: TextStyle(
                            //       fontSize: 14, fontWeight: FontWeight.w400),
                            // ),
                            const SizedBox(height: 24),
                            const Text(
                              "Phiên điểm danh",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 24),
                            (checkinSession == null)
                                ? MaterialButton(
                                    onPressed: () {
                                      createSession();
                                    },
                                    padding: const EdgeInsets.all(0),
                                    child: Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 15, 0, 15),
                                      decoration: BoxDecoration(
                                          color: const Color(0xffDE221A),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: const Center(
                                        child: Text(
                                          'Tạo phiên điểm danh',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  )
                                : Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 12),
                                      CountdownButton(
                                        session: checkinSession!,
                                      ),
                                    ],
                                  ),
                            const SizedBox(height: 24),
                            if (checkinSession != null)
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Sinh viên đã điểm danh",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(height: 12),
                                  if (checkinStudent.isNotEmpty)
                                    ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: checkinStudent.length,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          width: double.infinity,
                                          margin:
                                              const EdgeInsets.only(bottom: 12),
                                          child: Card(
                                            borderOnForeground: false,
                                            color: Colors.white,
                                            child: Padding(
                                              padding: const EdgeInsets.all(12),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    checkinStudent[index]!
                                                        .fullName,
                                                    style: const TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  Text(
                                                    checkinStudent[index]!
                                                        .email,
                                                    style: const TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  const Text(
                                    "Sinh viên chưa điểm danh",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(height: 12),
                                  if (notCheckinStudent.isNotEmpty)
                                    ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: notCheckinStudent.length,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          width: double.infinity,
                                          margin:
                                              const EdgeInsets.only(bottom: 12),
                                          child: Card(
                                            borderOnForeground: false,
                                            color: Colors.white,
                                            child: Padding(
                                              padding: const EdgeInsets.all(12),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    notCheckinStudent[index]!
                                                        .fullName,
                                                    style: const TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  Text(
                                                    notCheckinStudent[index]!
                                                        .email,
                                                    style: const TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                ],
                              )
                          ],
                        )),
                  ),
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}

class CountdownButton extends StatefulWidget {
  final Session session; // Thời gian bắt đầu dưới dạng String

  const CountdownButton({Key? key, required this.session}) : super(key: key);

  @override
  _CountdownButtonState createState() => _CountdownButtonState();
}

class _CountdownButtonState extends State<CountdownButton> {
  late DateTime startDateTime; // Thời gian bắt đầu dưới dạng DateTime
  late DateTime endDateTime; // Thời gian kết thúc
  late Timer _timer; // Bộ đếm thời gian
  String remainingTime = ""; // Text hiển thị trên Button
  bool isExpired = false;

  @override
  void initState() {
    super.initState();
    DateTime today = DateTime.now();
    // Parse thời gian bắt đầu
    startDateTime = DateFormat("HH:mm:ss").parse(widget.session.startTime);
    startDateTime = DateTime(
      today.year,
      today.month,
      today.day,
      startDateTime.hour,
      startDateTime.minute,
      startDateTime.second,
    );

    // Tính thời gian kết thúc
    endDateTime = startDateTime.add(const Duration(minutes: 30));
    // Bắt đầu đếm ngược
    _startCountdown();
  }

  void _startCountdown() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final now = DateTime.now();

      final difference = endDateTime.difference(now);

      if (difference.isNegative) {
        // Hết thời gian
        timer.cancel();
        setState(() {
          isExpired = true;
          remainingTime = "Phiên điểm danh đã kết thúc";
        });
      } else {
        // Cập nhật thời gian còn lại
        setState(() {
          remainingTime =
              "${difference.inMinutes}:${(difference.inSeconds % 60).toString().padLeft(2, '0')}";
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // Hủy Timer khi Widget bị dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            remainingTime.isEmpty ? "Loading..." : remainingTime,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
