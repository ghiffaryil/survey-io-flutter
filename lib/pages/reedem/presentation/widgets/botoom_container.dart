import 'package:flutter/material.dart';
import 'package:survey_io/common/constants/padding.dart';
import 'package:survey_io/pages/reedem/presentation/reedem_failed.dart';
import 'package:survey_io/pages/reedem/presentation/reedem_success.dart';

import '../../../../common/components/divider.dart';
import '../../../../common/components/text_button.dart';
import '../../../../common/constants/colors.dart';
import '../../../../common/constants/icons.dart';
import '../../../../common/constants/indicator.dart';
import '../../../../common/constants/styles.dart';

class BottomContainer extends StatelessWidget {
  final int productId;
  final int amount;
  final int koin;
  final String productName;

  const BottomContainer(
      {super.key,
      required this.productId,
      required this.amount,
      required this.koin,
      required this.productName});

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      isScrollControlled: true,
      builder: (BuildContext bc) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.45,
          padding: CustomPadding.pdefault,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              color: Colors.white),
          child: Column(
            children: <Widget>[
              const IndicatorModal(),
              CustomDividers.regularDivider(),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Konfirmasi",
                  style: TextStyles.h2(color: AppColors.secondary),
                ),
              ),
              CustomDividers.verySmallDivider(),
              Text(
                'Kamu yakin ingin menukarkan $koin koin ke $productName $amount?',
                textAlign: TextAlign.left,
                style: const TextStyle(
                  color: AppColors.secondary,
                  fontSize: 18,
                ),
              ),
              CustomDividers.mediumDivider(),
              CustomDividers.verySmallDivider(),
              TextButtonFilled.primary(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ReedemSuccess(
                                productId: productId,
                                productName: productName,
                                amount: amount,
                                koin: koin,
                              )));
                },
                text: 'Ya, Tukarkan',
              ),
              CustomDividers.verySmallDivider(),
              TextButtonOutlined.secondary(
                  text: 'Tidak, Batalkan',
                  onPressed: () {
                    // Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ReedemFailed(
                                productName: productName,
                                productId: productId,
                                amount: amount,
                                koin: koin)));
                  })
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    koin == '' ? amount ~/ 1000 : koin;

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
        padding:
            const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 15),
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
                onPressed: () {
                  _showBottomSheet(context);
                },
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
