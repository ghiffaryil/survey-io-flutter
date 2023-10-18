import 'package:flutter/material.dart';
import 'package:survey_io/common/components/appbar_plain.dart';
import 'package:survey_io/common/components/divider.dart';
import 'package:survey_io/common/components/text_button.dart';
import 'package:survey_io/common/constants/colors.dart';
import 'package:survey_io/common/constants/images.dart';
import 'package:survey_io/common/constants/padding.dart';
import 'package:survey_io/pages/home/presentation/home.dart';
import 'package:survey_io/pages/reedem/presentation/reedem.dart';

import '../../../common/constants/icons.dart';
import '../../../common/constants/styles.dart';

class ReedemGiftCardSuccess extends StatefulWidget {
  const ReedemGiftCardSuccess({super.key});

  @override
  State<ReedemGiftCardSuccess> createState() => _ReedemGiftCardSuccessState();
}

class _ReedemGiftCardSuccessState extends State<ReedemGiftCardSuccess> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => const HomePage()));
            },
            icon: const Icon(
              Icons.close,
              size: 35,
              color: AppColors.white,
            )),
        elevation: 0.0,
      ),
      body: Container(
        color: AppColors.primary,
        padding: CustomPadding.p3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomDividers.largeDivider(),
            Image.asset(
              IconName.iconReedemGiftCardSuccess,
              width: MediaQuery.of(context).size.width * 0.7,
            ),
            CustomDividers.verySmallDivider(),
            Text(
              '100 koin telah berhasil ditambahkan ke Celengan!',
              textAlign: TextAlign.center,
              style: TextStyles.extraLarge(color: AppColors.white),
            ),
            CustomDividers.largeDivider(),
            TextButtonFilled.custom(
              backgroundColor: AppColors.white,
              textColor: AppColors.primary,
              text: 'Tukar Dengan Hadiah',
              onPressed: () {},
            ),
            TextButtonOutlined.custom(
              text: 'Nanti Saja',
              backgroundColor: Colors.transparent,
              borderColor: AppColors.white,
              textColor: AppColors.white,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
