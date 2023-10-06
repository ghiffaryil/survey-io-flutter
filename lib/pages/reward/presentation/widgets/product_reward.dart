import 'package:flutter/material.dart';
import 'package:survey_io/common/components/divider.dart';
import 'package:survey_io/common/components/image_rounded.dart';
import 'package:survey_io/common/constants/padding.dart';
import 'package:survey_io/common/constants/styles.dart';
import '../../../../common/constants/colors.dart';

class ProductItemWidget extends StatelessWidget {
  final Map<String, dynamic> productData;

  const ProductItemWidget({
    Key? key,
    required this.productData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productName = productData['product_name'];
    final amount = productData['amount'];
    final category_image = productData['category_image'];

    return Card(
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Padding(
              padding: CustomPadding.p1,
              child: RoundedImage(
                imageType: 'network',
                imageUrl: category_image,
                height: 115,
                fit: BoxFit.fill,
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Padding(
              padding: CustomPadding.px1,
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
    );
  }
}
