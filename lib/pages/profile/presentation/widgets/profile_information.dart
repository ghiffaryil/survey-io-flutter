import 'package:flutter/material.dart';

import '../../../../common/constants/colors.dart';
import '../../../../common/constants/icons.dart';
import '../../../../common/constants/styles.dart';

class UserInformation extends StatefulWidget {
  const UserInformation({super.key});

  @override
  State<UserInformation> createState() => _UserInformationState();
}

class _UserInformationState extends State<UserInformation> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 25, right: 25, top: 5, bottom: 20),
      width: double.infinity,
      decoration: const BoxDecoration(
        color: AppColors.primary,
      ),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.09,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(50)),
        ),
        child: Row(
          children: [
            Image.asset(
              IconName.account,
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
                    'Fahmi Fauzi',
                    style: TextStyles.extraLarge(
                        color: AppColors.secondary,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '0812321312312',
                    style: TextStyles.regular(color: AppColors.secondary),
                  )
                ],
              ),
            ),
            Expanded(
                flex: 4,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5),
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
                          'Verified',
                          style: TextStyles.h5(color: Colors.white),
                        ),
                        Image.asset(IconName.iconCheck)
                      ],
                    )),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
