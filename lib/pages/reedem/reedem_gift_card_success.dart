import 'package:flutter/material.dart';
import 'package:survey_io/common/components/divider.dart';
import 'package:survey_io/common/components/text_button.dart';
import 'package:survey_io/common/constants/colors.dart';
import 'package:survey_io/common/constants/padding.dart';
import 'package:survey_io/pages/home/home.dart';

import '../../../common/constants/imageSize.dart';
import '../../../common/constants/images.dart';
import '../../../common/constants/styles.dart';
import 'reedem.dart';

class ReedemGiftCardSuccess extends StatefulWidget {
  final int point;

  const ReedemGiftCardSuccess({super.key, required this.point});

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
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const HomePage()));
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
              Images.reedemGiftCardSuccess,
              width: AppWidth.imageSize(context, AppWidth.large),
            ),
            CustomDividers.verySmallDivider(),
            Text(
              '${widget.point} koin telah berhasil ditambahkan ke Celengan!',
              textAlign: TextAlign.center,
              style: TextStyles.extraLarge(color: AppColors.white),
            ),
            CustomDividers.largeDivider(),
            TextButtonFilled.custom(
              backgroundColor: AppColors.white,
              textColor: AppColors.primary,
              text: 'Tukar Dengan Hadiah',
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ReedemPage(),
                    ));
              },
            ),
            TextButtonOutlined.custom(
              text: 'Nanti Saja',
              backgroundColor: Colors.transparent,
              borderColor: AppColors.white,
              textColor: AppColors.white,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomePage(),
                    ));
              },
            ),
          ],
        ),
      ),
    );
  }
}
