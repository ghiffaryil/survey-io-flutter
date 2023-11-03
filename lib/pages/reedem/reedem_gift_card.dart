// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:slide_action/slide_action.dart';
import 'package:survey_io/common/components/appbar_plain.dart';
import 'package:survey_io/common/components/divider.dart';
import 'package:survey_io/common/components/label.dart';
import 'package:survey_io/common/constants/colors.dart';
import 'package:survey_io/common/constants/imageSize.dart';
import 'package:survey_io/common/constants/padding.dart';
import 'package:survey_io/pages/reedem/reedem_gift_card_success.dart';

import '../../../common/constants/images.dart';
import '../../../common/constants/styles.dart';

class ReedemGiftCard extends StatefulWidget {
  const ReedemGiftCard({
    Key? key,
    this.callback,
  }) : super(key: key);

  final FutureOr<void> Function()? callback;

  @override
  State<ReedemGiftCard> createState() => _ReedemGiftCardState();
}

class _ReedemGiftCardState extends State<ReedemGiftCard> {
  late final ScrollController _scrollController;

  get callback => null;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PlainAppBar(
        onPressed: () {
          Navigator.pop(context);
        },
        leadingIcon: Icons.close,
        iconColor: AppColors.black,
      ),
      body: Container(
        padding: CustomPadding.pdefault,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Center(
              child: LabelInput(
                labelAlignment: Alignment.center,
                labelText: 'Selamat!',
                labelStyle: TextStyles.h2(color: AppColors.secondary),
              ),
            ),
            CustomDividers.verySmallDivider(),
            Image.asset(Images.giftCard,
                width: AppHeight.imageSize(context, AppHeight.medium)),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Kamu mendapatkan 100 koin dari Polling. Geser tombol di bawah untuk melanjutkan',
                textAlign: TextAlign.center,
                style: TextStyles.extraLarge(
                  color: AppColors.light,
                ),
              ),
            ),
            CustomDividers.mediumDivider(),
            SlideToReedem(
              callback: () async {
                await Future.delayed(const Duration(seconds: 2));
                await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ReedemGiftCardSuccess(),
                    ));
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SlideToReedem extends StatelessWidget {
  const SlideToReedem({
    this.callback,
    Key? key,
  }) : super(key: key);

  final FutureOr<void> Function()? callback;

  @override
  Widget build(BuildContext context) {
    return SlideAction(
      stretchThumb: true,
      trackBuilder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Colors.white,
            border: Border.all(
              color: AppColors.primary,
              width: 1.0,
            ),
          ),
          child: Center(
            child: Text(
              "Masukkan ke Celengan",
              style: TextStyles.large(
                  color: AppColors.primary, fontWeight: FontWeight.bold),
            ),
          ),
        );
      },
      thumbBuilder: (context, state) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color:
                state.isPerformingAction ? AppColors.primary : AppColors.info,
            borderRadius: BorderRadius.circular(100),
          ),
          child: state.isPerformingAction
              ? const CupertinoActivityIndicator(
                  color: Colors.white,
                )
              : const Icon(
                  Icons.double_arrow,
                  color: Colors.white,
                ),
        );
      },
      action: callback,
    );
  }
}
