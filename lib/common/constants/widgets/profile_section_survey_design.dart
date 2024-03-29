import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:survey_io/bloc/profile/get_profile/profile_bloc.dart';
import 'package:survey_io/bloc/survey_design/survey_design_list/survey_design_list_bloc.dart';
import 'package:survey_io/common/components/shimmer_card.dart';
import 'package:survey_io/common/constants/icons.dart';
import 'package:survey_io/common/constants/widgets/profile_card.dart';

class ProfileSectionSurveyDesign extends StatefulWidget {
  const ProfileSectionSurveyDesign({super.key});

  @override
  State<ProfileSectionSurveyDesign> createState() =>
      _ProfileSectionSurveyDesignState();
}

class _ProfileSectionSurveyDesignState
    extends State<ProfileSectionSurveyDesign> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return state.maybeWhen(
          orElse: () {
            return Container();
          },
          loaded: (data) {
            return BlocBuilder<SurveyDesignListBloc, SurveyDesignListState>(
              builder: (context, state) {
                return state.maybeWhen(orElse: () {
                  return Container();
                }, loading: () {
                  return const ShimmerProfileFloat();
                }, 
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
                    onPressed: () {},
                  );
                });
              },
            );
          },
        );
      },
    );
  }
}
