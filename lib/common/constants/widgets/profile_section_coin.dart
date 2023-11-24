import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:survey_io/bloc/profile/get_profile/profile_bloc.dart';
import 'package:survey_io/common/constants/icons.dart';
import 'package:survey_io/common/constants/widgets/profile_card.dart';
import 'package:survey_io/pages/reedem/reedem.dart';

class ProfileSectionCoin extends StatefulWidget {
  const ProfileSectionCoin({super.key});

  @override
  State<ProfileSectionCoin> createState() =>
      _ProfileSectionCoinState();
}

class _ProfileSectionCoinState
    extends State<ProfileSectionCoin> {
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
