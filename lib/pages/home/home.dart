import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrm_app/pages/home_student/home_student.dart';
import 'package:hrm_app/pages/home_teacher/home_teacher.dart';
import 'package:page_transition/page_transition.dart';
import 'package:hrm_app/utils/dialog_utils.dart';

import '../../bloc/authentication/authentication_bloc.dart';
import '../../enum/enum.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String userName = '';
  String email = '';
  Role role = Role.unKnown;
  String selectedInputValue = '';
  List<String> items = [];
  List<Map<String, dynamic>> restaurants = [];

  void _handleLogout() {
    context.read<AuthBloc>().add(AuthLogoutStarted());
  }

  void _prepare() async {
    DialogUtils.showLoadingAnimation(context: context);
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _prepare();
    });
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
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(color: Color(0xffffffff)),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  margin: const EdgeInsets.only(bottom: 20),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(right: 10),
                            child: ClipOval(
                              child: Image.network(
                                'https://w7.pngwing.com/pngs/349/288/png-transparent-teacher-education-student-course-school-avatar-child-face-heroes-thumbnail.png',
                                width: 50,
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                userName,
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w800),
                              ),
                              Text(
                                email,
                                style: const TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                (role == Role.teacher)
                    ? const HomeTeacherPage()
                    : const HomeStudentPage()
              ],
            ),
          ),
        ),
      ),
    );
  }

