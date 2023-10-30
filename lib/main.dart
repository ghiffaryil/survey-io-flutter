import 'package:flutter/material.dart';
import 'package:survey_io/bloc/polling/polling/polling_bloc.dart';
import 'package:survey_io/bloc/survey/ayo_check/survey_ayo_check_bloc.dart';
import 'package:survey_io/bloc/survey/bloc/survey_list_bloc.dart';
import 'package:survey_io/pages/splashscreen/splashscreen.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/login/login_bloc.dart';
import 'bloc/polling/polling_today/polling_today_bloc.dart';
import 'bloc/profile/profile_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginBloc(),
        ),
        BlocProvider(
          create: (context) => SurveyAyoCheckBloc(),
        ),
        BlocProvider(
          create: (context) => PollingBloc(),
        ),
        BlocProvider(
          create: (context) => PollingTodayBloc(),
        ),
        BlocProvider(
          create: (context) => SurveyListBloc(),
        ),
        BlocProvider(
          create: (context) => ProfileBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Survey Io',
        theme: ThemeData(
          scaffoldBackgroundColor: const Color(0xFFFFFFFF),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        home: BlocProvider(
          create: (context) => LoginBloc(),
          child: const SplashScreenPage(),
        ),
      ),
    );
  }
}
