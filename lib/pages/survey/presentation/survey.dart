import 'package:flutter/material.dart';

// Import Component
import 'package:survey_io/common/components/text_button.dart';
import 'package:survey_io/common/components/image_rounded.dart';
import 'package:survey_io/common/constants/padding.dart';
import 'package:survey_io/common/constants/styles.dart';
import 'package:survey_io/common/constants/colors.dart';
import 'package:survey_io/common/components/divider.dart';
import 'package:survey_io/common/components/label.dart';
import 'package:survey_io/pages/survey/data/list_survey.dart';
import 'package:survey_io/pages/survey/models/survey_model.dart';

import '../../../common/components/appbar_plain.dart';
import '../../../common/constants/icons.dart';

class ListSurveiPage extends StatefulWidget {
  const ListSurveiPage({super.key});

  @override
  State<ListSurveiPage> createState() => _ListSurveiPageState();
}

class _ListSurveiPageState extends State<ListSurveiPage> {
  List<SurveyModelData> listSurvey = ListSurvey.getSurvey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PlainAppBar(
        height: 70.0,
        leadingIcon: Icons.arrow_back_ios,
        iconSize: 35.0,
        iconColor: AppColors.secondary,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: CustomPadding.px2,
          child: Column(
            children: [
              LabelInput(
                  labelText: 'Survei',
                  labelStyle:
                      TextStyles.h2ExtraBold(color: AppColors.secondary)),
              CustomDividers.verySmallDivider(),
              sectionListSurvey(),
            ],
          ),
        ),
      ),
    );
  }

  Widget sectionListSurvey() {
    return ListView.separated(
      shrinkWrap:
          true, // Important to allow the ListView to scroll inside SingleChildScrollView
      physics: const NeverScrollableScrollPhysics(),
      itemCount: listSurvey.length,
      itemBuilder: (BuildContext context, int index) {
        final survey = listSurvey[index]; // Retrieve the correct survey
        final surveyTitle =
            survey.listSurvey[0].title; // Use the first item in the listSurvey
        final surveyQuestions = survey.total_question.toString();
        final surveyReward = survey.listSurvey[0].energy
            .toString(); // Use the first item in the listSurvey
        final surveyImage = survey.listSurvey[0]
            .image_homescreen; // Use the first item in the listSurvey

        return Container(
          padding: const EdgeInsets.all(7),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            children: [
              SizedBox(
                height: 150,
                width: double.infinity,
                child: surveyImage.isEmpty
                    ? const RoundedImage(
                        imageType: 'asset',
                        imageUrl:
                            'assets/images/global/img_empty_create_survey.png',
                        borderRadius: 8.0,
                        fit: BoxFit.fitWidth,
                      )
                    : RoundedImage(
                        imageType: 'network',
                        imageUrl: surveyImage,
                        borderRadius: 8.0,
                        fit: BoxFit.fitWidth,
                      ),
              ),
              Container(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomDividers.verySmallDivider(),
                    Text(
                      surveyTitle,
                      style: TextStyles.h5(color: AppColors.secondary),
                    ),
                    const SizedBox(height: 5),
                    Text('$surveyQuestions Pertanyaan'),
                    CustomDividers.smallDivider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              IconName.point,
                              width: 25,
                              height: 25,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              '$surveyReward',
                              style: TextStyles.large(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.secondary),
                            ),
                          ],
                        ),
                        const Spacer(
                          flex: 1,
                        ),
                        const Icon(
                          Icons.share,
                          size: 20,
                          color: AppColors.info,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: TextButtonFilled.primary(
                              minWidth: 0.20,
                              height: 30,
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              text: 'Ikut Survei',
                              onPressed: () {}),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const Divider(); // Replace Divider() with your custom separator widget if needed.
      },
    );
  }
}
