import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:survey_io/bloc/profile/get_profile/profile_bloc.dart';
import 'package:survey_io/datasources/survey_design/repository/localRepositoryPrice.dart';
import 'package:survey_io/models/survey_design/is_calculate/survey_design_is_calculate_request_model.dart';
import 'package:survey_io/bloc/survey_design/survey_design_is_calculate/survey_design_is_calculate_bloc.dart';
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
import 'package:survey_io/pages/payment/payment_method.dart';
import 'package:survey_io/common/extension/helper/currency_helper.dart';
import 'package:survey_io/pages/survey_design/survey_design_list.dart';
import 'package:survey_io/pages/survey_design/widgets/question_option.dart';
import 'package:survey_io/pages/survey_design/widgets/report_time_option.dart';
import 'package:survey_io/pages/survey_design/widgets/respondent_option.dart';
import 'package:survey_io/pages/survey_design/survey_design_demography.dart';
// import 'package:survey_io/pages/survey_design/survey_design_list.dart';

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

class SurveyDesign extends StatefulWidget {
  final String designAction;

  const SurveyDesign({super.key, required this.designAction});

  @override
  State<SurveyDesign> createState() => _SurveyDesignState();
}

class _SurveyDesignState extends State<SurveyDesign> {
  int totalPrice = 0;

  int respondentId = 0;
  dynamic respondentScope;
  int respondentValue = 0;

  int questionId = 0;
  dynamic totalQuestionScope;
  int totalQuestionValue = 0;

  int reportTimeId = 0;
  dynamic reportTimeScope;
  int reportTimeValue = 0;
  int reportTimePrice = 0;

  String screenerOptionValue = '';
  int totalScreener = 0;

  String valueTextDemography = 'Default : Semua Demografi';

  final respondentRepository = LocalRepositoryRespondent();
  final questionRepository = LocalRepositoryQuestion();
  final reportTimeRepository = LocalRepositoryReportTime();
  final screenerRepository = LocalRepositoryScreener();
  final ageRepository = LocalRepositoryDemographyAge();
  final childrenRepository = LocalRepositoryDemographyChildren();
  final genderRepository = LocalRepositoryDemographyGender();
  final maritalRepository = LocalRepositoryDemographyMarital();
  final occupationRepository = LocalRepositoryDemographyOccupation();
  final regionRepository = LocalRepositoryDemographyRegion();
  final religionRepository = LocalRepositoryDemographyReligion();
  final incomeRepository = LocalRepositoryDemographyIncome();
  final outcomeRepository = LocalRepositoryDemographyOutcome();
  final surveyDesignPriceRepository = LocalRepositorySurveyDesignPrice();

  // Variabel
  List<String> selectedScopeAge = [];
  List<int> selectedIdAge = [];

  int selectedIdGender = 0;
  String selectedScopeGender = '';

  int selectedIdReligion = 0;
  String selectedScopeReligion = '';

  int selectedIdOccupation = 0;
  String selectedScopeOccupation = '';

  List<String> selectedScopeMarital = [];
  List<int> selectedIdMarital = [];

  List<String> selectedScopeChildren = [];
  List<int> selectedIdChildren = [];

  int selectedIdRegion = 0;
  String selectedScopeRegion = '';

  List<String> selectedScopeIncome = [];
  List<int> selectedIdIncome = [];

  List<String> selectedScopeOutcome = [];
  List<int> selectedIdOutcome = [];

  int firstAgeValue = 0;
  int lastAgeValue = 0;
  String firstIncomeValue = '';
  String lastIncomeValue = '';
  String firstOutcomeValue = '';
  String lastOutcomeValue = '';

