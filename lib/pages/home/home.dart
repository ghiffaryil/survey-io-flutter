// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:survey_io/bloc/profile/get_profile/profile_bloc.dart';
import 'package:survey_io/bloc/survey/survey_design_list/survey_design_list_bloc.dart';

// Import Component
import 'package:survey_io/common/components/appbar.dart';
import 'package:survey_io/common/constants/colors.dart';
import 'package:survey_io/common/constants/icons.dart';
import 'package:survey_io/datasources/polling/list_polling_today.dart';
import 'package:survey_io/models/polling/polling_model.dart';
import 'package:survey_io/datasources/survey/data/list_survey_popular.dart';
import 'package:survey_io/pages/login/login.dart';
import 'package:survey_io/pages/survey/list_survey.dart';
import 'package:survey_io/pages/tabs/navigation_bottom_bar.dart';
import 'package:survey_io/pages/tabs/floating_icon.dart';
import 'package:survey_io/pages/home/widgets/main_card.dart';

import 'package:survey_io/pages/notification/notification.dart';
import 'package:survey_io/datasources/login/auth_local_datasource.dart';
import 'package:survey_io/datasources/token/check_token_datasource.dart';
import 'package:survey_io/common/constants/widgets/profile_card.dart';
import 'package:survey_io/common/constants/widgets/red_shape_card.dart';
import 'package:survey_io/common/constants/imageSize.dart';
import 'package:survey_io/common/constants/images.dart';
import 'package:survey_io/models/survey/survey_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  bool isLogged = true;

  List<SurveyModelData> listDataPopularSurvey =
      ListSurveyPopular.getSurveyPopular();
  List<PollingModel> listPollingToday = ListPollingToday.getPollingToday();

  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(const ProfileEvent.getProfile());
    context
        .read<SurveyDesignListBloc>()
        .add(const SurveyDesignListEvent.getSurveyDesignList());
    checkToken();
  }

  void navigateToLoginPage(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  void checkToken() async {
    final token = await AuthLocalDatasource().getToken();

    if (token.isEmpty) {
      setState(() {
        isLogged = false;
      });
      // navigateToLoginPage(context);
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Token Expired'),
            content:
                const Text('Sesi anda telah habis. Silahkan login kembali.'),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                  navigateToLoginPage(context);
                },
              ),
            ],
          );
        },
      );
    } else {
      final result = await CheckTokenDatasource().checkToken();
      result.fold(
        (error) {
          setState(() {
            isLogged = false;
          });
          if (error == 'Token is Expired') {
            // navigateToLoginPage(context);
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Token Expired'),
                  content: const Text(
                      'Sesi anda telah habis. Silahkan login kembali.'),
                  actions: <Widget>[
                    TextButton(
                      child: const Text('OK'),
                      onPressed: () {
                        Navigator.of(context).pop();
                        navigateToLoginPage(context);
                      },
                    ),
                  ],
                );
              },
            );
          } else {
            navigateToLoginPage(context);
          }
        },
        (data) {
          setState(() {
            isLogged = true;
          });
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: MainAppBar(
        title: Image.asset(
          Images.logoHorizontalWhite,
          width: AppWidth.imageSize(context, AppWidth.regular),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const NotificationPage(),
            ),
          );
        },
        badge: true,
      ),
      body: Stack(
        children: [
          MainCard(
            popularSurvey: listDataPopularSurvey,
            pollingToday: listPollingToday,
          ),
          const RedShapeCircular(),
          BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () {
                  return FloatingProfileCard(
                    userFrontName: '-',
                    iconImage: Image.asset(
                      IconName.totalSurvey,
                      width: 40,
                      height: 40,
                    ),
                    label: 'Jumlah Survey',
                    labelValue: '-',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ListSurveiPage(),
                        ),
                      );
                    },
                  );
                },
                loaded: (data) {
                  return BlocBuilder<SurveyDesignListBloc,
                      SurveyDesignListState>(
                    builder: (context, state) {
                      return state.maybeWhen(
                        loaded: (surveyDesignList) {
                          return FloatingProfileCard(
                            userFrontName: data.user.name.split(' ')[0],
                            iconImage: Image.asset(
                              IconName.totalSurvey,
                              width: 40,
                              height: 40,
                            ),
                            label: 'Jumlah Survey',
                            labelValue: surveyDesignList.length.toString(),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ListSurveiPage(),
                                ),
                              );
                            },
                          );
                        },
                        // Handle other states if needed
                        orElse: () {
                          // Handle the default case
                          return FloatingProfileCard(
                            userFrontName: '-',
                            iconImage: Image.asset(
                              IconName.totalSurvey,
                              width: 40,
                              height: 40,
                            ),
                            label: 'Jumlah Survey',
                            labelValue: '-',
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ListSurveiPage(),
                                ),
                              );
                            },
                          );
                        },
                      );
                    },
                  );
                },
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomMenu(
        selectedIndex: selectedIndex,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: const NavigationFloatingIcon(
        isActive: false,
      ),
    );
  }
}
