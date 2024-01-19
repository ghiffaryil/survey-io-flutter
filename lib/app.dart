import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:survey_io/bloc/survey_design/survey_design_demography/survey_design_list_demography_age/survey_design_list_demography_age_bloc.dart';
import 'package:survey_io/bloc/survey_design/survey_design_demography/survey_design_list_demography_children/survey_design_list_demography_children_bloc.dart';
import 'package:survey_io/bloc/survey_design/survey_design_demography/survey_design_list_demography_occupation/survey_design_list_demography_occupation_bloc.dart';
import 'package:survey_io/bloc/survey_design/survey_design_demography/survey_design_list_demography_religion/survey_design_list_demography_religion_bloc.dart';
import 'package:survey_io/bloc/survey_design/survey_design_demography/survey_design_list_demography_marital/survey_design_list_demography_marital_bloc.dart';
import 'package:survey_io/bloc/survey_design/survey_design_demography/survey_design_list_demography_outcome/survey_design_list_demography_outcome_bloc.dart';
import 'package:survey_io/bloc/survey_design/survey_design_demography/survey_design_list_demography_gender/survey_design_list_demography_gender_bloc.dart';
import 'package:survey_io/bloc/survey_design/survey_design_demography/survey_design_list_demography_income/survey_design_list_demography_income_bloc.dart';
import 'package:survey_io/bloc/survey_design/survey_design_demography/survey_design_list_demography_region/survey_design_list_demography_region_bloc.dart';
import 'package:survey_io/bloc/survey_design/survey_design_option/survey_design_list_report_time/survey_design_list_report_time_bloc.dart';
import 'package:survey_io/bloc/survey_design/survey_design_option/survey_design_list_respondent/survey_design_list_respondent_bloc.dart';
import 'package:survey_io/bloc/survey_design/survey_design_option/survey_design_list_scope/survey_design_list_scope_bloc.dart';
import 'package:survey_io/bloc/forgot_pasccode/forgot_passcode_request_otp/forgot_passcode_request_otp_bloc.dart';
import 'package:survey_io/bloc/forgot_pasccode/forgot_passcode_verify_otp/forgot_passcode_verify_otp_bloc.dart';
import 'package:survey_io/bloc/survey_design/survey_design_is_calculate/survey_design_is_calculate_bloc.dart';
import 'package:survey_io/bloc/survey_design/survey_design_is_create/survey_design_is_create_bloc.dart';
import 'package:survey_io/bloc/survey_design/survey_design_payment/survey_design_payment_bloc.dart';
import 'package:survey_io/bloc/survey_design/survey_design_submit/survey_design_submit_bloc.dart';
import 'package:survey_io/bloc/forgot_pasccode/update_passcode/update_passcode_bloc.dart';
import 'package:survey_io/bloc/profile/get_list_city/get_list_city_bloc.dart';
import 'package:survey_io/bloc/profile/get_list_province/get_list_province_bloc.dart';
import 'package:survey_io/bloc/register/register_bloc.dart';
import 'package:survey_io/bloc/request_otp/request_otp_bloc.dart';
import 'package:survey_io/bloc/verify_otp/verify_otp_bloc.dart';
import 'package:survey_io/config/flavor_type.dart';
import 'package:survey_io/config/config.dart';
import 'bloc/login/login_bloc.dart';
import 'bloc/profile/get_profile/profile_bloc.dart';
import 'bloc/polling/polling_result/polling_result_bloc.dart';
import 'bloc/polling/polling_today/polling_today_bloc.dart';
import 'package:survey_io/bloc/logout/logout_bloc.dart';
import 'package:survey_io/bloc/notif/notif_bloc.dart';
import 'package:survey_io/bloc/guest/guest_bloc.dart';
import 'package:survey_io/bloc/polling/polling/polling_bloc.dart';
import 'package:survey_io/bloc/polling/polling_done/polling_done_bloc.dart';
import 'package:survey_io/bloc/profile/edit_profile/edit_profile_bloc.dart';
import 'package:survey_io/bloc/reedem/topup_prepaid/topup_prepaid_bloc.dart';
import 'package:survey_io/bloc/reedem/reedem_history/reedem_history_bloc.dart';
import 'package:survey_io/bloc/reedem/product_prepaid_list/product_prepaid_list_bloc.dart';
import 'package:survey_io/bloc/survey_design/survey_design_list/survey_design_list_bloc.dart';
import 'package:survey_io/bloc/polling/polling_participate/polling_participate_bloc.dart';
import 'package:survey_io/bloc/survey/survey_popular/survey_popular_bloc.dart';
import 'package:survey_io/bloc/survey/ayo_check/survey_ayo_check_bloc.dart';
import 'package:survey_io/bloc/survey/survey_list/survey_list_bloc.dart';
import 'package:survey_io/pages/splashscreen/splashscreen.dart';

MyApp initializeApp(AppConfig config) {
  WidgetsFlutterBinding.ensureInitialized();

  return MyApp(config: config);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.config});
  final AppConfig config;

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
        BlocProvider(
          create: (context) => SurveyDesignSubmitBloc(),
        ),
        BlocProvider(
          create: (context) => GetListProvinceBloc(),
        ),
        BlocProvider(
          create: (context) => GetListCityBloc(),
        ),
        BlocProvider(
          create: (context) => SurveyDesignPaymentBloc(),
        ),
        BlocProvider(
          create: (context) => ForgotPasscodeRequestOtpBloc(),
        ),
        BlocProvider(
          create: (context) => ForgotPasscodeVerifyOtpBloc(),
        ),
        BlocProvider(
          create: (context) => UpdatePasscodeBloc(),
        ),
        BlocProvider(
          create: (context) => SurveyDesignListRespondentBloc(),
        ),
        BlocProvider(
          create: (context) => SurveyDesignListReportTimeBloc(),
        ),
        BlocProvider(
          create: (context) => SurveyDesignListScopeBloc(),
        ),
        BlocProvider(
          create: (context) => SurveyDesignListDemographyAgeBloc(),
        ),
        BlocProvider(
          create: (context) => SurveyDesignListDemographyChildrenBloc(),
        ),
        BlocProvider(
          create: (context) => SurveyDesignListDemographyGenderBloc(),
        ),
        BlocProvider(
          create: (context) => SurveyDesignListDemographyIncomeBloc(),
        ),
        BlocProvider(
          create: (context) => SurveyDesignListDemographyOutcomeBloc(),
        ),
        BlocProvider(
          create: (context) => SurveyDesignListDemographyMaritalBloc(),
        ),
        BlocProvider(
          create: (context) => SurveyDesignListDemographyOccupationBloc(),
        ),
        BlocProvider(
          create: (context) => SurveyDesignListDemographyRegionBloc(),
        ),
        BlocProvider(
          create: (context) => SurveyDesignListDemographyReligionBloc(),
        ),
        BlocProvider(
          create: (context) => SurveyDesignIsCalculateBloc(),
        ),
        BlocProvider(
          create: (context) => SurveyDesignIsCreateBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner:
            FlavorType.dev == config.flavor ? true : false,
        title: config.appName,
        theme: ThemeData(
          scaffoldBackgroundColor: const Color(0xFFFFFFFF),
          // splashColor: Colors.transparent,
          // highlightColor: Colors.transparent,
        ),
        home: BlocProvider(
          create: (context) => LoginBloc(),
          child: const SplashScreenPage(),
        ),
      ),
    );
  }
}
