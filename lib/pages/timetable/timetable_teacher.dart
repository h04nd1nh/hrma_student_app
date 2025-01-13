import 'package:flutter/material.dart';
import 'package:flutter_neat_and_clean_calendar/flutter_neat_and_clean_calendar.dart';
import 'package:hrm_app/models/timetable_teacher/timetable_teacher.dart';
import 'package:hrm_app/services/repository/teacher_repository/teacher_repository.dart';
import 'package:intl/intl.dart';

class TimetableTeacherScreen extends StatefulWidget {
  const TimetableTeacherScreen({super.key});

  @override
  State<TimetableTeacherScreen> createState() => _TimetableTeacherScreenState();
}

class _TimetableTeacherScreenState extends State<TimetableTeacherScreen> {
  final TeacherRepository _teacherRepository = TeacherRepositoryImp();
  List<TimeTableTeacher?> _timeTableList = [];
  List<NeatCleanCalendarEvent> _eventList = [];
  DateTime? daySelected;

  void fetchData() async {
    DateTime now = DateTime.now();
    final timeTable = await _teacherRepository.getTeacherTimeTable(
        day: null, month: now.month, year: now.year);

    timeTable.when(
      success: (response) {
        setState(() {
          _timeTableList = response.timeTable.where((e) {
            DateTime dateTime = DateFormat("dd-MM-yyyy").parse(e!.date);
            return dateTime.year == DateTime.now().year &&
                    dateTime.month == DateTime.now().month &&
                    dateTime.day == DateTime.now().day ||
                (daySelected != null &&
                    dateTime.year == daySelected!.year &&
                    dateTime.month == daySelected!.month &&
                    dateTime.day == daySelected!.day);
          }).toList();

          // For Neat Calendar
          _eventList = response.timeTable.map((e) {
            DateTime dateTime = DateFormat("dd-MM-yyyy").parse(e!.date);
            return NeatCleanCalendarEvent(
              "${e.subjectId} - ${e.subjectName}",
              startTime: dateTime,
              endTime: dateTime,
              isDone: false,
            );
          }).toList();
        });
      },
      error: (error) {
        print(error);
      },
    );
  }

  Future<void> _refreshData() async {
    if (daySelected != null) {
      final timeTable = await _teacherRepository.getTeacherTimeTable(
          day: null, month: daySelected!.month, year: daySelected!.year);

      timeTable.when(
        success: (response) {
          setState(() {
            _timeTableList = response.timeTable.where((e) {
              DateTime dateTime = DateFormat("dd-MM-yyyy").parse(e!.date);
              return dateTime.year == daySelected!.year &&
                  dateTime.month == daySelected!.month &&
                  dateTime.day == daySelected!.day;
            }).toList();

            // For Neat Calendar
            _eventList = response.timeTable.map((e) {
              DateTime dateTime = DateFormat("dd-MM-yyyy").parse(e!.date);
              return NeatCleanCalendarEvent(
                "${e.subjectId} - ${e.subjectName}",
                startTime: dateTime,
                endTime: dateTime,
                isDone: true,
              );
            }).toList();
          });
        },
        error: (error) {
          print(error);
        },
      );
    } else {
      DateTime now = DateTime.now();
      final timeTable = await _teacherRepository.getTeacherTimeTable(
          day: now.day, month: now.month, year: now.year);

      timeTable.when(
        success: (response) {
          setState(() {
            _timeTableList = response.timeTable.where((e) {
              DateTime dateTime = DateFormat("dd-MM-yyyy").parse(e!.date);
              return dateTime.year == DateTime.now().year &&
                  dateTime.month == DateTime.now().month &&
                  dateTime.day == DateTime.now().day;
            }).toList();

            // For Neat Calendar
            _eventList = response.timeTable.map((e) {
              DateTime dateTime = DateFormat("dd-MM-yyyy").parse(e!.date);
              return NeatCleanCalendarEvent(
                "${e.subjectId} - ${e.subjectName}",
                startTime: dateTime,
                endTime: dateTime,
                isDone: true,
              );
            }).toList();
          });
        },
        error: (error) {
          print(error);
        },
      );
    }
  }

  void getDayAttendanceData() async {
    if (daySelected == null) return;
    final timeTable = await _teacherRepository.getTeacherTimeTable(
        day: daySelected!.day,
        month: daySelected!.month,
        year: daySelected!.year);

    timeTable.when(
      success: (response) {
        setState(() {
          _timeTableList = response.timeTable;
        });
      },
      error: (error) {
        print(error);
      },
    );
  }

  void getMothnAttendanceData(DateTime date) async {
    final timeTable = await _teacherRepository.getTeacherTimeTable(
        day: null, month: date.month, year: date.year);

    timeTable.when(
      success: (response) {
        setState(() {
          _eventList = response.timeTable.map((e) {
            DateTime dateTime = DateFormat("dd-MM-yyyy").parse(e!.date);
            return NeatCleanCalendarEvent(
              "${e.subjectId} - ${e.subjectName}",
              startTime: dateTime,
              endTime: dateTime,
              isDone: true,
            );
          }).toList();
        });
      },
      error: (error) {
        print(error);
      },
    );
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(color: Color(0xffffffff)),
          child: RefreshIndicator.adaptive(
              color: const Color(0xffDE221A),
              onRefresh: _refreshData,
              child: ListView(
                shrinkWrap: false,
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15)),
                    child: Calendar(
                      startOnMonday: true,
                      weekDays: const [
                        'T2',
                        'T3',
                        'T4',
                        'T5',
                        'T6',
                        'T7',
                        'CN'
                      ],
                      eventsList: _eventList,
                      isExpandable: false,
                      isExpanded: true,
                      hideTodayIcon: true,
                      showEvents: false,
                      eventDoneColor: const Color(0xffDE221A),
                      selectedColor: const Color(0xffDE221A),
                      selectedTodayColor: const Color(0xffDE221A),
                      topRowIconColor: const Color(0xffDE221A),
                      todayColor: const Color(0xffDE221A),
                      eventColor: null,
                      locale: 'vi_VN',
                      expandableDateFormat: 'EEEE, dd. MMMM yyyy',
                      datePickerType: DatePickerType.date,
                      dayOfWeekStyle: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 16),
                      displayMonthTextStyle: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 16),
                      onDateSelected: (value) => {
                        setState(() {
                          daySelected = value;
                          getDayAttendanceData();
                        })
                      },
                      onMonthChanged: (value) =>
                          {getMothnAttendanceData(value)},
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                    child: const Text(
                      'Lịch dạy',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                    ),
                  ),
                  (_timeTableList.isNotEmpty)
                      ? ListView.builder(
                          shrinkWrap: true,
                          itemCount: _timeTableList.length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Container(
                              width: double.infinity,
                              margin: const EdgeInsets.only(
                                  bottom: 12, left: 20, right: 20),
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
                                        "${_timeTableList[index]!.subjectId} - ${_timeTableList[index]!.subjectName!}",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        "${_timeTableList[index]!.periodName} - ${_timeTableList[index]!.roomName}",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      Text(
                                        "Giảng viên: ${_timeTableList[index]!.teacherName}",
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
                      : Center(
                          child: Container(
                            margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                            child: const Text(
                              'Lịch dạy trống',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                ],
              )),
        ),
      ),
    );
  }
}
