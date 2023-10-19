import 'package:flutter/material.dart';
import 'package:survey_io/common/constants/imageSize.dart';
import 'package:survey_io/common/constants/images.dart';
import 'package:survey_io/common/constants/padding.dart';

class SurveyDesign extends StatefulWidget {
  const SurveyDesign({super.key});

  @override
  State<SurveyDesign> createState() => _SurveyDesignState();
}

class _SurveyDesignState extends State<SurveyDesign> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: CustomPadding.pdefault,
        child: Column(
          children: [
            Image.asset(
              Images.logoHorizontal,
              width: AppSizeWidth.imageSize(context, AppSizeWidth.large),
            )
          ],
        ),
      ),
    );
  }
}
