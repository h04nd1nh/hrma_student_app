import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrm_app/bloc/authentication/authentication_bloc.dart';
import 'package:hrm_app/enum/enum.dart';
import 'package:hrm_app/pages/home/home.dart';
import 'package:hrm_app/pages/personal/personal.dart';
import 'package:hrm_app/pages/timetable/timetable_student.dart';
import 'package:hrm_app/pages/timetable/timetable_teacher.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int seletedIndex = 0;
  Role role = Role.unKnown;
  List<Widget> _screens = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final authState = context.watch<AuthBloc>().state;
    if (authState is AuthAuthenticateSuccess) {
      setState(() {
        role = (authState.user.role == 'teacher') ? Role.teacher : Role.student;
        if (role == Role.teacher) {
          _screens = [
            const HomeScreen(),
            const TimetableTeacherScreen(),
            const PersonalScreen(),
          ];
        }
        if (role == Role.student) {
          _screens = [
            const HomeScreen(),
            const TimetableStudentScreen(),
            const PersonalScreen(),
          ];
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.white,
        shadowColor: Colors.grey,
        surfaceTintColor: Colors.grey,
        indicatorColor: Colors.white,
        selectedIndex: seletedIndex,
        height: 80,
        elevation: 0,
        onDestinationSelected: (index) {
          setState(() {
            seletedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home),
            selectedIcon: Icon(
              Icons.home,
              size: 30,
              color: Color(0xffDE221A),
            ),
            label: 'Trang chủ',
          ),
          NavigationDestination(
            icon: Icon(Icons.calendar_today),
            selectedIcon: Icon(
              Icons.calendar_today,
              size: 30,
              color: Color(0xffDE221A),
            ),
            label: 'Lịch học',
          ),
          NavigationDestination(
            icon: Icon(Icons.person),
            selectedIcon: Icon(
              Icons.person,
              size: 30,
              color: Color(0xffDE221A),
            ),
            label: 'Tài khoản',
          ),
        ],
      ),
      body: _screens[seletedIndex],
    );
  }
}
