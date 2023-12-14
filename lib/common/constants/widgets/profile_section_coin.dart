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
  State<ProfileSectionCoin> createState() => _ProfileSectionCoinState();
}

class _ProfileSectionCoinState extends State<ProfileSectionCoin> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return state.maybeWhen(
          orElse: () {
            return FloatingProfileCard(
              userFrontName: 'User',
              iconImage: Image.asset(
                IconName.point,
                width: 35,
                height: 35,
              ),
              label: 'Celengan Saya',
              labelValue: '0',
              onPressed: () {},
            );
          },
          error: (error) {
            return FloatingProfileCard(
              userFrontName: 'User',
              iconImage: Image.asset(
                IconName.point,
                width: 35,
                height: 35,
              ),
              label: 'Celengan Saya',
              labelValue: '0',
              onPressed: () {},
            );
          },
          loaded: (data) {
            String formattedPoint =
                NumberFormat('###,###.###', 'id_ID').format(data.point);
            return FloatingProfileCard(
              userFrontName: data.user.name.split(' ')[0],
              iconImage: Image.asset(
                IconName.point,
                width: 35,
                height: 35,
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
