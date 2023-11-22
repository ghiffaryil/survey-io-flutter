import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:survey_io/bloc/profile/get_profile/profile_bloc.dart';
import 'package:survey_io/common/constants/icons.dart';
import 'package:survey_io/common/constants/widgets/profile_card.dart';
import 'package:survey_io/pages/reedem/reedem.dart';

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
            return FloatingProfileCard(
              userFrontName: '-',
              iconImage: Image.asset(
                IconName.totalSurvey,
                width: 40,
                height: 40,
              ),
              label: 'Celengan Saya',
              labelValue: '-',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ReedemPage(),
                  ),
                );
              },
            );
          },
          error: (error) {
            return FloatingProfileCard(
              userFrontName: '-',
              iconImage: Image.asset(
                IconName.point,
                width: 40,
                height: 40,
              ),
              label: 'Celengan Saya',
              labelValue: '-',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ReedemPage(),
                  ),
                );
              },
            );
          },
          loaded: (data) {
            // Format the point value with a thousands separator
            String formattedPoint =
                NumberFormat('###,###.###', 'id_ID').format(data.point);

            return FloatingProfileCard(
              userFrontName: data.user.name.split(' ')[0],
              iconImage: Image.asset(
                IconName.point,
                width: 40,
                height: 40,
              ),
              label: 'Celengan Saya',
              labelValue: formattedPoint,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ReedemPage()));
              },
            );
          },
        );
      },
    );
  }
}
