import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Import Component
import 'package:survey_io/common/components/text_button.dart';
import 'package:survey_io/common/components/image_rounded.dart';
import 'package:survey_io/common/constants/padding.dart';
import 'package:survey_io/common/constants/styles.dart';
import 'package:survey_io/common/constants/colors.dart';
import 'package:survey_io/common/components/divider.dart';
import 'package:survey_io/common/components/label.dart';
import 'package:survey_io/datasources/survey/list_survey.dart';
import 'package:survey_io/models/survey/survey_model.dart';

import '../../bloc/survey/survey_list/survey_list_bloc.dart';
import '../../common/components/appbar_plain.dart';
import '../../common/constants/icons.dart';

class ListSurveiPage extends StatefulWidget {
  const ListSurveiPage({super.key});

  @override
  State<ListSurveiPage> createState() => _ListSurveiPageState();
}

class _ListSurveiPageState extends State<ListSurveiPage> {
  List<SurveyModelData> listSurvey = ListSurvey.getSurvey();

  @override
  void initState() {
    super.initState();
    context.read<SurveyListBloc>().add(const SurveyListEvent.getSurveyList());
  }

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
    return Container(
        padding: CustomPadding.p1,
        child: BlocBuilder<SurveyListBloc, SurveyListState>(
            builder: (context, state) {
          return state.maybeWhen(
            orElse: () {
              return Container();
            },
            loading: () {
              return const SizedBox(
                height: 40,
                width: 40,
                child: CircularProgressIndicator(),
              );
            },
            error: (message) {
              return Text(message);
            },
            loaded: (surveyList) {
              return ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: surveyList.length,
                itemBuilder: (BuildContext context, int index) {
                  final survey = surveyList[index];

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
                          child: survey.survey.imageHomescreen.isEmpty
                              ? const RoundedImage(
                                  imageType: 'asset',
                                  imageUrl:
                                      'assets/images/global/img_empty_create_survey.png',
                                  borderRadius: 8.0,
                                  fit: BoxFit.fitWidth,
                                )
                              : RoundedImage(
                                  imageType: 'network',
                                  imageUrl: survey.survey.imageHomescreen,
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
                                survey.survey.title,
                                style:
                                    TextStyles.h5(color: AppColors.secondary),
                              ),
                              const SizedBox(height: 5),
                              Text('${survey.totalQuestion} Pertanyaan'),
                              CustomDividers.smallDivider(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
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
                                        survey.survey.energy.toString(),
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
            },
          );
        }));
  }
}
