import 'package:flutter/material.dart';
import 'package:flutter_neat_and_clean_calendar/flutter_neat_and_clean_calendar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hrm_app/model/time_table_model.dart';

class TimeTablePage extends StatefulWidget {
  const TimeTablePage({super.key});

  @override
  State<TimeTablePage> createState() => _TimeTablePageState();
}

class _TimeTablePageState extends State<TimeTablePage> {
  DateTime? daySelected;
  List<TimeTableModel> _timeTableList = [
    TimeTableModel(
        dayInMonth: "10",
        hour: "7:30",
        title: "Cấu trúc dữ liệu và giải thuật",
        roomTitle: "Phòng 1")
  ];

  List<TimeTableModel?> _timeTableStatus = [];

  final List<NeatCleanCalendarEvent> _eventList = [
    NeatCleanCalendarEvent(
      'Checkin Event',
      startTime: DateTime(2024, 11, 10),
      endTime: DateTime(2024, 11, 10),
      isDone: true,
    ),
  ];

  void getTimeTablebyDate(DateTime date) {
    setState(() {
      daySelected = date;
      _timeTableStatus = _timeTableList
          .where(
            (attendance) => attendance.dayInMonth == date.day.toString(),
          )
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(color: Color(0xfff9f9f9)),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: SvgPicture.asset('assets/icon/arrow-left.svg',
                          width: 10),
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      'Thời khoá biểu',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {},
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
                          eventDoneColor: const Color(0xffC82524),
                          selectedColor: const Color(0xffC82524),
                          selectedTodayColor: const Color(0xffC82524),
                          topRowIconColor: const Color(0xffC82524),
                          todayColor: const Color(0xffC82524),
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
                          onDateSelected: (value) =>
                              {getTimeTablebyDate(value)},
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                        child: const Text(
                          'Lịch học',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w700),
                        ),
                      ),
                      Column(
                        children: _timeTableStatus.map<Widget>((e) {
                          if (e == null) return Container();
                          return Column(children: [
                            Container(
                              padding:
                                  const EdgeInsets.fromLTRB(20, 10, 20, 10),
                              margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: const Border(
                                    left: BorderSide(
                                      color: Color(0xffC82524),
                                      width: 15,
                                    ),
                                  ),
                                  borderRadius: BorderRadius.circular(15)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    e.title,
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    e.hour + " | " + e.roomTitle,
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                          ]);
                        }).toList(),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
