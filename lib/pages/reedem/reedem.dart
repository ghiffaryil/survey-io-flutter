// ignore_for_file: non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:survey_io/common/constants/styles.dart';
import 'package:survey_io/common/constants/colors.dart';
import 'package:survey_io/common/components/divider.dart';
import 'package:survey_io/common/components/label.dart';
import 'package:survey_io/models/reedem/product_prepaid_model.dart';
import 'package:survey_io/pages/reedem/widgets/user_information_card.dart';
import '../../../common/components/appbar_plain.dart';
import '../../../common/constants/padding.dart';
import '../../datasources/reedem/list_product_prepaid.dart';
import 'reedem_all_product.dart';
import 'widgets/item_reedem_product_card.dart';

class ReedemPage extends StatefulWidget {
  const ReedemPage({super.key});

  @override
  State<ReedemPage> createState() => _ReedemPageState();
}

class _ReedemPageState extends State<ReedemPage> {
  List<ProductPrepaidCategory> listProductPrepaidCategory =
      ListProductPrepaid.getProductPrepaid();

  @override
  Widget build(BuildContext context) {
    // Create a map to hold grouped products by categoryName
    Map<String, List<Product>> groupedProducts = {};

    // Iterate through the products and group them by categoryName
    for (final merchant in listProductPrepaidCategory) {
      final category = merchant.categoryName;
      if (!groupedProducts.containsKey(category)) {
        groupedProducts[category] = [];
      }
      groupedProducts[category]?.addAll(merchant.listProducts);
    }

    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: PlainAppBar(
        leadingIcon: Icons.arrow_back_ios,
        iconColor: AppColors.secondary,
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
              child: ListView.builder(
                itemCount: listProductPrepaidCategory.length,
                itemBuilder: (context, index) {
                  final merchant = listProductPrepaidCategory[index];
                  final isFirstChild = index == 0;
                  final isDifferentCategory = isFirstChild ||
                      merchant.categoryName !=
                          listProductPrepaidCategory[index - 1].categoryName;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (isDifferentCategory)
                        Container(
                          width: double.infinity,
                          padding: CustomPadding.p2,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                merchant.categoryName,
                                style: TextStyles.large(
                                  color: AppColors.secondary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const ReedemPageAllProducts(),
                                    ),
                                  );
                                },
                                child: Text(
                                  'Lihat Semua',
                                  style: TextStyles.large(
                                    color: AppColors.info,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 1,
                        itemBuilder: (context, indexProduct) {
                          final product = merchant.listProducts[indexProduct];
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              ProductItemWidget(
                                productData: product,
                                listProductmerchant: merchant.listProducts,
                              ),
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
