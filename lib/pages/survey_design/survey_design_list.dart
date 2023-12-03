// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:survey_io/bloc/survey_design/survey_design_list/survey_design_list_bloc.dart';
import 'package:survey_io/common/constants/widgets/profile_section_survey_design.dart';
import 'package:survey_io/datasources/guest/auth_local_guest_datasource.dart';
import 'package:survey_io/pages/survey_design/widgets/guest_section.dart';
import 'package:survey_io/pages/survey_design/widgets/main_section.dart';
import 'package:survey_io/common/constants/styles.dart';
import 'package:survey_io/common/constants/colors.dart';
import 'package:survey_io/common/components/appbar.dart';
import 'package:survey_io/bloc/profile/get_profile/profile_bloc.dart';
import 'package:survey_io/common/constants/widgets/red_shape_card.dart';
import 'package:survey_io/datasources/login/auth_save_local_datasource.dart';
import 'package:survey_io/pages/tabs/floating_icon.dart';
import 'package:survey_io/pages/tabs/navigation_bottom_bar.dart';

class SurveyDesignListPage extends StatefulWidget {
  const SurveyDesignListPage({super.key});

  @override
  State<SurveyDesignListPage> createState() => _SurveyDesignListPageState();
}

class _SurveyDesignListPageState extends State<SurveyDesignListPage> {
  int selectedIndex = 1;
  bool isLogged = false;
  bool isGuest = false;

  @override
  void initState() {
    super.initState();
    checkToken();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    checkToken();
  }

  void loadDataSource() {
    context.read<ProfileBloc>().add(const ProfileEvent.getProfile());
    context
        .read<SurveyDesignListBloc>()
        .add(const SurveyDesignListEvent.getSurveyDesignList());
  }

  void checkToken() async {
    final token = await AuthLocalDatasource().getToken();
    final guestToken = await AuthLocalGuestDatasource().getToken();

    // IF TOKEN IS EMPTY
    if (token.isEmpty) {
      // IF GUEST TOKEN NOT EMPTY
      if (guestToken.isNotEmpty) {
        print('Guest Token => $guestToken');
        setState(() {
          isGuest = true;
          isLogged = false;
        });
        loadDataSource();
      } else {
        print('No Guest Token');
      }
    } else {
      // Have User Token
      print('User Token : $token');
      setState(() {
        isGuest = false;
        isLogged = true;
      });
      loadDataSource();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFf8fbff),
      appBar: MainAppBar(
        title: Text(
          'Buat Survei',
          style: TextStyles.h2ExtraBold(
            color: AppColors.white,
          ),
        ),
        badge: true,
      ),
      body: Stack(children: [
        isGuest
            ? const SurveyDesignGuestSection()
            : const MainSectionSurveyDesign(),
        const RedShapeCircular(),
        const ProfileSectionSurveyDesign()
      ]),
      bottomNavigationBar: BottomMenu(
        selectedIndex: selectedIndex,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: const NavigationFloatingIcon(
        isActive: true,
      ),
    );
  }
}
