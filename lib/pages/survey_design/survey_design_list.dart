// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:survey_io/bloc/survey/survey_design_list/survey_design_list_bloc.dart';
import 'package:survey_io/common/constants/widgets/profile_section_survey_design.dart';
import 'package:survey_io/pages/login/login.dart';
import 'package:survey_io/pages/survey_design/widgets/main_section.dart';
import 'package:survey_io/common/constants/styles.dart';
import 'package:survey_io/common/constants/colors.dart';
import 'package:survey_io/common/components/appbar.dart';
import 'package:survey_io/models/survey_design/survey_design_model.dart';
import 'package:survey_io/bloc/profile/get_profile/profile_bloc.dart';
import 'package:survey_io/common/constants/widgets/red_shape_card.dart';
import 'package:survey_io/datasources/login/auth_local_datasource.dart';
import 'package:survey_io/datasources/survey_design/list_survey_design.dart';
import 'package:survey_io/pages/tabs/floating_icon.dart';
import 'package:survey_io/pages/tabs/navigation_bottom_bar.dart';

class SurveyDesignList extends StatefulWidget {
  const SurveyDesignList({super.key});

  @override
  State<SurveyDesignList> createState() => _SurveyDesignListState();
}

class _SurveyDesignListState extends State<SurveyDesignList> {
  int selectedIndex = 1;
  bool isLogged = true;

  List<SurveyDesignModel> listSurveyDesign = MySurveyDesign.getSurveyDesign();

  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(const ProfileEvent.getProfile());
    context
        .read<SurveyDesignListBloc>()
        .add(const SurveyDesignListEvent.getSurveyDesignList());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    checkLoginStatus();
  }

  void checkLoginStatus() async {
    final token = await AuthLocalDatasource().getToken();
    if (token.isEmpty) {
      setState(() {
        isLogged = false;
      });
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const LoginPage()));
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
      body: const Stack(children: [
        MainSectionSurveyDesign(),
        RedShapeCircular(),
        ProfileSectionSurveyDesign()
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
