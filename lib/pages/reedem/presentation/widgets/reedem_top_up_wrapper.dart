import 'package:flutter/material.dart';

import '../reedem_top_up.dart';

class RedeemTopUpPageWrapper extends StatefulWidget {
  final int productId;
  final String productName;
  final String productImage;
  final List listProducts;
  final int koin;

  const RedeemTopUpPageWrapper({
    Key? key,
    required this.productId,
    required this.productName,
    required this.productImage,
    required this.listProducts,
    required this.koin,
  }) : super(key: key);

  @override
  _RedeemTopUpPageWrapperState createState() => _RedeemTopUpPageWrapperState();
}

class _RedeemTopUpPageWrapperState extends State<RedeemTopUpPageWrapper> {
  int selectedProductId = 0;

  void setSelectedProductId(int productId) {
    setState(() {
      selectedProductId = productId;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ReedemTopUpPage(
      productId: widget.productId,
      productName: widget.productName,
      productImage: widget.productImage,
      listProducts: widget.listProducts,
      koin: widget.koin,
      onSelectedProductChanged: setSelectedProductId,
    );
  }
}
