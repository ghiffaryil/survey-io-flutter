// ignore_for_file: non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:survey_io/common/constants/styles.dart';
import 'package:survey_io/common/constants/colors.dart';
import 'package:survey_io/common/components/divider.dart';
import 'package:survey_io/common/components/label.dart';
import 'package:survey_io/pages/reward/models/product_prepaid_model.dart';
import 'package:survey_io/pages/reward/presentation/widgets/user_information_card.dart';
import '../../../common/components/appbar_plain.dart';
import '../../../common/constants/padding.dart';
import '../data/list_product_prepaid.dart';
import 'widgets/item_card.dart';

class RewardPage extends StatefulWidget {
  const RewardPage({super.key});

  @override
  State<RewardPage> createState() => _RewardPageState();
}

class _RewardPageState extends State<RewardPage> {
  List<ProductPrepaidCategory> listProductPrepaidCategory =
      ListProductPrepaid.getProductPrepaid();

  @override
  Widget build(BuildContext context) {
    // Create a map to hold grouped products by category_name
    Map<String, List<Product>> groupedProducts = {};

    // Iterate through the products and group them by category_name
    for (final merchant in listProductPrepaidCategory) {
      final category = merchant.category_name;
      if (!groupedProducts.containsKey(category)) {
        groupedProducts[category] = [];
      }
      groupedProducts[category]?.addAll(merchant.listProducts);
    }

    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: PlainAppBar(
        leadingIcon: Icons.arrow_back_ios,
        textColor: AppColors.secondary,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      body: Column(
        children: [
          Container(
            color: AppColors.white,
            child: Padding(
              padding: CustomPadding.px3,
              child: LabelInput(
                labelText: 'Hadiah',
                labelStyle: TextStyles.h2(color: AppColors.secondary),
              ),
            ),
          ),
          const UserInformation(),
          Expanded(
            child: Padding(
              padding: CustomPadding.p1,
              child: ListView.separated(
                itemCount: groupedProducts.length,
                separatorBuilder: (context, index) =>
                    const Divider(), // Add a divider between groups
                itemBuilder: (context, index) {
                  final categoryNames = groupedProducts.keys.toList();
                  final categoryName = categoryNames[index];
                  final products = groupedProducts[categoryName]!;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        width: double.infinity,
                        padding: CustomPadding.p2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              categoryName,
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
                      // List of rewards for this category
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: products.length,
                        itemBuilder: (context, indexProduct) {
                          final product = products[indexProduct];
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              ProductItemWidget(productData: product),
                              CustomDividers.verySmallDivider(),
                            ],
                          );
                        },
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
