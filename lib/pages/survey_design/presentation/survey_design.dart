// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:survey_io/common/components/elevated_button.dart';
import 'package:survey_io/pages/payment/presentation/payment_method.dart';
import '../../../common/components/appbar_plain.dart';
import '../../../common/components/divider.dart';
import '../../../common/components/input_field_radio.dart';
import '../../../common/components/label.dart';
import '../../../common/constants/colors.dart';
import '../../../common/constants/imageSize.dart';
import '../../../common/constants/images.dart';
import '../../../common/constants/padding.dart';
import '../../../common/constants/styles.dart';
import '../../../common/components/text_button.dart';
import '../../../common/extension/helper/currency_helper.dart';

import '../../../pages/survey_design/data/repository/local/localRepositoryQuestion.dart';
import '../../../pages/survey_design/presentation/widgets/question_choice.dart';
import '../../../pages/survey_design/presentation/widgets/report_time_choice.dart';
import '../../../pages/survey_design/presentation/widgets/respondent_choice.dart';

import '../data/repository/local/localRepositoryReportTime.dart';
import '../data/repository/local/localRepositoryRespondent.dart';
import '../data/repository/local/localRepositoryScreener.dart';

import 'survey_design_list.dart';

class SurveyDesign extends StatefulWidget {
  const SurveyDesign({super.key});

  @override
  State<SurveyDesign> createState() => _SurveyDesignState();
}

class _SurveyDesignState extends State<SurveyDesign> {
  int totalPrice = 0;
  String screenerChoiceValue = '';
  int respondentId = 0;
  var respondentScope;

  int questionId = 0;
  var questionScope;

  int reportTimeId = 0;
  var reportTimeScope;
  int reportTimePrice = 0;

  final respondentChoiceRepository = RespondentChoiceRepository();
  final questionChoiceRepository = QuestionChoiceRepository();
  final reportTimeChoiceRepository = ReportTimeChoiceRepository();
  final screenerChoiceRepository = ScreenerChoiceRepository();

  @override
  void initState() {
    getRespondentValue();
    getQuestionValue();
    getReportTimeValue();
    getScreenerValue();
    super.initState();
  }

  // Get Respondent Id
  Future getRespondentValue() async {
    final getChoiceValue = await respondentChoiceRepository.getChoice();

    if (getChoiceValue != null) {
      if (getChoiceValue['id'] == null || getChoiceValue['scope'] == null) {
        setState(() {
          respondentId = 0;
          respondentScope = 'Pilih Jumlah Responden';
        });
      } else {
        setState(() {
          respondentId = getChoiceValue['id'];
          respondentScope = getChoiceValue['scope'];
          totalPrice = totalPrice + 184000;
        });
      }
    } else {
      setState(() {
        respondentId = 0;
        respondentScope = 'Pilih Jumlah Responden';
        totalPrice = 0;
      });
    }
  }

  // Get Question Choice
  Future getQuestionValue() async {
    final getChoiceValue = await questionChoiceRepository.getChoice();

    if (getChoiceValue != null) {
      if (getChoiceValue['id'] == null || getChoiceValue['scope'] == null) {
        setState(() {
          questionId = 0;
          questionScope = 'Pilih Jumlah Pertanyaan';
        });
      } else {
        setState(() {
          questionId = getChoiceValue['id'];
          questionScope = getChoiceValue['scope'];
        });
      }
    } else {
      setState(() {
        questionId = 0;
        questionScope = 'Pilih Jumlah Pertanyaan';
      });
    }
  }

  // Get ReportTime Choice
  Future getReportTimeValue() async {
    final getChoiceValue = await reportTimeChoiceRepository.getChoice();

    if (getChoiceValue != null) {
      if (getChoiceValue['id'] == null || getChoiceValue['scope'] == null) {
        setState(() {
          reportTimeId = 0;
          reportTimePrice = 0;
          reportTimeScope = 'Pilih Durasi Report';
        });
      } else {
        setState(() {
          reportTimeId = getChoiceValue['id'];
          reportTimeScope = getChoiceValue['scope'];
          reportTimePrice = getChoiceValue['price'];
          totalPrice = totalPrice + reportTimePrice;
        });
      }
    } else {
      setState(() {
        reportTimeId = 0;
        reportTimePrice = 0;
        reportTimeScope = 'Pilih Durasi Report';
      });
    }
  }

