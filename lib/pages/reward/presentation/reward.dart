// ignore_for_file: non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:survey_io/common/constants/styles.dart';
import 'package:survey_io/common/constants/colors.dart';
import 'package:survey_io/common/components/divider.dart';
import 'package:survey_io/common/components/label.dart';
import '../../../common/components/appbar_plain.dart';
import '../../../common/constants/icons.dart';
import '../../../common/constants/padding.dart';
import '../data/product_prepaid.dart';
import 'widgets/product_reward.dart';

class RewardPage extends StatefulWidget {
  const RewardPage({super.key});

  @override
  State<RewardPage> createState() => _RewardPageState();
}

class _RewardPageState extends State<RewardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: PlainAppBar(
        leadingIcon: Icons.arrow_back_ios,
        textColor: AppColors.secondary,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 3,
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Padding(
                    padding: CustomPadding.px2,
                    child: LabelInput(
                      labelText: 'Hadiah',
                      labelStyle: TextStyles.h2(color: AppColors.secondary),
                    ),
                  ),
                  CustomDividers.smallDivider(),
                  userInformation(),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              padding: CustomPadding.p2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Dompet Digital',
                    style: TextStyles.large(
                      color: AppColors.secondary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Lihat Semua',
                    style: TextStyles.large(
                      color: AppColors.info,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.5,
              color: AppColors.white,
              padding: CustomPadding.pdefault,
              child: ListView.builder(
                itemCount: listMerchant.length,
                itemBuilder: (context, merchantIndex) {
                  final merchant = listMerchant[merchantIndex];
                  final merchantData = merchant['data'];
                  return merchantData[0]["category_name"] == "E-Wallet"
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // List of rewards for this merchant
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: merchantData.length,
                              itemBuilder: (context, productIndex) {
                                final product = merchantData[productIndex];
                                final products = product['products'];
                                return Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    ProductItemWidget(productData: products[0]),
                                    CustomDividers.verySmallDivider(),
                                  ],
                                );
                              },
                            ),
                          ],
                        )
                      : Container();
                },
              ),
            ),
            Container(
              width: double.infinity,
              padding: CustomPadding.p2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Prabayar',
                    style: TextStyles.large(
                      color: AppColors.secondary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Lihat Semua',
                    style: TextStyles.large(
                      color: AppColors.info,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.5,
              color: AppColors.white,
              padding: CustomPadding.pdefault,
              child: ListView.builder(
                itemCount: listMerchant.length,
                itemBuilder: (context, merchantIndex) {
                  final merchant = listMerchant[merchantIndex];
                  final merchantData = merchant['data'];
                  return merchantData[0]["category_name"] == "E-Wallet"
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // List of rewards for this merchant
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: merchantData.length,
                              itemBuilder: (context, productIndex) {
                                final product = merchantData[productIndex];
                                final products = product['products'];
                                return Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    ProductItemWidget(productData: products[0]),
                                    CustomDividers.verySmallDivider(),
                                  ],
                                );
                              },
                            ),
                          ],
                        )
                      : Container();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget userInformation() {
    return Container(
      padding: CustomPadding.pdefault,
      decoration: const BoxDecoration(
        color: AppColors.white,
      ),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.09,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: AppColors.primary.withOpacity(0.1),
          borderRadius: const BorderRadius.all(Radius.circular(50)),
        ),
        child: Row(
          children: [
            Image.asset(
              IconName.point,
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
                    'Celengan Saya',
                    style: TextStyles.extraLarge(
                        color: AppColors.secondary,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '1.000.000',
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
                          'Riwayat',
                          style: TextStyles.h5(color: Colors.white),
                        ),
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
