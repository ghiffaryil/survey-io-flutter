import 'package:flutter/material.dart';

import '../../../../common/components/divider.dart';
import '../../../../common/components/text_button.dart';
import '../../../../common/constants/colors.dart';
import '../../../../common/constants/icons.dart';
import '../../../../common/constants/styles.dart';

class BottomContainer extends StatelessWidget {
  final int productId;
  final int amount;
  final int koin;

  BottomContainer({
    required this.productId,
    required this.amount,
    required this.koin,
  });

  @override
  Widget build(BuildContext context) {
    koin == '' ? (amount / 1000).toInt() : koin;

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 5.0,
            spreadRadius: 2.0,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Container(
        padding: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 30),
        width: double.infinity,
        child: Row(
          children: [
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Koin Dibutuhkan',
                      style: TextStyles.regular(),
                    ),
                    CustomDividers.verySmallDivider(),
                    Row(
                      children: [
                        Image.asset(
                          IconName.point,
                          width: 25,
                          height: 25,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          koin.toString(),
                          style: TextStyles.h3(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: TextButtonFilled.primary(
                text: 'Reedem',
                fontSize: 20,
                onPressed: () {},
                minWidth: 20,
                height: 60,
              ),
            )
          ],
        ),
      ),
    );
  }
}
