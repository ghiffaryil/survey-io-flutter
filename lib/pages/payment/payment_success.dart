import 'package:flutter/material.dart';
import 'package:survey_io/common/components/appbar_plain.dart';
import 'package:survey_io/common/components/divider.dart';
import 'package:survey_io/common/components/elevated_button.dart';
import 'package:survey_io/common/components/label.dart';
import 'package:survey_io/common/constants/colors.dart';
import 'package:survey_io/common/constants/imageSize.dart';
import 'package:survey_io/common/constants/padding.dart';
import 'package:survey_io/pages/survey_design/survey_design_list.dart';

import '../../../common/constants/images.dart';
import '../../../common/constants/styles.dart';

class PaymentSuccessPage extends StatefulWidget {
  const PaymentSuccessPage({super.key});

  @override
  State<PaymentSuccessPage> createState() => _PaymentSuccessPageState();
}

class _PaymentSuccessPageState extends State<PaymentSuccessPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PlainAppBar(
        onPressed: () {
          Navigator.pop(context);
        },
        leadingIcon: Icons.close,
        iconColor: AppColors.secondary,
      ),
      body: Container(
        padding: CustomPadding.pdefault,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const LabelHeading(
              labelAlignment: Alignment.center,
              labelText: 'Pembayaran Berhasil',
              labelColor: AppColors.secondary,
            ),
            CustomDividers.smallDivider(),
            Image.asset(
              Images.paymentSuccess,
              width: AppWidth.imageSize(
                context,
                AppWidth.extraLarge,
              ),
            ),
            Container(
              padding: CustomPadding.p2,
              child: Text(
                'Terima kasih, pembayaran kamu sudah masuk. Silahkan lanjut membuat pertanyaan untuk survei kamu.',
                textAlign: TextAlign.center,
                style: TextStyles.large(),
              ),
            ),
            CustomDividers.verySmallDivider(),
            Container(
              padding: CustomPadding.px2,
              child: ButtonFilled.primary(
                  text: 'Buat Pertanyaan Survei',
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SurveyDesignListPage()));
                  }),
            ),
            CustomDividers.mediumDivider(),
          ],
        ),
      ),
    );
  }
}
