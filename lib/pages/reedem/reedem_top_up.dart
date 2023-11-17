// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:survey_io/common/components/appbar_plain.dart';
import 'package:survey_io/common/components/divider.dart';
import 'package:survey_io/common/components/image_rounded.dart';
import 'package:survey_io/common/components/label.dart';
import 'package:survey_io/common/components/text_button.dart';
import 'package:survey_io/common/constants/colors.dart';
import 'package:survey_io/common/constants/padding.dart';
import 'package:survey_io/datasources/profile/profile_datasource.dart';
import '../../../common/constants/styles.dart';
import 'widgets/bottom_container.dart';

class ReedemTopUpPage extends StatefulWidget {
  final int productId;
  final String productName;
  final String productCode;
  final String productImage;
  final List listProducts;
  final int koin;
  final int amount;
  final Function(int) onSelectedProductChanged;

  const ReedemTopUpPage({
    Key? key,
    required this.productId,
    required this.productCode,
    required this.productName,
    required this.productImage,
    required this.listProducts,
    required this.koin,
    required this.amount,
    required this.onSelectedProductChanged,
  }) : super(key: key);

  @override
  State<ReedemTopUpPage> createState() => _ReedemTopUpPageState();
}

class _ReedemTopUpPageState extends State<ReedemTopUpPage> {
  int userId = 0;
  int selectedProductId = 0;
  int selectedAmount = 0;
  int _koin = 0;
  String selectedProductName = '';
  String selectedProductCode = '';
  TextEditingController inputPhoneNumber = TextEditingController();
  bool isBottomContainerVisible = false;

  @override
  void initState() {
    super.initState();
    selectedProductId = widget.productId;
    selectedProductName = widget.productName;
    selectedAmount = widget.amount;
    selectedProductCode = widget.productCode;
    isBottomContainerVisible = true;
    _koin = widget.koin;
    loadProfileInformation();
  }

  void loadProfileInformation() async {
    try {
      final result = await ProfileRemoteDatasource().getProfile();

      result.fold(
        (error) {
          print('Error: $error');
        },
        (data) {
          setState(() {
            userId = data.data.user.id;
            inputPhoneNumber.text = data.data.user.phoneNumber;
          });
        },
      );
    } catch (e) {
      print('Exception: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PlainAppBar(
        onPressed: () {
          Navigator.pop(context);
        },
        leadingIcon: Icons.arrow_back_ios,
        iconColor: AppColors.secondary,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: CustomPadding.px3,
            child: LabelInput(
                labelText: 'Top Up ${widget.productName}',
                labelStyle: TextStyles.h2(color: AppColors.secondary)),
          ),
          Expanded(
            child: SingleChildScrollView(
              // physics: NeverScrollableScrollPhysics(),
              child: Container(
                padding: CustomPadding.pdefault,
                child: Column(
                  children: [
                    CustomDividers.smallDivider(),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.18,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: RoundedImage(
                        imageType: 'network',
                        imageUrl: widget.productImage,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                    CustomDividers.regularDivider(),
                    Text(
                      'Nomor ${widget.productName} Terdaftar',
                      style: TextStyles.h3(),
                    ),
                    CustomDividers.smallDivider(),
                    SizedBox(
                      width: 200,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isBottomContainerVisible = false;
                          });
                        },
                        child: TextFormField(
                          style: TextStyles.large(color: AppColors.secondary),
                          keyboardAppearance: Brightness.dark,
                          keyboardType: TextInputType.phone,
                          textAlign: TextAlign.center,
                          controller: inputPhoneNumber,
                        ),
                      ),
                    ),
                    CustomDividers.mediumDivider(),
                    GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 15.0,
                        crossAxisSpacing: 10.0,
                        mainAxisExtent: 56,
                      ),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: widget.listProducts.length,
                      itemBuilder: (context, index) {
                        var product = widget.listProducts[index];
                        return selectedProductId == product.id
                            ? TextButtonFilled.primary(
                                text: product.amount.toString(),
                                onPressed: () {
                                  print('Unselected => ${product.id}');
                                  setState(() {
                                    selectedProductId = 0;
                                    isBottomContainerVisible = false;
                                  });
                                  widget.onSelectedProductChanged(0);
                                },
                              )
                            : TextButtonOutlined.primary(
                                text: product.amount.toString(),
                                onPressed: () {
                                  print(
                                      'Selected => ${product.id} / ${product.productCode} / ${product.amount}');

                                  setState(() {
                                    selectedProductId = product.id;
                                    selectedAmount = product.amount;
                                    isBottomContainerVisible = true;
                                    _koin = product.amount;
                                  });
                                  widget.onSelectedProductChanged(product.id);
                                },
                              );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (isBottomContainerVisible)
            Visibility(
              visible: MediaQuery.of(context).viewInsets.bottom < 1,
              child: BottomContainer(
                phoneNumber: inputPhoneNumber.text,
                productName: selectedProductName,
                productId: selectedProductId,
                productCode: selectedProductCode,
                amount: selectedAmount,
                koin: _koin.toInt(),
              ),
            )
        ],
      ),
    );
  }
}