  // Get Screener Choice
  Future getScreenerValue() async {
    final getChoiceValue = await screenerChoiceRepository.getChoice();

    if (getChoiceValue != null) {
      if (getChoiceValue['value'] == null) {
        setState(() {
          screenerChoiceValue = '';
        });
      } else {
        setState(() {
          screenerChoiceValue = getChoiceValue['value'];
        });
      }
    } else {
      setState(() {
        screenerChoiceValue = '';
      });
    }
  }

  // Save Screener
  Future<void> saveScreenerSelected() async {
    var setChoiceValue = {
      'value': screenerChoiceValue,
    };
    String setChoiceValueJson = jsonEncode(setChoiceValue);
    try {
      await screenerChoiceRepository.setChoice(setChoiceValueJson);
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteAllChoicedValue() async {
    try {
      await respondentChoiceRepository.deleteChoice();
      await questionChoiceRepository.deleteChoice();
      await reportTimeChoiceRepository.deleteChoice();
      await screenerChoiceRepository.deleteChoice();
      print('Deleted all Choices');
    } catch (e) {
      print('Error deleting shared preferences: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    String formatterRupiahPrice = formatCurrency(totalPrice.toDouble());

    return Scaffold(
      appBar: PlainAppBar(
        onPressed: () {
          deleteAllChoicedValue();
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const SurveyDesignList()));
        },
        leadingIcon: Icons.close,
        iconColor: AppColors.black,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                padding: CustomPadding.pdefault,
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topCenter,
                      child: Image.asset(
                        Images.logoHorizontal,
                        width:
                            AppSizeWidth.imageSize(context, AppSizeWidth.large),
                      ),
                    ),
                    CustomDividers.smallDivider(),
                    LabelInput(
                      labelText: 'Responden',
                      labelStyle: TextStyles.medium(color: AppColors.secondary),
                    ),
                    CustomDividers.verySmallDivider(),
                    GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const RespondentChoice())),
                      child: Container(
                        height: 60,
                        width: double.infinity,
                        padding: CustomPadding.p1,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: AppColors.secondary, width: 1.5),
                            borderRadius: BorderRadius.circular(50)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: CustomPadding.px1,
                              child: Text(
                                '$respondentScope',
                                style: TextStyles.large(
                                    color: respondentId < 1
                                        ? AppColors.secondary
                                        : AppColors.black,
                                    fontWeight: respondentId < 1
                                        ? FontWeight.normal
                                        : FontWeight.bold),
                              ),
                            ),
                            const Padding(
                              padding: CustomPadding.px1,
                              child: Icon(
                                Icons.keyboard_arrow_down_outlined,
                                color: AppColors.secondary,
                                size: 30,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    CustomDividers.smallDivider(),
                    LabelInput(
                      labelText: 'Pertanyaan',
                      labelStyle: TextStyles.medium(color: AppColors.secondary),
                    ),
                    CustomDividers.verySmallDivider(),
                    GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const QuestionChoice())),
                      child: Container(
                        height: 60,
                        width: double.infinity,
                        padding: CustomPadding.p1,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: AppColors.secondary, width: 1.5),
                            borderRadius: BorderRadius.circular(50)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: CustomPadding.px1,
                              child: Text(
                                '$questionScope',
                                style: TextStyles.large(
                                    color: questionId < 1
                                        ? AppColors.secondary
                                        : AppColors.black,
                                    fontWeight: questionId < 1
                                        ? FontWeight.normal
                                        : FontWeight.bold),
                              ),
                            ),
                            const Padding(
                              padding: CustomPadding.px1,
                              child: Icon(
                                Icons.keyboard_arrow_down_outlined,
                                color: AppColors.secondary,
                                size: 30,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    CustomDividers.smallDivider(),
                    LabelInput(
                      labelText: 'Demografi (Optional)',
                      labelStyle: TextStyles.medium(color: AppColors.secondary),
                    ),
                    CustomDividers.verySmallDivider(),
                    Container(
                      height: 60,
                      width: double.infinity,
                      padding: CustomPadding.p1,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: AppColors.secondary, width: 1.5),
                          borderRadius: BorderRadius.circular(50)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: CustomPadding.px1,
                            child: Text(
                              'Default : Semua Demografi',
                              style: TextStyles.large(
                                  color: AppColors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          const Padding(
                            padding: CustomPadding.px1,
                            child: Icon(
                              Icons.keyboard_arrow_down_outlined,
                              color: AppColors.secondary,
                              size: 30,
                            ),
                          ),
                        ],
                      ),
                    ),
                    CustomDividers.smallDivider(),
                    LabelInput(
                      labelText: 'Kecepatan Report',
                      labelStyle: TextStyles.medium(color: AppColors.secondary),
                    ),
                    CustomDividers.verySmallDivider(),
                    GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ReportTimeChoice())),
                      child: Container(
                        height: 60,
                        width: double.infinity,
                        padding: CustomPadding.p1,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: AppColors.secondary, width: 1.5),
                            borderRadius: BorderRadius.circular(50)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: CustomPadding.px1,
                              child: Text(
                                '$reportTimeScope',
                                style: TextStyles.large(
                                    color: reportTimeId < 1
                                        ? AppColors.secondary
                                        : AppColors.black,
                                    fontWeight: reportTimeId < 1
                                        ? FontWeight.normal
                                        : FontWeight.bold),
                              ),
                            ),
                            const Padding(
                              padding: CustomPadding.px1,
                              child: Icon(
                                Icons.keyboard_arrow_down_outlined,
                                color: AppColors.secondary,
                                size: 30,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    CustomDividers.smallDivider(),
                    LabelInput(
                      labelText: 'Screener',
                      labelStyle: TextStyles.medium(color: AppColors.secondary),
                    ),
                    CustomDividers.verySmallDivider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            flex: 5,
                            child: RadioTextInput(
                              value: 'Ya',
                              selectedOption: screenerChoiceValue,
                              onChanged: (value) {
                                setState(() {
                                  screenerChoiceValue = value;
                                  saveScreenerSelected();
                                });
                              },
                            )),
                        Container(
                          width: 15,
                        ),
                        Expanded(
                            flex: 5,
                            child: RadioTextInput(
                              value: 'Tidak',
                              selectedOption: screenerChoiceValue,
                              onChanged: (value) {
                                setState(() {
                                  screenerChoiceValue = value;
                                  saveScreenerSelected();
                                });
                              },
                            )),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 10.0,
                  spreadRadius: 0.2,
                  offset: Offset(0, 0.5),
                ),
              ],
            ),
            child: Container(
              padding: const EdgeInsets.all(15),
              width: double.infinity,
              child: Row(
                children: [
                  Expanded(
                      flex: 5,
                      child: totalPrice != 0
                          ? Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Total Biaya',
                                    style: TextStyles.regular(),
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    '$formatterRupiahPrice,-',
                                    style: TextStyles.h3(),
                                  ),
                                ],
                              ),
                            )
                          : Container()),
                  Expanded(
                    flex: 5,
                    child: respondentId > 0 &&
                            questionId > 0 &&
                            reportTimeId > 0 &&
                            screenerChoiceValue != ''
                        ? TextButtonFilled.primary(
                            text: 'Bayar',
                            onPressed: () {
                              showProceedToPaymentDialog(context);
                            },
                            fontSize: 17,
                            minWidth: 20,
                            height: 50,
                          )
                        : TextButtonFilled.secondary(
                            text: 'Bayar',
                            onPressed: () {
                              // showProceedToPaymentDialog(context);
                            },
                            fontSize: 17,
                            minWidth: 20,
                            height: 50,
                          ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Define a function to create and show the AlertDialog
  void showProceedToPaymentDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          icon: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
                alignment: Alignment.centerRight,
                child: const Icon(
                  Icons.close,
                  size: 30,
                )),
          ),
          content: Container(
            padding: CustomPadding.px1,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Image.asset(
                  Images.proccedToPay,
                  width: AppSizeWidth.imageSize(context, AppSizeWidth.medium),
                ),
                CustomDividers.smallDivider(),
                Text(
                  'Lakukan Pembayaran!',
                  textAlign: TextAlign.center,
                  style: TextStyles.h3(color: AppColors.secondary),
                ),
                CustomDividers.smallDivider(),
                Text(
                  'Sebelum melanjutkan, silahkan lakukan pembayaran terlebih dahulu.',
                  textAlign: TextAlign.center,
                  style: TextStyles.medium(color: AppColors.secondary),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            Container(
              padding: CustomPadding.p2,
              child: Center(
                  child: ButtonFilled.primary(
                      text: 'Bayar Sekarang',
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PaymentMethodPage()));
                      })),
            ),
          ],
        );
      },
    );
  }
}
