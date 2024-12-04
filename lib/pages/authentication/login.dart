import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hrm_app/pages/home/home.dart';
import 'package:page_transition/page_transition.dart';

import '../../bloc/authentication/authentication_bloc.dart';
import '../../models/models.dart';
import '../../utils/dialog_utils.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPateState();
}

class _LoginPateState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool rememberPassword = false;
  bool _isSecurePassword = true;
  late final _authState = context.read<AuthBloc>().state;

  late final _emailController = TextEditingController(
    text: (switch (_authState) {
      AuthLoginInitial(email: final email) => email,
      _ => '',
    }),
  );
  late final _passwordController = TextEditingController(
    text: (switch (_authState) {
      AuthLoginInitial(password: final password) => password,
      _ => '',
    }),
  );

  void _handleLogin(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(
            AuthLoginStarted(
              email: _emailController.text,
              password: _passwordController.text,
              rememberPassword: rememberPassword,
            ),
          );
    }
  }

  void _handleRetry(BuildContext context) {
    context.read<AuthBloc>().add(AuthStarted());
  }

  void _onRememberPasswordChanged(bool? value) => setState(() {
        rememberPassword = value!;
      });

  Widget togglePassword() {
    return IconButton(
      onPressed: () {
        setState(() {
          _isSecurePassword = !_isSecurePassword;
        });
      },
      icon: _isSecurePassword
          ? const FaIcon(FontAwesomeIcons.eye)
          : const FaIcon(FontAwesomeIcons.eyeSlash),
      color: Colors.black,
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        print(state.toString());
        switch (state) {
          case AuthLoginFailure():
            DialogUtils.showToastAnimation(
                dialog: DialogModel(
                    message: 'Sai tên tài khoản hoặc mật khẩu',
                    isSuccess: false),
                context: context);
          case AuthLoginSuccess():
            DialogUtils.showToastAnimation(
                dialog: DialogModel(
                    message: 'Đăng nhập thành công', isSuccess: true),
                context: context);
            context.read<AuthBloc>().add(AuthAuthenticateStarted());
          case AuthAuthenticateSuccess():
            Navigator.pushReplacement(
                context,
                PageTransition(
                    child: const HomePage(),
                    type: PageTransitionType.rightToLeftWithFade));
          case AuthLogoutSuccess():
            context.read<AuthBloc>().add(AuthLoginStartedCheck());
            DialogUtils.showToastAnimation(
                dialog: DialogModel(
                    message: 'Đăng xuất thành công', isSuccess: true),
                context: context);
          case AuthAuthenticateUnauthenticated():
            if (state.data != null) {
              setState(() {
                _emailController.text = state.data!.login;
                if (state.data?.password != null) {
                  _passwordController.text = state.data!.password!;
                  _onRememberPasswordChanged(true);
                }
              });
            }
          default:
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Container(
            decoration: const BoxDecoration(color: Color(0xfff9f9f9)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
                  width: double.infinity,
                  height: 200,
                  child: Image.network(
                    'https://play-lh.googleusercontent.com/LuGos7lA8VtGusop5SEs0uaFl5vGhw_YilwKWySWOHzjIZ40ciW_p1xQS1Zn_KE1mAI',
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: 20),
                            child: Text(
                              'Đăng nhập để tiếp tục',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.grey),
                            ),
                          ),
                          AutofillGroup(
                            child: Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(bottom: 15),
                                    child: TextFormField(
                                      cursorColor: Colors.black,
                                      controller: _emailController,
                                      decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 15.0,
                                                horizontal: 15.0),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                              color: Color(0xffDE221A),
                                              width: 1.5,
                                            )),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                            color: Color(0xffDE221A),
                                            width: 2,
                                          ),
                                        ),
                                        fillColor: Color(0xfff9f9f9),
                                        filled: true,
                                        hintText: 'Tên đăng nhập',
                                        hintStyle: const TextStyle(
                                            color: Color.fromRGBO(
                                                124, 125, 125, 1),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Vui lòng nhập tên đăng nhập';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(bottom: 10),
                                    child: TextFormField(
                                      cursorColor: Colors.black,
                                      controller: _passwordController,
                                      obscureText: _isSecurePassword,
                                      decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 15.0,
                                                horizontal: 15.0),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                              color: Color(0xffDE221A),
                                              width: 1.5,
                                            )),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                              color: Color(0xffDE221A),
                                              width: 2,
                                            )),
                                        fillColor: Color(0xfff9f9f9),
                                        filled: true,
                                        hintText: 'Mật khẩu',
                                        hintStyle: const TextStyle(
                                            color: Color.fromRGBO(
                                                124, 125, 125, 1),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400),
                                        suffixIcon: togglePassword(),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Vui lòng nhập mật khẩu';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(bottom: 20),
                                    child: Row(
                                      children: [
                                        Checkbox(
                                          side: BorderSide(
                                            color: Color(0xffDE221A),
                                            width: 2,
                                          ),
                                          fillColor: MaterialStateProperty
                                              .resolveWith<Color>(
                                                  (Set<MaterialState> states) {
                                            if (states.contains(
                                                MaterialState.disabled)) {
                                              return Color(0xffDE221A)
                                                  .withOpacity(.32);
                                            }
                                            if (states.contains(
                                                MaterialState.selected)) {
                                              return Color(0xffDE221A);
                                            }
                                            return Colors.white;
                                          }),
                                          checkColor: Colors.white,
                                          value: rememberPassword,
                                          onChanged: (value) => {
                                            _onRememberPasswordChanged(value)
                                          },
                                        ),
                                        Text(
                                          'Lưu mật khẩu',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xffDE221A),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  MaterialButton(
                                    onPressed: () {
                                      _handleLogin(context);
                                    },
                                    padding: EdgeInsets.all(0),
                                    child: Container(
                                      width: double.infinity,
                                      padding:
                                          EdgeInsets.fromLTRB(0, 15, 0, 15),
                                      decoration: BoxDecoration(
                                          color: Color(0xffDE221A),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: BlocBuilder<AuthBloc, AuthState>(
                                        builder: (context, state) {
                                          switch (state) {
                                            case AuthLoginInProgress():
                                              return const Center(
                                                  child: SizedBox(
                                                width: 26,
                                                height: 26,
                                                child:
                                                    CircularProgressIndicator(
                                                  color: Colors.white,
                                                  strokeCap: StrokeCap.round,
                                                ),
                                              ));
                                            default:
                                              return const Center(
                                                child: Text(
                                                  'Đăng nhập',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Colors.white),
                                                ),
                                              );
                                          }
                                        },
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
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
