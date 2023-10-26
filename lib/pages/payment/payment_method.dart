import 'package:flutter/material.dart';
import 'package:survey_io/common/components/appbar_plain.dart';
import 'package:survey_io/common/components/divider.dart';
import 'package:survey_io/common/components/label.dart';
import 'package:survey_io/common/constants/colors.dart';
import 'package:survey_io/common/constants/imageSize.dart';
import 'package:survey_io/common/constants/padding.dart';
import 'package:survey_io/datasources/payment/list_payment_merchant.dart';
import 'package:survey_io/models/payment/payment_merchant_model.dart';
import 'package:survey_io/pages/payment/payment_success.dart';

import '../../../common/constants/styles.dart';

class PaymentMethodPage extends StatefulWidget {
  const PaymentMethodPage({super.key});

  @override
  State<PaymentMethodPage> createState() => _PaymentMethodPageState();
}

class _PaymentMethodPageState extends State<PaymentMethodPage> {
  List<PaymentMerchantModel> listPaymentMerchant =
      ListPaymentMerchant.getPaymentMerchantList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PlainAppBar(
        onPressed: () {
          Navigator.of(context).pop();
        },
        leadingIcon: Icons.close,
        iconColor: AppColors.secondary,
      ),
      body: Column(
        children: [
          Container(
            padding: CustomPadding.p2,
            child: const LabelHeading(
              labelText: 'Metode Pembayaran',
              labelColor: AppColors.secondary,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: listPaymentMerchant.length,
                itemBuilder: ((context, index) {
                  var merchant = listPaymentMerchant[index];

                  Widget? titleSection;
                  if (index == 0 ||
                      merchant.merchantType !=
                          listPaymentMerchant[index - 1].merchantType) {
                    // Conditionally render the title section for the first row or when merchantType is different from the previous row.
                    titleSection = Container(
                      padding: CustomPadding.p2,
                      width: double.infinity,
                      color: const Color.fromRGBO(248, 251, 255, 1),
                      child: Text(
                        merchant.merchantType == "bank"
                            ? 'Transfer Virtual Account'
                            : 'Dompet Digital',
                        style: TextStyles.h4(),
                      ),
                    );
                  }

                  return Column(
                    children: [
                      if (titleSection != null) titleSection,
                      GestureDetector(
                        onTap: () {
                          // print('merchant selected => ${merchant.id}');
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const PaymentSuccessPage()));
                        },
                        child: ListTile(
                          leading: Container(
                            margin: merchant.merchantType == "ewallet"
                                ? const EdgeInsets.only(left: 10)
                                : const EdgeInsets.only(left: 0),
                            child: Image.asset(
                              merchant.merchantLogo,
                              width: merchant.merchantType == "bank"
                                  ? AppWidth.imageSize(
                                      context, AppWidth.verySmall)
                                  : 25,
                            ),
                          ),
                          title: Text(merchant.merchantName),
                          trailing: IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.arrow_forward_ios_sharp)),
                        ),
                      ),
                    ],
                  );
                }),
                separatorBuilder: ((context, index) {
                  return const Divider();
                }),
              ),
            ),
          ),
          CustomDividers.verySmallDivider(),
        ],
      ),
    );
  }
}
