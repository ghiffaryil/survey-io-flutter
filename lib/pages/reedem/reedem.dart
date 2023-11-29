// ignore_for_file: non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:survey_io/bloc/profile/get_profile/profile_bloc.dart';
import 'package:survey_io/bloc/reedem/product_prepaid_list/product_prepaid_list_bloc.dart';
import 'package:survey_io/common/components/image_rounded.dart';
import 'package:survey_io/common/constants/styles.dart';
import 'package:survey_io/common/constants/colors.dart';
import 'package:survey_io/common/components/divider.dart';
import 'package:survey_io/common/components/label.dart';
import 'package:survey_io/common/components/appbar_plain.dart';
import 'package:survey_io/common/constants/padding.dart';
import 'package:survey_io/pages/home/home.dart';
import 'package:survey_io/pages/reedem/widgets/item_reedem_wrapper.dart';
import 'package:survey_io/pages/reedem/widgets/user_information_card.dart';
import 'reedem_all_product.dart';

class ReedemPage extends StatefulWidget {
  const ReedemPage({super.key});

  @override
  State<ReedemPage> createState() => _ReedemPageState();
}

class _ReedemPageState extends State<ReedemPage> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(const ProfileEvent.getProfile());
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
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const HomePage(),
              ));
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
              child:
                  BlocBuilder<ProductPrepaidListBloc, ProductPrepaidListState>(
                builder: (context, state) {
                  return state.maybeWhen(
                    orElse: () {
                      return Container();
                    },
                    loading: () {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                    error: (message) {
                      return Text(message);
                    },
                    loaded: (data) {
                      return ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          final dataProduct = data[index];
                          final isFirstChild = index == 0;
                          final isDifferentCategory = isFirstChild ||
                              dataProduct.categoryName !=
                                  data[index - 1].categoryName;
                          ;

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              if (isDifferentCategory)
                                Container(
                                  width: double.infinity,
                                  padding: CustomPadding.p2,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        dataProduct.categoryName,
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
                                  final product =
                                      dataProduct.products[indexProduct];

                                  final formattedAmount =
                                      NumberFormat('###,###.###', 'id_ID')
                                          .format(product.amount);

                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Card(
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
                                                    imageUrl:
                                                        product.categoryImage,
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
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        'Top Up $formattedAmount',
                                                        style: TextStyles.h4(),
                                                      ),
                                                      CustomDividers
                                                          .verySmallDivider(),
                                                      Text(
                                                          'Get Top ${product.productName} balance up To $formattedAmount'),
                                                      CustomDividers
                                                          .smallDivider(),
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
