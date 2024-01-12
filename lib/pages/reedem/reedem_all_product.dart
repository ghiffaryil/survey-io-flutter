// ignore_for_file: non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:survey_io/bloc/reedem/product_prepaid_list/product_prepaid_list_bloc.dart';
import 'package:survey_io/common/components/image_rounded.dart';
import 'package:survey_io/common/components/shimmer_card.dart';
import 'package:survey_io/common/constants/styles.dart';
import 'package:survey_io/common/constants/colors.dart';
import 'package:survey_io/common/components/divider.dart';
import 'package:survey_io/pages/reedem/widgets/item_reedem_wrapper.dart';
import 'package:survey_io/common/components/appbar_plain.dart';
import 'package:survey_io/common/components/label.dart';
import 'package:survey_io/common/constants/padding.dart';

class ReedemPageAllProducts extends StatefulWidget {
  const ReedemPageAllProducts({super.key});

  @override
  State<ReedemPageAllProducts> createState() => _ReedemPageAllProductsState();
}

class _ReedemPageAllProductsState extends State<ReedemPageAllProducts> {
  @override
  void initState() {
    super.initState();
    context
        .read<ProductPrepaidListBloc>()
        .add(const ProductPrepaidListEvent.getProductPrepaidList());
  }

  @override
  Widget build(BuildContext context) {
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
              padding: CustomPadding.p1,
              child:
                  BlocBuilder<ProductPrepaidListBloc, ProductPrepaidListState>(
                builder: (context, state) {
                  return state.maybeWhen(
                    orElse: () {
                      return Container();
                    },
                    loading: () {
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: 8,
                          itemBuilder: (context, index) {
                            return const ShimmerReedem();
                          });
                    },
                    error: (message) {
                      return Center(
                        child: Text(message),
                      );
                    },
                    loaded: (data) {
                      return ListView.separated(
                        separatorBuilder: (context, index) {
                          return const Divider();
                        },
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          final productPrepaid = data[index];
                          final isFirstChild = index == 0;
                          final isDifferentCategory = isFirstChild ||
                              productPrepaid.productName !=
                                  data[index - 1].productName;
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              if (isDifferentCategory)
                                Container(
                                  width: double.infinity,
                                  padding: CustomPadding.p1,
                                  child: Text(
                                    productPrepaid.productName,
                                    style: TextStyles.large(
                                      color: AppColors.secondary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: productPrepaid.products.length,
                                itemBuilder: (context, indexProduct) {
                                  final product =
                                      productPrepaid.products[indexProduct];
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Card(
                                        color: AppColors.white,
                                        surfaceTintColor: AppColors.white,
                                        elevation: 3,
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                flex: 4,
                                                child: Padding(
                                                  padding: CustomPadding.p1,
                                                  child: RoundedImage(
                                                    imageType: 'network',
                                                    imageUrl:
                                                        product.categoryImage,
                                                    height: 135,
                                                    fit: BoxFit.fitHeight,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 6,
                                                child: Padding(
                                                  padding: CustomPadding.p1,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        'Top Up ${product.amount}',
                                                        style: TextStyles.h4(),
                                                      ),
                                                      CustomDividers
                                                          .verySmallDivider(),
                                                      Text(
                                                          'Get Top ${product.productName} balance up To ${product.amount}'),
                                                      CustomDividers
                                                          .verySmallDivider(),
                                                      Container(
                                                          width:
                                                              double.infinity,
                                                          alignment: Alignment
                                                              .centerRight,
                                                          child: TextButton(
                                                            style: TextButton
                                                                .styleFrom(
                                                              minimumSize:
                                                                  const Size(
                                                                      20, 20),
                                                              backgroundColor:
                                                                  AppColors
                                                                      .white,
                                                              side: const BorderSide(
                                                                  color: AppColors
                                                                      .primary),
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10.0),
                                                              ),
                                                            ),
                                                            onPressed: () {
                                                              Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          RedeemTopUpPageWrapper(
                                                                    productId:
                                                                        product
                                                                            .id,
                                                                    productCode:
                                                                        product
                                                                            .productCode,
                                                                    productName:
                                                                        product
                                                                            .productName,
                                                                    productImage:
                                                                        product
                                                                            .image,
                                                                    listProducts:
                                                                        data[index]
                                                                            .products,
                                                                    koin: product
                                                                        .amount,
                                                                    amount: product
                                                                        .amount,
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                            child:
                                                                const Padding(
                                                              padding:
                                                                  CustomPadding
                                                                      .px1,
                                                              child: Text(
                                                                'Reedem',
                                                                style:
                                                                    TextStyle(
                                                                  color: AppColors
                                                                      .primary,
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
                                      ),
                                      CustomDividers.verySmallDivider(),
                                    ],
                                  );
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
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
