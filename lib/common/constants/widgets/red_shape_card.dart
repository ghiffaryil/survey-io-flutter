import 'package:flutter/material.dart';

import '../../../../common/constants/colors.dart';

class RedShapeCircular extends StatelessWidget {
  const RedShapeCircular({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: null,
      right: null,
      bottom: null,
      left: null,
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(40.0),
            bottomRight: Radius.circular(40.0),
          ),
          color: AppColors.primary,
        ),
        width: MediaQuery.of(context).size.width * 1,
        height: MediaQuery.of(context).size.height * 0.05,
      ),
    );
  }
}