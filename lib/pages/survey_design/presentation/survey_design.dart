import 'dart:convert';
import 'package:flutter/material.dart';

import '../../../common/components/elevated_button.dart';
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

import '../../payment/presentation/payment_method.dart';
import '../data/repository/local/localRepositoryAge.dart';
import '../data/repository/local/localRepositoryQuestion.dart';
import '../data/repository/local/localRepositoryReportTime.dart';
import '../data/repository/local/localRepositoryRespondent.dart';
import '../data/repository/local/localRepositoryScreener.dart';

import 'widgets/question_option.dart';
import 'widgets/report_time_option.dart';
import 'widgets/respondent_option.dart';
import 'demography_option.dart';
import 'survey_design_list.dart';

class SurveyDesign extends StatefulWidget {
  const SurveyDesign({super.key});

  @override
  State<SurveyDesign> createState() => _SurveyDesignState();
}

class _SurveyDesignState extends State<SurveyDesign> {
  int totalPrice = 0;
  String screenerOptionValue = '';
  int respondentId = 0;
  dynamic respondentScope;

  int questionId = 0;
  dynamic questionScope;

  int reportTimeId = 0;
  dynamic reportTimeScope;
  int reportTimePrice = 0;

  final respondentLocalRepository = LocalRepositoryRespondent();
  final questionLocalRepository = LocalRepositoryQuestion();
  final reportTimeLocalRepository = LocalRepositoryReportTime();
  final screenerLocalRepository = LocalRepositoryScreener();
  final demographyAgeLocalRepository = LocalRepositoryDemographyAge();

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
    final getOptionValue = await respondentLocalRepository.getOption();

    if (getOptionValue != null) {
      if (getOptionValue['id'] == null || getOptionValue['scope'] == null) {
        setState(() {
          respondentId = 0;
          respondentScope = 'Pilih Jumlah Responden';
        });
      } else {
        setState(() {
          respondentId = getOptionValue['id'];
          respondentScope = getOptionValue['scope'];
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

  // Get Question Option
  Future getQuestionValue() async {
    final getOptionValue = await questionLocalRepository.getOption();

    if (getOptionValue != null) {
      if (getOptionValue['id'] == null || getOptionValue['scope'] == null) {
        setState(() {
          questionId = 0;
          questionScope = 'Pilih Jumlah Pertanyaan';
        });
      } else {
        setState(() {
          questionId = getOptionValue['id'];
          questionScope = getOptionValue['scope'];
        });
      }
    } else {
      setState(() {
        questionId = 0;
        questionScope = 'Pilih Jumlah Pertanyaan';
      });
    }
  }

  // Get ReportTime Option
  Future getReportTimeValue() async {
    final getOptionValue = await reportTimeLocalRepository.getOption();

    if (getOptionValue != null) {
      if (getOptionValue['id'] == null || getOptionValue['scope'] == null) {
        setState(() {
          reportTimeId = 0;
          reportTimePrice = 0;
          reportTimeScope = 'Pilih Durasi Report';
        });
      } else {
        setState(() {
          reportTimeId = getOptionValue['id'];
          reportTimeScope = getOptionValue['scope'];
          reportTimePrice = getOptionValue['price'];
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

  // Get Screener Option
  Future getScreenerValue() async {
    final getOptionValue = await screenerLocalRepository.getOption();

    if (getOptionValue != null) {
      if (getOptionValue['scope'] == null) {
        setState(() {
          screenerOptionValue = '';
        });
      } else {
        setState(() {
          screenerOptionValue = getOptionValue['scope'];
        });
      }
    } else {
      setState(() {
        screenerOptionValue = '';
      });
    }
  }

  // Save Screener
  Future<void> setOption() async {
    var setOption = {
      'scope': screenerOptionValue,
    };
    String setOptionJson = jsonEncode(setOption);
    await screenerLocalRepository.setOption(setOptionJson);
  }

  Future<void> deleteAllOptiondValue() async {
    await respondentLocalRepository.deleteOption();
    await questionLocalRepository.deleteOption();
    await reportTimeLocalRepository.deleteOption();
    await screenerLocalRepository.deleteOption();
    await demographyAgeLocalRepository.deleteOption();
  }

  @override
  Widget build(BuildContext context) {
    String formatterRupiahPrice = formatCurrency(totalPrice.toDouble());

    return Scaffold(
      appBar: PlainAppBar(
        onPressed: () {
          deleteAllOptiondValue();
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
                        width: AppWidth.imageSize(context, AppWidth.large),
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
                              builder: (context) => const RespondentOption())),
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
                              builder: (context) => const QuestionOption())),
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
                    GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const DemographyOption())),
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
                              builder: (context) => const ReportTimeOption())),
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
                              selectedOption: screenerOptionValue,
                              onChanged: (value) {
                                setState(() {
                                  screenerOptionValue = value;
                                  setOption();
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
                              selectedOption: screenerOptionValue,
                              onChanged: (value) {
                                setState(() {
                                  screenerOptionValue = value;
                                  setOption();
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
                            screenerOptionValue != ''
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
                  width: AppWidth.imageSize(context, AppWidth.medium),
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
                        deleteAllOptiondValue();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const PaymentMethodPage()));
                      })),
            ),
          ],
        );
      },
    );
  }
}
