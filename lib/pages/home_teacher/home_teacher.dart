import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrm_app/cubit/teacher/teacher_cubit.dart';
import 'package:hrm_app/models/timetable_teacher/timetable_teacher.dart';
import 'package:hrm_app/pages/checkin_teacher/checkin_teacher.dart';
import 'package:page_transition/page_transition.dart';

class HomeTeacherPage extends StatefulWidget {
  const HomeTeacherPage({super.key});

  @override
  State<HomeTeacherPage> createState() => _HomeTeacherPageState();
}

class _HomeTeacherPageState extends State<HomeTeacherPage> {
  final TeacherCubit _teacherCubit = TeacherCubit();
  TimeTableTeacher? currentTimeTable;
  List<TimeTableTeacher?> timeTableToday = [];

  @override
  void dispose() {
    _teacherCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => _teacherCubit
          ..getCurrentTimeTable()
          ..getTimeTable(
              day: DateTime.now().day,
              month: DateTime.now().month,
              year: DateTime.now().year),
        child: BlocListener<TeacherCubit, TeacherState>(
          listener: (context, state) {
            if (state is TeacherCurrentTimeTableLoaded) {
              setState(() {
                currentTimeTable = state.events;
                print(currentTimeTable);
              });
            }
            if (state is TeacherTimeTableLoaded) {
              if (state.events.isNotEmpty) {
                setState(() {
                  timeTableToday = [...state.events];
                });
              }
            }
          },
          child: Container(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                (currentTimeTable != null)
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Lớp học hiện tại",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 12),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      child: CheckinTeacherPage(
                                        timeTableTeacher: currentTimeTable!,
                                      ),
                                      type: PageTransitionType
                                          .rightToLeftWithFade));
                            },
                            child: SizedBox(
                              width: double.infinity,
                              child: Card(
                                borderOnForeground: false,
                                color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        currentTimeTable!.title,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        "${currentTimeTable!.periodName} - ${currentTimeTable!.roomName}",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      Text(
                                        "Giảng viên: ${currentTimeTable!.teacherName}",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                        ],
                      )
                    : Container(),
                (timeTableToday.isNotEmpty)
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Các tiết học hôm nay",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 12),
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: timeTableToday.length,
                            itemBuilder: (context, index) {
                              return Container(
                                width: double.infinity,
                                margin: const EdgeInsets.only(bottom: 12),
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
                                          timeTableToday[index]!.title,
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Text(
                                          "${timeTableToday[index]!.periodName} - ${timeTableToday[index]!.roomName}",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        Text(
                                          "Giảng viên: ${timeTableToday[index]!.teacherName}",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          )
                        ],
                      )
                    : Text(
                        "Hôm nay bạn không có tiết học nào!",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      )
              ],
            ),
          ),
        ));
  }
}
