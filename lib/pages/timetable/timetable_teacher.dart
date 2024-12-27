import 'package:flutter/material.dart';

class TimetableTeacherScreen extends StatefulWidget {
  const TimetableTeacherScreen({super.key});

  @override
  State<TimetableTeacherScreen> createState() => _TimetableTeacherScreenState();
}

class _TimetableTeacherScreenState extends State<TimetableTeacherScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(color: Color(0xffffffff)),
        ),
      ),
    );
  }
}
