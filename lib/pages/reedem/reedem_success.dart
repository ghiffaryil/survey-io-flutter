import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:survey_io/common/components/appbar_plain.dart';
import 'package:survey_io/common/components/divider.dart';
import 'package:survey_io/common/components/elevated_button.dart';
import 'package:survey_io/common/components/label.dart';
import 'package:survey_io/common/constants/colors.dart';
import 'package:survey_io/common/constants/padding.dart';
import 'package:survey_io/pages/reedem/reedem.dart';
import 'package:survey_io/pages/survey_design/survey_design_list.dart';

import '../../../common/constants/images.dart';
import '../../../common/constants/styles.dart';

class ReedemSuccess extends StatefulWidget {
  final String productName;
  final int productId;
  final int amount;
  final int koin;

  const ReedemSuccess(
      {Key? key,
      required this.productName,
      required this.productId,
      required this.amount,
      required this.koin})
      : super(key: key);

  @override
  State<ReedemSuccess> createState() => _ReedemSuccessState();
}

class _ReedemSuccessState extends State<ReedemSuccess> {
  @override
  Widget build(BuildContext context) {
    String formattedAmount =
        NumberFormat('###,###.###', 'id_ID').format(widget.amount);
    String formattedKoin =
        NumberFormat('###,###.###', 'id_ID').format(widget.koin);

    return Scaffold(
      appBar: PlainAppBar(
        onPressed: () {
          // Navigator.pop(context);
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return const ReedemPage();
          }));
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
                labelText: 'Reedem Sukses!',
                labelStyle: TextStyles.h2(color: AppColors.secondary),
              ),
            ),
            CustomDividers.verySmallDivider(),
            Image.asset(
              Images.reedemSuccess,
              width: MediaQuery.of(context).size.width * 0.7,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Kamu berhasil menukarkan $formattedKoin koin ke ${widget.productName} Rp $formattedAmount',
                textAlign: TextAlign.center,
                style: TextStyles.extraLarge(
                  color: AppColors.light,
                ),
              ),
            ),
            CustomDividers.mediumDivider(),
            ButtonFilled.primary(
                text: 'Ok',
                onPressed: () {
                  // Navigator.pop(context);
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) {
                    return const SurveyDesignList();
                  }));
                })
          ],
        ),
      ),
    );
  }
}
