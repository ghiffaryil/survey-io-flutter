import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:survey_io/bloc/profile/get_profile/profile_bloc.dart';

import 'package:survey_io/common/components/elevated_button.dart';
import 'package:survey_io/common/components/appbar_plain.dart';
import 'package:survey_io/common/components/divider.dart';
import 'package:survey_io/common/components/input_field_radio.dart';
import 'package:survey_io/common/components/label.dart';
import 'package:survey_io/common/constants/colors.dart';
import 'package:survey_io/common/constants/imageSize.dart';
import 'package:survey_io/common/constants/images.dart';
import 'package:survey_io/common/constants/padding.dart';
import 'package:survey_io/common/constants/styles.dart';
import 'package:survey_io/common/components/text_button.dart';
import 'package:survey_io/common/extension/helper/currency_helper.dart';
import 'package:survey_io/datasources/survey_design/repository/localRepositoryAge.dart';
import 'package:survey_io/datasources/survey_design/repository/localRepositoryChildren.dart';
import 'package:survey_io/datasources/survey_design/repository/localRepositoryGender.dart';
import 'package:survey_io/datasources/survey_design/repository/localRepositoryIncome.dart';
import 'package:survey_io/datasources/survey_design/repository/localRepositoryMarital.dart';
import 'package:survey_io/datasources/survey_design/repository/localRepositoryOccupation.dart';
import 'package:survey_io/datasources/survey_design/repository/localRepositoryOutcome.dart';
import 'package:survey_io/datasources/survey_design/repository/localRepositoryQuestion.dart';
import 'package:survey_io/datasources/survey_design/repository/localRepositoryRegion.dart';
import 'package:survey_io/datasources/survey_design/repository/localRepositoryReligion.dart';
import 'package:survey_io/datasources/survey_design/repository/localRepositoryReportTime.dart';
import 'package:survey_io/datasources/survey_design/repository/localRepositoryRespondent.dart';
import 'package:survey_io/datasources/survey_design/repository/localRepositoryScreener.dart';
import 'package:survey_io/pages/home/home.dart';
import 'package:survey_io/pages/payment/payment_method.dart';
import 'package:survey_io/pages/survey_design/widgets/question_option.dart';
import 'package:survey_io/pages/survey_design/widgets/report_time_option.dart';
import 'package:survey_io/pages/survey_design/widgets/respondent_option.dart';
import 'package:survey_io/pages/survey_design/survey_design_demography.dart';
// import 'package:survey_io/pages/survey_design/survey_design_list.dart';

class SurveyDesign extends StatefulWidget {
  final String designAction;

  const SurveyDesign({super.key, required this.designAction});

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

  String valueTextDemography = 'Default : Semua Demografi';

  final respondentLocalRepository = LocalRepositoryRespondent();
  final questionLocalRepository = LocalRepositoryQuestion();
  final reportTimeLocalRepository = LocalRepositoryReportTime();
  final screenerLocalRepository = LocalRepositoryScreener();

  final demographyAgeLocalRepository = LocalRepositoryDemographyAge();
  final demographyChildrenLocalRepository = LocalRepositoryDemographyChildren();
  final demographyGenderLocalRepository = LocalRepositoryDemographyGender();
  final demographyIncomeLocalRepository = LocalRepositoryDemographyIncome();
  final demographyMaritalLocalRepository = LocalRepositoryDemographyMarital();
  final demographyOccupationLocalRepository =
      LocalRepositoryDemographyOccupation();
  final demographyOutcomeLocalRepository = LocalRepositoryDemographyOutcome();
  final demographyRegionLocalRepository = LocalRepositoryDemographyRegion();
  final demographyReligionLocalRepository = LocalRepositoryDemographyReligion();

