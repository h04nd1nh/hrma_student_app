import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:hrm_app/page/checkin/checkin.dart';
import 'package:hrm_app/page/time_table/time_table.dart';
import 'package:page_transition/page_transition.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Color(0xffC82524),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40.0), // Góc dưới bên trái
                bottomRight: Radius.circular(40.0), // Góc dưới bên phải
              ),
            ),
            child: Row(
              children: [
                SizedBox(
                    height: 50,
                    child: ClipOval(child: Image.asset("assets/img/avt.jpg"))),
                const SizedBox(width: 12),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Đinh Văn Đức Hoàn",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xffffffff),
                      ),
                    ),
                    Text(
                      "B20DCPT090",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xffffffff),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              child: const CheckinPage(),
                              type: PageTransitionType.rightToLeftWithFade));
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: const BoxDecoration(
                        color: Color(0xffC82524),
                        borderRadius: BorderRadius.all(
                            Radius.circular(16)), // Góc dưới bên phải
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            FluentIcons.clock_12_filled,
                            color: Color(0xffffffff),
                          ),
                          SizedBox(width: 12),
                          Text(
                            "Điểm danh",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              color: Color(0xffffffff),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              child: const TimeTablePage(),
                              type: PageTransitionType.rightToLeftWithFade));
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: const BoxDecoration(
                        color: Color(0xffC82524),
                        borderRadius: BorderRadius.all(
                            Radius.circular(16)), // Góc dưới bên phải
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            FluentIcons.calendar_12_filled,
                            color: Color(0xffffffff),
                          ),
                          SizedBox(width: 12),
                          Text(
                            "Lịch học",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              color: Color(0xffffffff),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      )),
    );
  }
}
