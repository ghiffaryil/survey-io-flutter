// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:survey_io/bloc/profile/get_profile/profile_bloc.dart';
import 'package:survey_io/bloc/survey_design/survey_design_list/survey_design_list_bloc.dart';
import 'package:survey_io/datasources/guest/auth_local_guest_datasource.dart';

// Import Component
import 'package:survey_io/pages/login/login.dart';
import 'package:survey_io/common/constants/images.dart';
import 'package:survey_io/common/constants/colors.dart';
import 'package:survey_io/common/components/appbar.dart';
import 'package:survey_io/pages/tabs/floating_icon.dart';
import 'package:survey_io/common/constants/imageSize.dart';
import 'package:survey_io/models/survey/survey_model.dart';
import 'package:survey_io/pages/home/widgets/main_section.dart';
import 'package:survey_io/pages/notification/notification.dart';
import 'package:survey_io/pages/tabs/navigation_bottom_bar.dart';
import 'package:survey_io/common/constants/widgets/profile_section_coin.dart';
import 'package:survey_io/datasources/survey/data/list_survey_popular.dart';
import 'package:survey_io/datasources/login/auth_save_local_datasource.dart';
import 'package:survey_io/common/constants/widgets/red_shape_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  bool isLogged = false;
  bool isGuest = false;

  List<SurveyModelData> listDataPopularSurvey =
      ListSurveyPopular.getSurveyPopular();

  @override
  void initState() {
    super.initState();
    checkToken();
  }

  void loadDataSource() {
    context.read<ProfileBloc>().add(const ProfileEvent.getProfile());
    context
        .read<SurveyDesignListBloc>()
        .add(const SurveyDesignListEvent.getSurveyDesignList());
  }

  void navigateToLoginPage(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  void checkToken() async {
    final token = await AuthLocalDatasource().getToken();
    final guestToken = await AuthLocalGuestDatasource().getToken();

    // IF TOKEN IS EMPTY
    if (token.isEmpty) {
      // IF GUEST TOKEN NOT EMPTY
      if (guestToken.isNotEmpty) {
        print('Guest Token => $guestToken');
        loadDataSource();
      } else {
        print('No Guest Token');
      }
    } else {
      // Have User Token
      print('User Token : $token');
      print('Guest Token => $guestToken');
      loadDataSource();
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
      body: const Stack(
        children: [
          MainSection(),
          RedShapeCircular(),
          ProfileSectionCoin(),
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