  List demographyAgeScopeValue = [];
  String demographyGenderScopeValue = '';
  List demographyChildrenScopeValue = [];
  List demographyIncomeScopeValue = [];
  List demographyMaritalScopeValue = [];
  String demographyOccupationScopeValue = '';
  List demographyOutcomeScopeValue = [];
  String demographyRegionScopeValue = '';
  String demographyReligionScopeValue = '';

  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(const ProfileEvent.getProfile());
    loadData();
  }

  // Load All Data
  loadData() {
    getRespondentValue();
    getQuestionValue();
    getReportTimeValue();
    getScreenerValue();
    getDemographyValue();
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

  // Get Demography Value
  Future getDemographyValue() async {
    final getDemographyAgeValue =
        await demographyAgeLocalRepository.getOption();
    var demographyAgeScope = getDemographyAgeValue?['scope'];

    final getDemographyGenderValue =
        await demographyGenderLocalRepository.getOption();
    var demographyGenderScope = getDemographyGenderValue?['scope'];

    final getDemographyChildrenValue =
        await demographyChildrenLocalRepository.getOption();
    var demographyChildrenScope = getDemographyChildrenValue?['scope'];

    final getDemographyIncomeValue =
        await demographyIncomeLocalRepository.getOption();
    var demographyIncomeScope = getDemographyIncomeValue?['scope'];

    final getDemographyMaritalValue =
        await demographyMaritalLocalRepository.getOption();
    var demographyMaritalScope = getDemographyMaritalValue?['scope'];

    final getDemographyOccupationValue =
        await demographyOccupationLocalRepository.getOption();
    var demographyOccupationScope = getDemographyOccupationValue?['scope'];

    final getDemographyOutcomeValue =
        await demographyOutcomeLocalRepository.getOption();
    var demographyOutcomeScope = getDemographyOutcomeValue?['scope'];

    final getDemographyRegionValue =
        await demographyRegionLocalRepository.getOption();
    var demographyRegionScope = getDemographyRegionValue?['scope'];

    final getDemographyReligionValue =
        await demographyReligionLocalRepository.getOption();
    var demographyReligionScope = getDemographyReligionValue?['scope'];

    if (demographyAgeScope == null &&
        demographyGenderScope == null &&
        demographyChildrenScope == null &&
        demographyIncomeScope == null &&
        demographyMaritalScope == null &&
        demographyOccupationScope == null &&
        demographyOutcomeScope == null &&
        demographyRegionScope == null &&
        demographyReligionScope == null) {
      setState(() {
        valueTextDemography = 'Default : Semua Demografi';
        demographyAgeScopeValue = [];
        demographyGenderScopeValue = 'Semua';
        demographyChildrenScopeValue = [];
        demographyIncomeScopeValue = [];
        demographyMaritalScopeValue = [];
        demographyOccupationScopeValue = 'Semua';
        demographyOutcomeScopeValue = [];
        demographyRegionScopeValue = 'Semua';
        demographyReligionScopeValue = 'Semua';
      });
    } else {
      setState(() {
        valueTextDemography = 'Custom';
        demographyAgeScopeValue = demographyAgeScope;
        demographyGenderScopeValue = demographyGenderScope;
        demographyChildrenScopeValue = demographyChildrenScope;
        demographyIncomeScopeValue = demographyIncomeScope;
        demographyMaritalScopeValue = demographyMaritalScope;
        demographyOccupationScopeValue = demographyOccupationScope;
        demographyOutcomeScopeValue = demographyOutcomeScope;
        demographyRegionScopeValue = demographyRegionScope;
        demographyReligionScopeValue = demographyReligionScope;
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

  // DELETE ALL OPTION
  Future<void> deleteAllOptiondValue() async {
    await respondentLocalRepository.deleteOption();
    await questionLocalRepository.deleteOption();
    await reportTimeLocalRepository.deleteOption();
    await screenerLocalRepository.deleteOption();

    await demographyAgeLocalRepository.deleteOption();
    await demographyChildrenLocalRepository.deleteOption();
    await demographyGenderLocalRepository.deleteOption();
    await demographyIncomeLocalRepository.deleteOption();
    await demographyMaritalLocalRepository.deleteOption();
    await demographyOccupationLocalRepository.deleteOption();
    await demographyOutcomeLocalRepository.deleteOption();
    await demographyRegionLocalRepository.deleteOption();
    await demographyReligionLocalRepository.deleteOption();
  }

  @override
  Widget build(BuildContext context) {
    String formatterRupiahPrice = formatCurrency(totalPrice.toDouble());

    return Scaffold(
      appBar: PlainAppBar(
        onPressed: () {
          deleteAllOptiondValue();
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const HomePage()));
        },
        leadingIcon: Icons.close,
        iconColor: AppColors.black,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: CustomPadding.px2,
            child: SingleChildScrollView(
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
                  containerResponden(),
                  CustomDividers.verySmallDivider(),
                  containerPertanyaan(),
                  CustomDividers.verySmallDivider(),
                  containerDemography(),
                  CustomDividers.verySmallDivider(),
                  containerReportTime(),
                  CustomDividers.verySmallDivider(),
                  containerScreener(),
                ],
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
                              print('Option : $respondentScope');
                              print('Option : $questionScope');
                              print('Option : $reportTimeScope');
                              print('Option : $screenerOptionValue');
                              print(
                                  'Dmography Occupation : $demographyOccupationScopeValue');
                              print(
                                  'Dmography Region : $demographyRegionScopeValue');
                              print(
                                  'Dmography Religion : $demographyReligionScopeValue');
                              print(
                                  'Demography Age : ${demographyAgeScopeValue.first} - ${demographyAgeScopeValue.last}');
                              print(
                                  'Demography Children : ${demographyChildrenScopeValue.first} - ${demographyChildrenScopeValue.last}');
                              print(
                                  'Demography Marital : ${demographyMaritalScopeValue.first} - ${demographyMaritalScopeValue.last}');
                              print(
                                  'Demography Income : ${demographyIncomeScopeValue.first} - ${demographyIncomeScopeValue.last}');
                              print(
                                  'Demography Outcome : ${demographyOutcomeScopeValue.first} - ${demographyOutcomeScopeValue.last}');

                              // showProceedToPaymentDialog(context);
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

  Widget containerResponden() {
    return Column(
      children: [
        LabelInput(
          labelText: 'Responden',
          labelStyle: TextStyles.medium(color: AppColors.secondary),
        ),
        CustomDividers.verySmallDivider(),
        GestureDetector(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      RespondentOption(designAction: widget.designAction))),
          child: Container(
            height: 60,
            width: double.infinity,
            padding: CustomPadding.p1,
            decoration: BoxDecoration(
                border: Border.all(color: AppColors.secondary, width: 1.5),
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
      ],
    );
  }

  Widget containerPertanyaan() {
    return Column(
      children: [
        LabelInput(
          labelText: 'Pertanyaan',
          labelStyle: TextStyles.medium(color: AppColors.secondary),
        ),
        CustomDividers.verySmallDivider(),
        GestureDetector(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      QuestionOption(designAction: widget.designAction))),
          child: Container(
            height: 60,
            width: double.infinity,
            padding: CustomPadding.p1,
            decoration: BoxDecoration(
                border: Border.all(color: AppColors.secondary, width: 1.5),
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
      ],
    );
  }

  Widget containerDemography() {
    return Column(
      children: [
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
                border: Border.all(color: AppColors.secondary, width: 1.5),
                borderRadius: BorderRadius.circular(50)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: CustomPadding.px1,
                  child: Text(
                    valueTextDemography,
                    style: TextStyles.large(
                        color: AppColors.black, fontWeight: FontWeight.bold),
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
      ],
    );
  }

  Widget containerReportTime() {
    return Column(
      children: [
        LabelInput(
          labelText: 'Kecepatan Report',
          labelStyle: TextStyles.medium(color: AppColors.secondary),
        ),
        CustomDividers.verySmallDivider(),
        GestureDetector(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ReportTimeOption(
                        designAction: widget.designAction,
                      ))),
          child: Container(
            height: 60,
            width: double.infinity,
            padding: CustomPadding.p1,
            decoration: BoxDecoration(
                border: Border.all(color: AppColors.secondary, width: 1.5),
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
      ],
    );
  }

  Widget containerScreener() {
    return Column(
      children: [
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
