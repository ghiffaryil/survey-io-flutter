import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:survey_io/bloc/reedem/topup_prepaid/topup_prepaid_bloc.dart';
import 'package:survey_io/common/constants/padding.dart';
import 'package:survey_io/pages/reedem/reedem_failed.dart';
import 'package:survey_io/pages/reedem/reedem_success.dart';

import '../../../../common/components/divider.dart';
import '../../../../common/components/text_button.dart';
import '../../../../common/constants/colors.dart';
import '../../../../common/constants/icons.dart';
import '../../../../common/constants/widgets/indicator.dart';
import '../../../../common/constants/styles.dart';

class BottomContainer extends StatelessWidget {
  final int productId;
  final String productCode;
  final int amount;
  final int koin;
  final String productName;
  final String phoneNumber;

  const BottomContainer({
    super.key,
    required this.productId,
    required this.productCode,
    required this.amount,
    required this.koin,
    required this.productName,
    required this.phoneNumber,
  });

  bool _validateForm() {
    if (phoneNumber.isEmpty) {
      Fluttertoast.showToast(
        msg: 'Please enter your phone number',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: AppColors.secondary.withOpacity(0.7),
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return false;
    }
    return true;
  }

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
        String formattedKoin =
            NumberFormat('###,###.###', 'id_ID').format(koin);
        String formattedAmount =
            NumberFormat('###,###.###', 'id_ID').format(amount);
        return BlocListener<TopupPrepaidBloc, TopupPrepaidState>(
          listener: (context, state) {
            state.maybeWhen(
                orElse: () {},
                loaded: (data) {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) {
                    return ReedemSuccess(
                        productName: productName,
                        productId: productId,
                        amount: amount,
                        koin: koin);
                  }));
                },
                error: (message) {
                  // Jika gagal reedem / koin tidak mencukupi
                  Fluttertoast.showToast(
                      msg: message,
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: AppColors.secondary.withOpacity(0.8),
                      textColor: Colors.white,
                      fontSize: 16.0);
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) {
                    return ReedemFailed(
                        productName: productName,
                        productId: productId,
                        amount: amount,
                        koin: koin);
                  }));
                });
          },
          child: Container(
            height: MediaQuery.of(context).size.height * 0.42,
            padding: CustomPadding.pdefault,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                color: Colors.white),
            child: Column(
              children: <Widget>[
                const IndicatorModal(),
                CustomDividers.smallDivider(),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Konfirmasi",
                    style: TextStyles.h2(color: AppColors.secondary),
                  ),
                ),
                CustomDividers.verySmallDivider(),
                Text(
                  'Kamu yakin ingin menukarkan $formattedKoin koin ke $productName $formattedAmount?',
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    color: AppColors.secondary,
                    fontSize: 18,
                  ),
                ),
                CustomDividers.regularDivider(),
                BlocBuilder<TopupPrepaidBloc, TopupPrepaidState>(
                  builder: (context, state) {
                    return state.maybeWhen(orElse: () {
                      return TextButtonFilled.primary(
                        onPressed: () {
                          context.read<TopupPrepaidBloc>().add(
                              TopupPrepaidEvent.setTopUpPrepaid(productCode));
                        },
                        text: 'Ya, Tukarkan',
                      );
                    }, loading: () {
                      return const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primary,
                          ),
                        ),
                      );
                    });
                  },
                ),
                CustomDividers.verySmallDivider(),
                TextButtonOutlined.secondary(
                    text: 'Tidak, Batalkan',
                    onPressed: () {
                      Navigator.pop(context);
                    })
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    String formattedKoin = NumberFormat('###,###.###', 'id_ID').format(koin);

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
                          formattedKoin,
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
                  if (_validateForm()) {
                    _showBottomSheet(context);
                  }
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
