// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:survey_io/bloc/profile/get_profile/profile_bloc.dart';
import 'package:survey_io/bloc/survey_design/survey_design_list/survey_design_list_bloc.dart';
import 'package:survey_io/common/constants/icons.dart';
import 'package:survey_io/common/constants/widgets/profile_card.dart';
import 'package:survey_io/common/constants/widgets/profile_section_survey_design.dart';
import 'package:survey_io/datasources/guest/auth_local_guest_datasource.dart';
import 'package:survey_io/datasources/survey_design/repository/localRepositoryPrice.dart';
import 'package:survey_io/pages/profile/edit_profile_complete.dart';
import 'package:survey_io/pages/survey_design/survey_design.dart';
import 'package:survey_io/pages/survey_design/widgets/guest_section.dart';
import 'package:survey_io/pages/survey_design/widgets/main_section.dart';
import 'package:survey_io/common/constants/styles.dart';
import 'package:survey_io/common/constants/colors.dart';
import 'package:survey_io/common/components/appbar.dart';
import 'package:survey_io/pages/tabs/navigation_bottom_bar.dart';
import 'package:survey_io/common/constants/widgets/red_shape_card.dart';
import 'package:survey_io/datasources/login/auth_save_local_datasource.dart';

import 'package:survey_io/datasources/survey_design/repository/localRepositoryAge.dart';
import 'package:survey_io/datasources/survey_design/repository/localRepositoryChildren.dart';
import 'package:survey_io/datasources/survey_design/repository/localRepositoryGender.dart';
import 'package:survey_io/datasources/survey_design/repository/localRepositoryIncome.dart';
import 'package:survey_io/datasources/survey_design/repository/localRepositoryMarital.dart';
import 'package:survey_io/datasources/survey_design/repository/localRepositoryOccupation.dart';
import 'package:survey_io/datasources/survey_design/repository/localRepositoryOutcome.dart';
import 'package:survey_io/datasources/survey_design/repository/localRepositoryQuestion.dart';
import 'package:survey_io/datasources/survey_design/repository/localRepositoryRegion.dart';
import 'package:survey_io/datasources/survey_design/repository/localRepositoryReligion.dart';
import 'package:survey_io/datasources/survey_design/repository/localRepositoryReportTime.dart';
import 'package:survey_io/datasources/survey_design/repository/localRepositoryRespondent.dart';
import 'package:survey_io/datasources/survey_design/repository/localRepositoryScreener.dart';

class SurveyDesignListPage extends StatefulWidget {
  const SurveyDesignListPage({super.key});

  @override
  State<SurveyDesignListPage> createState() => _SurveyDesignListPageState();
}

class _SurveyDesignListPageState extends State<SurveyDesignListPage> {
  int selectedIndex = 1;
  bool isLogged = false;
  bool isGuest = false;

  final respondentLocalRepository = LocalRepositoryRespondent();
  final questionLocalRepository = LocalRepositoryQuestion();
  final reportTimeLocalRepository = LocalRepositoryReportTime();
  final screenerLocalRepository = LocalRepositoryScreener();

  final demographyAgeLocalRepository = LocalRepositoryDemographyAge();
  final demographyChildrenLocalRepository = LocalRepositoryDemographyChildren();
  final demographyGenderLocalRepository = LocalRepositoryDemographyGender();
  final demographyIncomeLocalRepository = LocalRepositoryDemographyIncome();
  final demographyMaritalLocalRepository = LocalRepositoryDemographyMarital();
  final demographyOccupationLocalRepository =
      LocalRepositoryDemographyOccupation();
  final demographyOutcomeLocalRepository = LocalRepositoryDemographyOutcome();
  final demographyRegionLocalRepository = LocalRepositoryDemographyRegion();
  final demographyReligionLocalRepository = LocalRepositoryDemographyReligion();

  final surveyDesignPriceRepository = LocalRepositorySurveyDesignPrice();

  @override
  void initState() {
    super.initState();
    checkToken();
    deleteAllOptiondValue();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    checkToken();
  }

  void loadDataSource() {
    context
        .read<SurveyDesignListBloc>()
        .add(const SurveyDesignListEvent.getSurveyDesignList());
  }

  void checkToken() async {
    final token = await AuthLocalDatasource().getToken();
    final guestToken = await AuthLocalGuestDatasource().getToken();

    if (token.isEmpty) {
      if (guestToken.isNotEmpty) {
        setState(() {
          isGuest = true;
          isLogged = false;
        });
        loadDataSource();
      }
    } else {
      setState(() {
        isGuest = false;
        isLogged = true;
      });
      loadDataSource();
    }
  }

  // DELETE ALL OPTION
  Future<void> deleteAllOptiondValue() async {
    await respondentLocalRepository.deleteOption();
    await questionLocalRepository.deleteOption();
    await reportTimeLocalRepository.deleteOption();
    await screenerLocalRepository.deleteOption();

    await demographyAgeLocalRepository.deleteOption();
    await demographyChildrenLocalRepository.deleteOption();
    await demographyGenderLocalRepository.deleteOption();
    await demographyIncomeLocalRepository.deleteOption();
    await demographyMaritalLocalRepository.deleteOption();
    await demographyOccupationLocalRepository.deleteOption();
    await demographyOutcomeLocalRepository.deleteOption();
    await demographyRegionLocalRepository.deleteOption();
    await demographyReligionLocalRepository.deleteOption();

    await surveyDesignPriceRepository.deleteOption();
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
        isGuest
            ? FloatingProfileCard(
                userFrontName: 'User',
                iconImage: Image.asset(
                  IconName.point,
                  width: 35,
                  height: 35,
                ),
                label: 'Jumlah Survei',
                labelValue: '0',
                onPressed: () {},
              )
            : const ProfileSectionSurveyDesign(),
      ]),
      bottomNavigationBar: BottomMenu(
        selectedIndex: selectedIndex,
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // floatingActionButton: const NavigationFloatingIcon(
      //   isActive: true,
      // ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Row(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 6,
            child: Container(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.25,
                  bottom: MediaQuery.of(context).size.height * 0.043),
              alignment: Alignment.bottomCenter,
              child: FloatingActionButton(
                heroTag: 'survey_design_list_tag',
                elevation: 0,
                backgroundColor: Colors.white,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SurveyDesignListPage()));
                },
                tooltip: 'Buat Survei',
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(16), // Adjust the radius as needed
                ),
                child: Image.asset(
                  IconName.rewardFocused,
                  width: 45,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * 0.11, right: 25),
              alignment: Alignment.bottomRight,
              child: BlocBuilder<ProfileBloc, ProfileState>(
                builder: (context, state) {
                  return state.maybeWhen(
                    orElse: () {
                      return isGuest
                          ? Container()
                          : FloatingActionButton(
                              heroTag: 'survey_design_create_tag',
                              shape: const CircleBorder(),
                              onPressed: () {},
                              backgroundColor: AppColors.primary,
                              tooltip: 'Create New Survey Design',
                              // mini: true,
                              child: const Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 40,
                              ),
                            );
                    },
                    loaded: (data) {
                      return FloatingActionButton(
                        heroTag: 'survey_design_create_tag',
                        shape: const CircleBorder(),
                        onPressed: () {
                          // ignore: unnecessary_null_comparison
                          if (data.userProfile.ktp == null &&
                              data.userProfile.npwp == null) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const EditProfileComplete()));
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SurveyDesign(
                                          designAction: 'Create',
                                        )));
                          }
                        },
                        backgroundColor: AppColors.primary,
                        tooltip: 'Create New Survey Design',
                        // mini: true,
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 40,
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
