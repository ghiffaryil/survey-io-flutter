import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:survey_io/pages/reedem/reedem_history.dart';

import '../../../../common/constants/colors.dart';
import '../../../../common/constants/icons.dart';
import '../../../../common/constants/padding.dart';
import '../../../../common/constants/styles.dart';
import '../../../bloc/profile/get_profile/profile_bloc.dart';

class UserInformation extends StatelessWidget {
  const UserInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: CustomPadding.pdefault,
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border(
          bottom: BorderSide(
            color: AppColors.light.withOpacity(0.5), // Specify the border color
            width: 2.0, // Specify the border width
          ),
        ),
      ),
      child: Container(
        margin: const EdgeInsets.only(top: 20),
        height: MediaQuery.of(context).size.height * 0.1,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: AppColors.primary.withOpacity(0.1),
          borderRadius: const BorderRadius.all(Radius.circular(50)),
        ),
        child: Row(
          children: [
            Image.asset(
              IconName.point,
              width: 45,
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              flex: 6,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Celengan Saya',
                    style: TextStyles.extraLarge(
                        color: AppColors.secondary,
                        fontWeight: FontWeight.bold),
                  ),
                  BlocBuilder<ProfileBloc, ProfileState>(
                    builder: (context, state) {
                      return state.maybeWhen(
                        orElse: () {
                          return Container();
                        },
                        loading: () {
                          return const Text('-');
                        },
                        error: (message) {
                          return const Text('Can\'t Loaded Data');
                        },
                        loaded: (data) {
                          // Format the point value with a thousands separator
                          String formattedPoint =
                              NumberFormat('###,###.###', 'id_ID')
                                  .format(data.point);

                          return Text(
                            formattedPoint,
                            style:
                                TextStyles.regular(color: AppColors.secondary),
                          );
                        },
                      );
                    },
                  )
                ],
              ),
            ),
            Expanded(
                flex: 4,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ReedemHistoryPage()));
                    },
                    child: Container(
                      height: 40,
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                      ),
                      child: Center(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'Riwayat',
                            style: TextStyles.h5(color: Colors.white),
                          ),
                        ],
                      )),
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