  String formatterRupiahPrice = '';

  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(const ProfileEvent.getProfile());
    loadData();
  }

  // Load All Data
  loadData() {
    getRespondentOption();
    getQuestionOption();
    getReportTimeOption();
    getScreenerOption();
    getAgeOption();
    getGenderOption();
    getRegionOption();
    getReligionOption();
    getOccupationOption();
    getMaritalOption();
    getChildrenOption();
    getIncomeOption();
    getOutcomeOption();
    getSurveyDesignPrice();
  }

  void getSurveyDesignPrice() async {
    final getOptionValue = await surveyDesignPriceRepository.getOption();

    if (getOptionValue != null) {
      if (getOptionValue['price'] == null) {
        setState(() {
          totalPrice = getOptionValue['price'];
        });
      } else {
        setState(() {
          totalPrice = getOptionValue['price'];
        });
      }
    } else {
      setState(() {
        totalPrice = 0;
      });
    }
  }

  // GET RESPONDENT OPTION
  Future getRespondentOption() async {
    final getOptionValue = await respondentRepository.getOption();

    if (getOptionValue != null) {
      if (getOptionValue['id'] == null || getOptionValue['scope'] == null) {
        setState(() {
          respondentId = 0;
          respondentScope = 'Pilih Jumlah Responden';
          respondentValue = 0;
        });
      } else {
        setState(() {
          respondentId = getOptionValue['id'];
          respondentScope = getOptionValue['scope'];
          respondentValue = getOptionValue['scope'];
        });
      }
    } else {
      setState(() {
        respondentId = 0;
        respondentScope = 'Pilih Jumlah Responden';
        respondentValue = 0;
      });
    }
    print('Load Respondent Repository : $respondentScope');
  }

  // GET QUESTION OPTION
  Future getQuestionOption() async {
    final getOptionValue = await questionRepository.getOption();

    if (getOptionValue != null) {
      if (getOptionValue['id'] == null || getOptionValue['scope'] == null) {
        setState(() {
          questionId = 0;
          totalQuestionScope = 'Pilih Jumlah Pertanyaan';
          totalQuestionValue = 0;
        });
      } else {
        setState(() {
          questionId = getOptionValue['id'];
          totalQuestionScope = getOptionValue['scope'];
          totalQuestionValue = getOptionValue['scope'];
        });
      }
    } else {
      setState(() {
        questionId = 0;
        totalQuestionScope = 'Pilih Jumlah Pertanyaan';
      });
    }
    print('Load Question Repository : $totalQuestionScope');
  }

  // GET REPORT TIME OPTION
  Future getReportTimeOption() async {
    final getOptionValue = await reportTimeRepository.getOption();

    if (getOptionValue != null) {
      if (getOptionValue['id'] == null || getOptionValue['scope'] == null) {
        setState(() {
          reportTimeId = 0;
          reportTimeScope = 'Pilih Durasi Report';
          reportTimeValue = 0;
        });
      } else {
        setState(() {
          reportTimeId = getOptionValue['id'];
          reportTimeScope = getOptionValue['scope'];
          reportTimeValue = int.parse(reportTimeScope);
        });
      }
    } else {
      setState(() {
        reportTimeId = 0;
        reportTimeScope = 'Pilih Durasi Report';
        reportTimeValue = 0;
      });
    }
    print('Load Report Time Repository : $reportTimeScope');
  }

  // GET SCREENER OPTION
  Future getScreenerOption() async {
    final getOptionValue = await screenerRepository.getOption();

    if (getOptionValue != null) {
      if (getOptionValue['scope'] == null) {
        setState(() {
          screenerOptionValue = '';
          totalScreener = 0;
        });
      } else {
        setState(() {
          screenerOptionValue = getOptionValue['scope'];
          totalScreener = 1;
        });
      }
    } else {
      setState(() {
        screenerOptionValue = '';
        totalScreener = 0;
      });
    }
  }

  // GET Age OPTION
  void getAgeOption() async {
    final savedData = await ageRepository.getOption();
    if (savedData != null) {
      setState(() {
        selectedIdAge = (savedData['id'] as List<dynamic>).cast<int>();
        selectedScopeAge = (savedData['scope'] as List<dynamic>).cast<String>();
      });
    } else {
      setState(() {
        selectedIdAge.add(0);
        selectedScopeAge.add('Semua');
      });
      final data = {
        'id': selectedIdAge,
        'scope': selectedScopeAge,
      };
      final jsonData = jsonEncode(data);
      await ageRepository.setOption(jsonData);
    }

    // SET FIRST & LAST VALUE OF AGE
    setState(() {
      if (getFirstValue(selectedScopeAge.first) == 'Semua') {
        firstAgeValue = 1;
      } else {
        firstAgeValue = int.tryParse(getFirstValue(selectedScopeAge.first))!;
      }

      if (getLastValue(selectedScopeAge.last) == 'Semua') {
        lastAgeValue = 99;
      } else {
        lastAgeValue = int.tryParse(getLastValue(selectedScopeAge.last))!;
      }
    });

    print('Load Age Repository : $selectedScopeAge');
  }

  // GET Gender OPTION
  void getGenderOption() async {
    final savedData = await genderRepository.getOption();
    if (savedData != null) {
      setState(() {
        selectedIdGender = savedData['id'];
        selectedScopeGender = savedData['scope'];
      });
    } else {
      setState(() {
        selectedIdGender = 0;
        selectedScopeGender = 'Semua';
      });
      final data = {
        'id': selectedIdGender,
        'scope': selectedScopeGender,
      };
      final jsonData = jsonEncode(data);
      await genderRepository.setOption(jsonData);
    }
    print('Load Gender Repository : $selectedScopeGender');
  }

  // GET Occupation OPTION
  void getOccupationOption() async {
    final savedData = await occupationRepository.getOption();
    if (savedData != null) {
      setState(() {
        selectedIdOccupation = savedData['id'];
        selectedScopeOccupation = savedData['scope'];
      });
    } else {
      setState(() {
        selectedIdOccupation = 0;
        selectedScopeOccupation = 'Semua';
      });
      final data = {
        'id': selectedIdOccupation,
        'scope': selectedScopeOccupation,
      };
      final jsonData = jsonEncode(data);
      await occupationRepository.setOption(jsonData);
    }
    print('Load Occupation Repository : $selectedScopeOccupation');
  }

  // GET Marital OPTION
  void getMaritalOption() async {
    final savedData = await maritalRepository.getOption();
    if (savedData != null) {
      setState(() {
        selectedIdMarital = (savedData['id'] as List<dynamic>).cast<int>();
        selectedScopeMarital =
            (savedData['scope'] as List<dynamic>).cast<String>();
      });
    } else {
      setState(() {
        selectedIdMarital.add(0);
        selectedScopeMarital.add('Semua');
      });
      final data = {
        'id': selectedIdMarital,
        'scope': selectedScopeMarital,
      };
      final jsonData = jsonEncode(data);
      await maritalRepository.setOption(jsonData);
    }
    print('Load Marital Repository : $selectedScopeMarital');
  }

  // GET Children OPTION
  void getChildrenOption() async {
    final savedData = await childrenRepository.getOption();
    if (savedData != null) {
      setState(() {
        selectedIdChildren = (savedData['id'] as List<dynamic>).cast<int>();
        selectedScopeChildren =
            (savedData['scope'] as List<dynamic>).cast<String>();
      });
    } else {
      setState(() {
        selectedIdChildren.add(0);
        selectedScopeChildren.add('Semua');
      });
      final data = {
        'id': selectedIdChildren,
        'scope': selectedScopeChildren,
      };
      final jsonData = jsonEncode(data);
      await childrenRepository.setOption(jsonData);
    }
    print('Load Children Repository : $selectedScopeChildren');
  }

  // GET Region OPTION
  void getRegionOption() async {
    final savedData = await regionRepository.getOption();
    if (savedData != null) {
      setState(() {
        selectedIdRegion = savedData['id'];
        selectedScopeRegion = savedData['scope'];
      });
    } else {
      setState(() {
        selectedIdRegion = 0;
        selectedScopeRegion = 'Semua';
      });
      final data = {
        'id': selectedIdRegion,
        'scope': selectedScopeRegion,
      };
      final jsonData = jsonEncode(data);
      await regionRepository.setOption(jsonData);
    }
    print('Load Region Repository : $selectedScopeRegion');
  }

  // GET Religion OPTION
  void getReligionOption() async {
    final savedData = await religionRepository.getOption();
    if (savedData != null) {
      setState(() {
        selectedIdReligion = savedData['id'];
        selectedScopeReligion = savedData['scope'];
      });
    } else {
      setState(() {
        selectedIdReligion = 0;
        selectedScopeReligion = 'Semua';
      });
      final data = {
        'id': selectedIdReligion,
        'scope': selectedScopeReligion,
      };
      final jsonData = jsonEncode(data);
      await religionRepository.setOption(jsonData);
    }
    print('Load Religion Repository : $selectedScopeReligion');
  }

  // GET Income OPTION
  void getIncomeOption() async {
    final savedData = await incomeRepository.getOption();
    if (savedData != null) {
      setState(() {
        selectedIdIncome = (savedData['id'] as List<dynamic>).cast<int>();
        selectedScopeIncome =
            (savedData['scope'] as List<dynamic>).cast<String>();
      });
    } else {
      setState(() {
        selectedIdIncome.add(0);
        selectedScopeIncome.add('Semua');
      });
      final data = {
        'id': selectedIdIncome,
        'scope': selectedScopeIncome,
      };
      final jsonData = jsonEncode(data);
      await incomeRepository.setOption(jsonData);
    }
    setState(() {
      firstIncomeValue = getFirstValue(selectedScopeIncome.first);
      lastIncomeValue = getLastValue(selectedScopeIncome.last);
    });
    print('Load Income Repository : $selectedScopeIncome');
  }

  // GET Outcome OPTION
  void getOutcomeOption() async {
    final savedData = await outcomeRepository.getOption();
    if (savedData != null) {
      setState(() {
        selectedIdOutcome = (savedData['id'] as List<dynamic>).cast<int>();
        selectedScopeOutcome =
            (savedData['scope'] as List<dynamic>).cast<String>();
      });
    } else {
      setState(() {
        selectedIdOutcome.add(0);
        selectedScopeOutcome.add('Semua');
      });
      final data = {
        'id': selectedIdOutcome,
        'scope': selectedScopeOutcome,
      };
      final jsonData = jsonEncode(data);
      await outcomeRepository.setOption(jsonData);
    }
    setState(() {
      firstOutcomeValue = getFirstValue(selectedScopeOutcome.first);
      lastOutcomeValue = getLastValue(selectedScopeOutcome.last);
    });
    print('Load Outcome Repository : $selectedScopeOutcome');
  }

  // SAVE OPTION
  Future<void> setOption() async {
    var setOption = {
      'scope': screenerOptionValue,
    };
    String setOptionJson = jsonEncode(setOption);
    await screenerRepository.setOption(setOptionJson);
  }

  // DELETE ALL OPTION
  Future<void> deleteAllOptiondValue() async {
    await respondentRepository.deleteOption();
    await questionRepository.deleteOption();
    await reportTimeRepository.deleteOption();
    await screenerRepository.deleteOption();

    await ageRepository.deleteOption();
    await childrenRepository.deleteOption();
    await occupationRepository.deleteOption();
    await maritalRepository.deleteOption();
    await genderRepository.deleteOption();
    await regionRepository.deleteOption();
    await religionRepository.deleteOption();
    await incomeRepository.deleteOption();
    await outcomeRepository.deleteOption();
    await surveyDesignPriceRepository.deleteOption();
  }

  // SPLIT
  String getFirstValue(String inputString) {
    List<String> values = inputString.split('-');
    values = values.map((value) => value.trim()).toList();
    String firstValue = values.isNotEmpty ? values.first : "";
    return firstValue;
  }

  String getLastValue(String inputString) {
    List<String> values = inputString.split('-');
    values = values.map((value) => value.trim()).toList();
    String lastValue = values.isNotEmpty ? values.last : "";
    return lastValue;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PlainAppBar(
        onPressed: () {
          deleteAllOptiondValue();
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const SurveyDesignListPage()));
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
          containerPrice(),
        ],
      ),
    );
  }

  Widget containerPrice() {
    formatterRupiahPrice = formatCurrency(totalPrice.toDouble());

    return Container(
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
          padding: const EdgeInsets.all(12),
          width: double.infinity,
          child: BlocListener<SurveyDesignIsCalculateBloc,
              SurveyDesignIsCalculateState>(
            listener: (context, state) {
              state.maybeWhen(
                orElse: () {},
                loaded: (data) async {
                  setState(() {
                    selectedIdReligion = 0;
                    selectedScopeReligion = 'Semua';
                  });
                  final jsonData = {
                    'point': data.point,
                    'price': data.price,
                  };
                  final jsonDataEncode = jsonEncode(jsonData);
                  await surveyDesignPriceRepository.setOption(jsonDataEncode);
                  loadData();
                },
              );
            },
            child: Row(
              children: [
                Expanded(
                    flex: 5,
                    child: Padding(
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
                    )),
                Expanded(
                  flex: 5,
                  child: BlocBuilder<SurveyDesignIsCalculateBloc,
                      SurveyDesignIsCalculateState>(
                    builder: (context, state) {
                      return state.maybeWhen(orElse: () {
                        return ButtonFilled.primary(
                          text: 'Bayar',
                          onPressed: () {
                            final requestModel = SurveyDesignIsCalculateRequestModel(
                                deviceId: 'xx001',
                                type: 'Publik',
                                respondent: respondentValue,
                                totalQuestion: totalQuestionValue,
                                reportTime: reportTimeValue,
                                totalScreener: totalScreener,
                                ageStart: firstAgeValue,
                                ageEnd: lastAgeValue,
                                children: selectedScopeChildren.first == 'Semua'
                                    ? null
                                    : '${selectedScopeChildren.first} - ${selectedScopeChildren.last}',
                                gender: selectedScopeGender == 'Semua'
                                    ? null
                                    : selectedScopeGender,
                                marital: selectedScopeMarital.first == 'Semua'
                                    ? null
                                    : '${selectedScopeMarital.first} - ${selectedScopeMarital.last}',
                                occupation: selectedScopeOccupation == 'Semua'
                                    ? null
                                    : selectedScopeOccupation,
                                region: selectedScopeRegion == 'Semua'
                                    ? null
                                    : selectedScopeRegion,
                                religion: selectedScopeReligion == 'Semua'
                                    ? null
                                    : selectedScopeReligion,
                                monthlyIncome: firstIncomeValue == 'Semua'
                                    ? null
                                    : '$firstIncomeValue - $lastIncomeValue',
                                monthlyOutcome: firstOutcomeValue == 'Semua'
                                    ? null
                                    : '$firstOutcomeValue - $lastOutcomeValue',
                                isCalculate: 1);

                            context.read<SurveyDesignIsCalculateBloc>().add(
                                SurveyDesignIsCalculateEvent.isCalculate(
                                    requestModel));
                          },
                          fontSize: 17,
                          minWidth: 20,
                          height: 50,
                        );
                      });
                    },
                  ),
                ),
              ],
            ),
          )),
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
                    '$totalQuestionScope',
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
