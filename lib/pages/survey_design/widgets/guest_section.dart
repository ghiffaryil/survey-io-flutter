import 'package:flutter/material.dart';
import 'package:survey_io/common/components/divider.dart';
import 'package:survey_io/common/components/elevated_button.dart';
import 'package:survey_io/common/constants/colors.dart';
import 'package:survey_io/common/constants/images.dart';
import 'package:survey_io/common/constants/padding.dart';
import 'package:survey_io/common/constants/styles.dart';
import 'package:survey_io/pages/survey_design/survey_design_auth.dart';

class SurveyDesignGuestSection extends StatefulWidget {
  const SurveyDesignGuestSection({super.key});

  @override
  State<SurveyDesignGuestSection> createState() =>
      _SurveyDesignGuestSectionState();
}

class _SurveyDesignGuestSectionState extends State<SurveyDesignGuestSection> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: CustomPadding.p3,
      child: Column(children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.15,
        ),
        Image.asset(
          Images.emptyCreateSurvey,
          width: MediaQuery.of(context).size.width * 0.5,
        ),
        CustomDividers.smallDivider(),
        Text(
          'Ups, kamu belum punya survei nih \n Yuk buat survei kamu sekarang!',
          textAlign: TextAlign.center,
          style: TextStyles.extraLarge(color: AppColors.secondary),
        ),
        CustomDividers.smallDivider(),
        ButtonFilled.primary(
            text: 'Buat Survei',
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SurveyDesignAuth()));
            }),
        CustomDividers.smallDivider(),
      ]),
    );
  }
}
