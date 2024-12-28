import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrm_app/components/appbar.dart';
import 'package:hrm_app/cubit/student/student_cubit.dart';
import 'package:hrm_app/models/dialog/dialog.dart';
import 'package:hrm_app/models/session/session_response.dart';
import 'package:hrm_app/models/timetable_student/timetable_student.dart';
import 'package:hrm_app/utils/dialog_utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

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
                  if (state is StudentLoading) {
                    DialogUtils.showLoadingAnimation(context: context);
                  }
                  if (state is StudentSessionLoaded) {
                    if (state.events != null) {
                      setState(() {
                        checkinSession = state.events;
                      });
                    }
                  }
                  if (state is StudentFaceIdentifySuccess) {
                    Navigator.pop(context);
                    DialogUtils.showToastAnimation(
                        dialog: DialogModel(
                            message: "Xác thực khuôn mặt thành công",
                            isSuccess: true),
                        context: context);
                  }
                  if (state is StudentCheckinSuccess) {
                    Navigator.pop(context);
                    DialogUtils.showToastAnimation(
                        dialog: DialogModel(
                            message: "Điểm danh thành công", isSuccess: true),
                        context: context);
                  }
                  if (state is StudentError) {
                    Navigator.pop(context);
                    DialogUtils.showToastAnimation(
                        dialog: DialogModel(
                            message: state.message!, isSuccess: false),
                        context: context);
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
                        (checkinSession == null)
                            ? Text(
                                "Trạng thái: ${widget.timeTableStudent.isCheckin ? "Đã checkin" : "Chưa checkin"}",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w400),
                              )
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Trạng thái: ${widget.timeTableStudent.isCheckin ? "Đã checkin" : "Chưa checkin"}",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  const SizedBox(height: 12),
                                  CountdownButton(
                                    session: checkinSession!,
                                  ),
                                ],
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
  File? _image;

  void checkin(BuildContext context) async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(
        source: ImageSource.camera,
        preferredCameraDevice: CameraDevice.front, // Chọn camera trước
        imageQuality: 85, // Giảm chất lượng ảnh nếu cần để giảm dung lượng
      );

      if (pickedFile != null) {
        await context.read<StudentCubit>().checkinSession(
            image: File(pickedFile.path), sessionId: widget.session.id);
      }
    } catch (e) {
      print("Error capturing image: $e");
    }
  }

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
    endDateTime = startDateTime.add(Duration(minutes: 30));
    // Bắt đầu đếm ngược
    _startCountdown();
  }

  void _startCountdown() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      final now = DateTime.now();

      final difference = endDateTime.difference(now);

      if (difference.isNegative) {
        // Hết thời gian
        timer.cancel();
        setState(() {
          isExpired = true;
          remainingTime = "Đã hết hạn điểm danh! ";
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
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          MaterialButton(
            onPressed: () {
              !isExpired ? checkin(context) : null;
            },
            padding: EdgeInsets.all(0),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
              decoration: BoxDecoration(
                  color: !isExpired ? Color(0xffDE221A) : Colors.grey,
                  borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: Text(
                  'Điểm danh',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Colors.white),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
