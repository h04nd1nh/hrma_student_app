import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrm_app/cubit/teacher/teacher_cubit.dart';

class HomeTeacherPage extends StatefulWidget {
  const HomeTeacherPage({super.key});

  @override
  State<HomeTeacherPage> createState() => _HomeTeacherPageState();
}

class _HomeTeacherPageState extends State<HomeTeacherPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => TeacherCubit(), child: Container());
  }
}
