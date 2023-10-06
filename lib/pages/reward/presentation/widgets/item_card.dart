import 'package:flutter/material.dart';
import 'package:survey_io/common/components/divider.dart';
import 'package:survey_io/common/components/image_rounded.dart';
import 'package:survey_io/common/constants/padding.dart';
import 'package:survey_io/common/constants/styles.dart';
import '../../../../common/constants/colors.dart';
import '../../models/product_prepaid_model.dart';

class ProductItemWidget extends StatelessWidget {
  final Product productData;

  const ProductItemWidget({
    Key? key,
    required this.productData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productName = productData.product_name;
    final amount = productData.amount;
    final categoryImage = productData.category_image;

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
                      'Top Up $productName',
                      style: TextStyles.h4(),
                    ),
                    CustomDividers.verySmallDivider(),
                    Text('Get Top $productName balance up To $amount'),
                    CustomDividers.smallDivider(),
                    Container(
                        width: double.infinity,
                        // padding: CustomPadding.px1,
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            minimumSize: Size(20, 20),
                            backgroundColor: AppColors.white,
                            side: const BorderSide(color: AppColors.primary),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          onPressed: () {},
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