//   Widget _loadMenu() {
//     switch (role) {
//       case Role.headChef:
//         {
//           return Column(
//             children: [
//               Container(
//                 padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
//                 margin: const EdgeInsets.only(bottom: 15),
//                 child: MaterialButton(
//                   padding: const EdgeInsets.all(0),
//                   onPressed: () {
//                     Navigator.push(
//                         context,
//                         PageTransition(
//                             child: SheetMeatPage(
//                                 restaurantId: restaurants.firstWhere((res) =>
//                                         res['name'] == selectedInputValue)['id']
//                                     as int),
//                             type: PageTransitionType.rightToLeftWithFade));
//                   },
//                   child: Container(
//                     padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
//                     decoration: BoxDecoration(
//                         color: const Color(0xffDE221A),
//                         borderRadius: BorderRadius.circular(10)),
//                     child: const Center(
//                       child: Text('Nguyên vật liệu thịt',
//                           style: TextStyle(color: Colors.white, fontSize: 18)),
//                     ),
//                   ),
//                 ),
//               ),
//               Container(
//                 padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
//                 margin: const EdgeInsets.only(bottom: 15),
//                 child: MaterialButton(
//                   padding: const EdgeInsets.all(0),
//                   onPressed: () {
//                     Navigator.push(
//                         context,
//                         PageTransition(
//                             child: SheetVegetablePage(
//                                 restaurantId: restaurants.firstWhere((res) =>
//                                         res['name'] == selectedInputValue)['id']
//                                     as int),
//                             type: PageTransitionType.rightToLeftWithFade));
//                   },
//                   child: Container(
//                     padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
//                     decoration: BoxDecoration(
//                         color: const Color(0xffDE221A),
//                         borderRadius: BorderRadius.circular(10)),
//                     child: const Center(
//                       child: Text('Nguyên vật liệu rau',
//                           style: TextStyle(color: Colors.white, fontSize: 18)),
//                     ),
//                   ),
//                 ),
//               ),
//               Container(
//                 padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
//                 margin: const EdgeInsets.only(bottom: 15),
//                 child: MaterialButton(
//                   padding: const EdgeInsets.all(0),
//                   onPressed: () {
//                     Navigator.push(
//                         context,
//                         PageTransition(
//                             child: SheetOtherPage(
//                                 restaurantId: restaurants.firstWhere((res) =>
//                                         res['name'] == selectedInputValue)['id']
//                                     as int),
//                             type: PageTransitionType.rightToLeftWithFade));
//                   },
//                   child: Container(
//                     padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
//                     decoration: BoxDecoration(
//                         color: const Color(0xffDE221A),
//                         borderRadius: BorderRadius.circular(10)),
//                     child: const Center(
//                       child: Text('Nguyên vật liệu khác',
//                           style: TextStyle(color: Colors.white, fontSize: 18)),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           );
//         }
//       case Role.restaurantManager:
//         {
//           return Column(
//             children: [
//               Container(
//                 padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
//                 margin: const EdgeInsets.only(bottom: 15),
//                 child: MaterialButton(
//                   padding: const EdgeInsets.all(0),
//                   onPressed: () {
//                     Navigator.push(
//                         context,
//                         PageTransition(
//                             child: SheetBarPage(
//                                 restaurantId: restaurants.firstWhere((res) =>
//                                         res['name'] == selectedInputValue)['id']
//                                     as int),
//                             type: PageTransitionType.rightToLeftWithFade));
//                   },
//                   child: Container(
//                     padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
//                     decoration: BoxDecoration(
//                         color: const Color(0xffDE221A),
//                         borderRadius: BorderRadius.circular(10)),
//                     child: const Center(
//                       child: Text('Nguyên vật liệu bar',
//                           style: TextStyle(color: Colors.white, fontSize: 18)),
//                     ),
//                   ),
//                 ),
//               ),
//               Container(
//                 padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
//                 margin: const EdgeInsets.only(bottom: 15),
//                 child: MaterialButton(
//                   padding: const EdgeInsets.all(0),
//                   onPressed: () {
//                     Navigator.push(
//                         context,
//                         PageTransition(
//                             child: SheetToolSpendingPage(
//                                 restaurantId: restaurants.firstWhere((res) =>
//                                         res['name'] == selectedInputValue)['id']
//                                     as int),
//                             type: PageTransitionType.rightToLeftWithFade));
//                   },
//                   child: Container(
//                     padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
//                     decoration: BoxDecoration(
//                         color: const Color(0xffDE221A),
//                         borderRadius: BorderRadius.circular(10)),
//                     child: const Center(
//                       child: Text('Chi phí công cụ',
//                           style: TextStyle(color: Colors.white, fontSize: 18)),
//                     ),
//                   ),
//                 ),
//               ),
//               Container(
//                 padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
//                 margin: const EdgeInsets.only(bottom: 15),
//                 child: MaterialButton(
//                   padding: const EdgeInsets.all(0),
//                   onPressed: () {
//                     Navigator.push(
//                         context,
//                         PageTransition(
//                             child: OtherSpending(
//                                 retaurantId: restaurants.firstWhere((res) =>
//                                         res['name'] == selectedInputValue)['id']
//                                     as int),
//                             type: PageTransitionType.rightToLeftWithFade));
//                   },
//                   child: Container(
//                     padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
//                     decoration: BoxDecoration(
//                         color: const Color(0xffDE221A),
//                         borderRadius: BorderRadius.circular(10)),
//                     child: const Center(
//                       child: Text('Chi phí khác',
//                           style: TextStyle(color: Colors.white, fontSize: 18)),
//                     ),
//                   ),
//                 ),
//               ),
//               Container(
//                 padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
//                 margin: const EdgeInsets.only(bottom: 15),
//                 child: MaterialButton(
//                   padding: const EdgeInsets.all(0),
//                   onPressed: () {
//                     Navigator.push(
//                         context,
//                         PageTransition(
//                             child: CashLineScreen(
//                                 restaurantId: restaurants.firstWhere((res) =>
//                                         res['name'] == selectedInputValue)['id']
//                                     as int),
//                             type: PageTransitionType.rightToLeftWithFade));
//                   },
//                   child: Container(
//                     padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
//                     decoration: BoxDecoration(
//                         color: const Color(0xffDE221A),
//                         borderRadius: BorderRadius.circular(10)),
//                     child: const Center(
//                       child: Text('Sổ quỹ tiền mặt',
//                           style: TextStyle(color: Colors.white, fontSize: 18)),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           );
//         }
//       default:
//         {
//           return Container();
//         }
//     }
//   }
}
