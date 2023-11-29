import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:survey_io/bloc/bloc/guest_bloc.dart';
import 'package:survey_io/bloc/profile/edit_profile/edit_profile_bloc.dart';
import 'package:survey_io/bloc/reedem/product_prepaid_list/product_prepaid_list_bloc.dart';
import 'package:survey_io/bloc/reedem/reedem_history/reedem_history_bloc.dart';
import 'package:survey_io/bloc/reedem/topup_prepaid/topup_prepaid_bloc.dart';
import 'package:survey_io/bloc/register/register/register_bloc.dart';
import 'package:survey_io/bloc/register/request_otp/request_otp_bloc.dart';
import 'package:survey_io/bloc/register/verify_otp/verify_otp_bloc.dart';
import 'package:survey_io/bloc/survey/survey_design_list/survey_design_list_bloc.dart';

import 'bloc/login/login_bloc.dart';
import 'bloc/profile/get_profile/profile_bloc.dart';
import 'bloc/polling/polling_result/polling_result_bloc.dart';
import 'bloc/polling/polling_today/polling_today_bloc.dart';
import 'package:survey_io/bloc/logout/logout_bloc.dart';
import 'package:survey_io/bloc/notif/notif_bloc.dart';
import 'package:survey_io/bloc/polling/polling/polling_bloc.dart';
import 'package:survey_io/bloc/polling/polling_done/polling_done_bloc.dart';
import 'package:survey_io/bloc/polling/polling_participate/polling_participate_bloc.dart';
import 'package:survey_io/bloc/survey/ayo_check/survey_ayo_check_bloc.dart';
import 'package:survey_io/bloc/survey/survey_list/survey_list_bloc.dart';
import 'package:survey_io/bloc/survey/survey_popular/survey_popular_bloc.dart';
import 'package:survey_io/pages/splashscreen/splashscreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GuestBloc(),
        ),
        BlocProvider(
          create: (context) => RequestOtpBloc(),
        ),
        BlocProvider(
          create: (context) => VerifyOtpBloc(),
        ),
        BlocProvider(
          create: (context) => RegisterBloc(),
        ),
        BlocProvider(
          create: (context) => LoginBloc(),
        ),
        BlocProvider(
          create: (context) => LogoutBloc(),
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
          create: (context) => PollingDoneBloc(),
        ),
        BlocProvider(
          create: (context) => PollingParticipateBloc(),
        ),
        BlocProvider(
          create: (context) => PollingResultBloc(),
        ),
        BlocProvider(
          create: (context) => SurveyPopularBloc(),
        ),
        BlocProvider(
          create: (context) => SurveyListBloc(),
        ),
        BlocProvider(
          create: (context) => ProfileBloc(),
        ),
        BlocProvider(
          create: (context) => NotifBloc(),
        ),
        BlocProvider(
          create: (context) => SurveyDesignListBloc(),
        ),
        BlocProvider(
          create: (context) => EditProfileBloc(),
        ),
        BlocProvider(
          create: (context) => ProductPrepaidListBloc(),
        ),
        BlocProvider(
          create: (context) => ReedemHistoryBloc(),
        ),
        BlocProvider(
          create: (context) => TopupPrepaidBloc(),
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
