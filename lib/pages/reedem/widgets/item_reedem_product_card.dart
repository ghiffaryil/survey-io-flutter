import 'package:flutter/material.dart';
import 'package:survey_io/common/components/divider.dart';
import 'package:survey_io/common/components/image_rounded.dart';
import 'package:survey_io/common/constants/padding.dart';
import 'package:survey_io/common/constants/styles.dart';
import '../../../../common/constants/colors.dart';
import '../../../../models/reedem/product_prepaid_model.dart';
import 'item_reedem_wrapper.dart';

class ProductItemWidget extends StatelessWidget {
  final Product productData;
  final List listProductmerchant;

  const ProductItemWidget(
      {Key? key, required this.productData, required this.listProductmerchant})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productName = productData.productName;
    final productId = productData.id;
    final amount = productData.amount;
    final productImage = productData.image;
    final categoryImage = productData.categoryImage;
    final int koinNeeded = productData.amount ~/ 1000;

    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Padding(
                padding: CustomPadding.p1,
                child: RoundedImage(
                  imageType: 'network',
                  imageUrl: categoryImage,
                  height: 120,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            Expanded(
              flex: 6,
              child: Padding(
                padding: CustomPadding.p1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Top Up $amount',
                      style: TextStyles.h4(),
                    ),
                    CustomDividers.verySmallDivider(),
                    Text('Get Top $productName balance up To $amount'),
                    CustomDividers.smallDivider(),
                    Container(
                        width: double.infinity,
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            minimumSize: const Size(20, 20),
                            backgroundColor: AppColors.white,
                            side: const BorderSide(color: AppColors.primary),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RedeemTopUpPageWrapper(
                                  productId: productId,
                                  productName: productName,
                                  productImage: productImage,
                                  listProducts: listProductmerchant,
                                  koin: koinNeeded,
                                ),
                              ),
                            );
                          },
                          child: const Padding(
                            padding: CustomPadding.px1,
                            child: Text(
                              'Reedem',
                              style: TextStyle(
                                color: AppColors.primary,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
