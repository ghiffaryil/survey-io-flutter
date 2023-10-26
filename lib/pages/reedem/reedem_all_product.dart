// ignore_for_file: non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:survey_io/common/constants/styles.dart';
import 'package:survey_io/common/constants/colors.dart';
import 'package:survey_io/common/components/divider.dart';
import 'package:survey_io/models/reedem/product_prepaid_model.dart';
import '../../../common/components/appbar_plain.dart';
import '../../../common/components/label.dart';
import '../../../common/constants/padding.dart';
import '../../datasources/reedem/list_product_prepaid.dart';
import 'widgets/item_reedem_product_card.dart';

class ReedemPageAllProducts extends StatefulWidget {
  const ReedemPageAllProducts({super.key});

  @override
  State<ReedemPageAllProducts> createState() => _ReedemPageAllProductsState();
}

class _ReedemPageAllProductsState extends State<ReedemPageAllProducts> {
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
        height: 56,
        toolbarHeight: 56,
      ),
      body: Column(
        children: [
          Container(
            color: AppColors.white,
            child: Padding(
              padding: CustomPadding.p2,
              child: LabelInput(
                labelText: 'Semua Produk',
                labelStyle: TextStyles.h3(color: AppColors.secondary),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: CustomPadding.p2,
              child: ListView.separated(
                separatorBuilder: (context, index) {
                  return const Divider();
                },
                itemCount: listProductPrepaidCategory.length,
                itemBuilder: (context, index) {
                  final merchant = listProductPrepaidCategory[index];
                  final isFirstChild = index == 0;
                  final isDifferentCategory = isFirstChild ||
                      merchant.productName !=
                          listProductPrepaidCategory[index - 1].productName;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (isDifferentCategory)
                        Container(
                          width: double.infinity,
                          padding: CustomPadding.p1,
                          child: Text(
                            merchant.productName,
                            style: TextStyles.large(
                              color: AppColors.secondary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: merchant.listProducts.length,
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
