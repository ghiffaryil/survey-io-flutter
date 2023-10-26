import 'package:flutter/material.dart';
import 'package:survey_io/common/components/appbar_plain.dart';
import 'package:survey_io/common/components/divider.dart';
import 'package:survey_io/common/components/elevated_button.dart';
import 'package:survey_io/common/components/label.dart';
import 'package:survey_io/common/constants/colors.dart';
import 'package:survey_io/common/constants/padding.dart';

import '../../../common/constants/images.dart';
import '../../../common/constants/styles.dart';

class ReedemFailed extends StatefulWidget {
  final String productName;
  final int productId;
  final int amount;
  final int koin;

  const ReedemFailed(
      {Key? key,
      required this.productName,
      required this.productId,
      required this.amount,
      required this.koin})
      : super(key: key);

  @override
  State<ReedemFailed> createState() => _ReedemFailedState();
}

class _ReedemFailedState extends State<ReedemFailed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PlainAppBar(
        onPressed: () {
          Navigator.pop(context);
        },
        leadingIcon: Icons.close,
        iconColor: AppColors.black,
      ),
      body: Container(
        padding: CustomPadding.pdefault,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Center(
              child: LabelInput(
                labelAlignment: Alignment.center,
                labelText: 'Reedem Gagal!',
                labelStyle: TextStyles.h2(color: AppColors.secondary),
              ),
            ),
            CustomDividers.verySmallDivider(),
            Image.asset(
              Images.reedemFailed,
              width: MediaQuery.of(context).size.width * 0.7,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Mohon maaf, telah terjadi kesalahan dalam sistem. Tekan "Coba Lagi" untuk melakukan redeem ulang.',
                textAlign: TextAlign.center,
                style: TextStyles.extraLarge(
                  color: AppColors.light,
                ),
              ),
            ),
            CustomDividers.extraLargeDivider(),
            ButtonFilled.primary(
                text: 'Coba Lagi',
                onPressed: () {
                  Navigator.pop(context);
                })
          ],
        ),
      ),
    );
  }
}
