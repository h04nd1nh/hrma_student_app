import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hrm_app/bloc/authentication/authentication_bloc.dart';
import 'package:hrm_app/enum/enum.dart';
import 'package:hrm_app/pages/authentication/login.dart';
import 'package:page_transition/page_transition.dart';

class PersonalScreen extends StatefulWidget {
  const PersonalScreen({super.key});

  @override
  State<PersonalScreen> createState() => _PersonalScreenState();
}

class _PersonalScreenState extends State<PersonalScreen> {
  String userName = '';
  String email = '';
  Role role = Role.unKnown;

  void _handleLogout(BuildContext context) {
    context.read<AuthBloc>().add(AuthLogoutStarted());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final authState = context.watch<AuthBloc>().state;
    if (authState is AuthAuthenticateSuccess) {
      setState(() {
        userName = authState.user.fullName;
        email = authState.user.identifier;
        role = (authState.user.role == 'teacher') ? Role.teacher : Role.student;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthLogoutSuccess) {
          Navigator.pushReplacement(
              context,
              PageTransition(
                  child: const LoginPage(),
                  type: PageTransitionType.rightToLeftWithFade));
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Container(
            decoration: const BoxDecoration(color: Color(0xffffffff)),
            child: Column(
              children: [
                Center(
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.fromLTRB(10, 70, 0, 10),
                        child: ClipOval(
                          child: Image.network(
                            'https://w7.pngwing.com/pngs/349/288/png-transparent-teacher-education-student-course-school-avatar-child-face-heroes-thumbnail.png',
                            width: 100,
                          ),
                        ),
                      ),
                      Text(
                        userName,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        role == Role.teacher ? 'Giảng viên' : 'Sinh viên',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Column(
                    children: <Widget>[
                      MaterialButton(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                        onPressed: () {},
                        child: Row(
                          children: [
                            Container(
                                width: 40,
                                height: 40,
                                margin: const EdgeInsets.only(right: 20),
                                decoration: BoxDecoration(
                                    color: const Color(0xffeeeff0),
                                    borderRadius: BorderRadius.circular(25),
                                    border: const Border(
                                        bottom: BorderSide(
                                            color: Color(0xffeeeff0),
                                            width: 2))),
                                child: const Center(
                                  child: Icon(
                                    Icons.settings,
                                    color: Color(0xffE54C3F),
                                  ),
                                )),
                            const Text(
                              'Cài đặt',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                      MaterialButton(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                        onPressed: () {},
                        child: Row(
                          children: [
                            Container(
                                width: 40,
                                height: 40,
                                margin: const EdgeInsets.only(right: 20),
                                decoration: BoxDecoration(
                                    color: const Color(0xffeeeff0),
                                    borderRadius: BorderRadius.circular(25),
                                    border: const Border(
                                        bottom: BorderSide(
                                            color: Color(0xffeeeff0),
                                            width: 2))),
                                child: const Center(
                                  child: Icon(
                                    Icons.privacy_tip,
                                    color: Color(0xffE54C3F),
                                  ),
                                )),
                            const Text(
                              'Điều khoản và bảo mật',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                      MaterialButton(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                        onPressed: () {
                          _handleLogout(context);
                        },
                        child: Container(
                          child: Row(
                            children: [
                              Container(
                                  width: 40,
                                  height: 40,
                                  margin: const EdgeInsets.only(right: 20),
                                  decoration: BoxDecoration(
                                    color: const Color(0xffffe5e3),
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: const Center(
                                    child: Icon(
                                      Icons.logout,
                                      color: Color(0xffE54C3F),
                                    ),
                                  )),
                              const Text(
                                'Đăng xuất',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xffE54C3F)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
