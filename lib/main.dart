// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrm_app/core/injectors.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl_standalone.dart';

import 'pages/authentication/login.dart';
import 'bloc/authentication/authentication_bloc.dart';
import 'services/repository/authentication/authentication_repository.dart';
import 'services/local_data_source/authentication_local_data_source.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('vi_VN', null);
  await findSystemLocale();
  await initializeDependencies();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final AuthLocalDataSource _authLocalDataSource = AuthLocalDataSource();

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => AuthenticationRepositoryImp(
          authLocalDataSource: _authLocalDataSource),
      child: BlocProvider(
        create: (context) => AuthBloc(
          context.read<AuthenticationRepositoryImp>(),
        ),
        child: const AppContent(),
      ),
    );
  }
}

class AppContent extends StatefulWidget {
  const AppContent({super.key});
  @override
  State<AppContent> createState() => _AppContentState();
}

class _AppContentState extends State<AppContent> {
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(AuthAuthenticateStarted());
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: Locale('vi'), // Mặc định là tiếng Việt
      supportedLocales: [
        Locale('vi'),
      ],
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      home: LoginPage(),
    );
  }
}
