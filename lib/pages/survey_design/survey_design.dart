import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:survey_io/bloc/survey_design/survey_design_is_create/survey_design_is_create_bloc.dart';
import 'package:survey_io/datasources/survey_design/repository/localRepositoryPrice.dart';
import 'package:survey_io/common/constants/function/get_split_strip_value.dart';
import 'package:survey_io/common/components/input_field_radio.dart';
import 'package:survey_io/common/components/elevated_button.dart';
import 'package:survey_io/common/components/appbar_plain.dart';
import 'package:survey_io/common/components/divider.dart';
import 'package:survey_io/common/components/label.dart';
import 'package:survey_io/common/constants/colors.dart';
import 'package:survey_io/common/constants/images.dart';
import 'package:survey_io/common/constants/styles.dart';
import 'package:survey_io/common/constants/padding.dart';
import 'package:survey_io/common/constants/imageSize.dart';
import 'package:survey_io/models/survey_design/is_create/survey_design_is_create_request_model.dart';
import 'package:survey_io/pages/payment/payment_method.dart';
import 'package:survey_io/pages/survey_design/survey_design_list.dart';
import 'package:survey_io/common/extension/helper/currency_helper.dart';
import 'package:survey_io/pages/survey_design/widgets/question_option.dart';
import 'package:survey_io/pages/survey_design/widgets/report_time_option.dart';
import 'package:survey_io/pages/survey_design/widgets/respondent_option.dart';
import 'package:survey_io/pages/survey_design/widgets/survey_design_demography.dart';
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
  String valueTextDemography = 'Default : Semua Demografi';
  // Get shared Preferences Class
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

  int totalPrice = 0;
  int respondentId = 0;
  int totalRespondentValue = 0;

  int questionId = 0;
  int totalQuestionValue = 0;

  int reportTimeId = 0;
  int reportTimeValue = 0;

  int totalScreener = 0;

  int firstAgeValue = 0;
  int lastAgeValue = 0;

  int selectedIdGender = 0;
  int selectedIdReligion = 0;
  int selectedIdOccupation = 0;
  int selectedIdRegion = 0;

  dynamic respondentScope;
  dynamic totalQuestionScope;
  dynamic reportTimeScope;

  List<String> selectedScopeAge = [];
  List<int> selectedIdAge = [];
  List<String> selectedScopeMarital = [];
  List<int> selectedIdMarital = [];
  List<String> selectedScopeChildren = [];
  List<int> selectedIdChildren = [];
  List<String> selectedScopeIncome = [];
  List<int> selectedIdIncome = [];
  List<String> selectedScopeOutcome = [];
  List<int> selectedIdOutcome = [];

  String formatterRupiahPrice = '';
  String screenerOptionValue = '';
  String selectedScopeGender = '';
  String selectedScopeReligion = '';
  String selectedScopeOccupation = '';
  String selectedScopeRegion = '';
  String firstIncomeValue = '';
  String lastIncomeValue = '';
  String firstOutcomeValue = '';
  String lastOutcomeValue = '';

  bool isDemographyChecked = false;
  bool isDataInitialized = false;

  @override
  void initState() {
    super.initState();
    loadDataOption();
    initializeDataDemography();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Avoid calling initializeDataDemography here to prevent redundant calls
  }

  // Load All Data
  Future<void> initializeDataDemography() async {
    if (!isDataInitialized) {
      await loadDataDemography();
      // Call checkValueDemography only after all asynchronous operations are completed
      if (!isDemographyChecked) {
        checkValueDemography();
        setState(() {
          isDemographyChecked = true;
          isDataInitialized = true;
        });
      }

      // print('screenerOptionValue : $screenerOptionValue');

      // print('Respondent : $totalRespondentValue');
      // print('Question : $totalQuestionValue');
      // print('Screener : $totalScreener');

      // print('Gender : $selectedScopeGender');
      // print('Age : $selectedScopeAge');
      // print('Children : $selectedScopeChildren');
      // print('Marital : $selectedScopeMarital');
      // print('Occupation : $selectedScopeOccupation');

      // print('Region : $selectedScopeRegion');
      // print('Religion : $selectedScopeReligion');

      // print('Income : $selectedScopeIncome');
      // print('Outcome : $selectedScopeOutcome');
    }
  }

  // Load All Repository
  void loadDataOption() {
    getRespondentOption();
    getQuestionOption();
    getReportTimeOption();
    getScreenerOption();
  }

  Future<void> loadDataDemography() async {
    await getAgeOption();
    await getGenderOption();
    await getRegionOption();
    await getReligionOption();
    await getOccupationOption();
    await getMaritalOption();
    await getChildrenOption();
    await getIncomeOption();
    await getOutcomeOption();
    await getSurveyDesignPrice();
  }

  // GET RESPONDENT OPTION
  Future getRespondentOption() async {
    final getOptionValue = await respondentRepository.getOption();

    if (getOptionValue != null) {
      if (getOptionValue['id'] == null || getOptionValue['scope'] == null) {
        setState(() {
          respondentId = 0;
          respondentScope = 'Pilih Jumlah Responden';
          totalRespondentValue = 0;
        });
      } else {
        setState(() {
          respondentId = getOptionValue['id'];
          respondentScope = getOptionValue['scope'];
          totalRespondentValue = getOptionValue['scope'];
        });
      }
    } else {
      setState(() {
        respondentId = 0;
        respondentScope = 'Pilih Jumlah Responden';
        totalRespondentValue = 0;
      });
    }
    // print('Load Respondent Repository : $respondentScope');
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
    // print('Load Question Repository : $totalQuestionScope');
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
    // print('Load Report Time Repository : $reportTimeScope');
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
  // GET Income OPTION
  Future getAgeOption() async {
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

    setState(() {
      if (getFirstValue(selectedScopeAge.first) == 'Semua') {
        firstAgeValue = 1;
      } else if (selectedScopeAge.first == '<20') {
        firstAgeValue = 1;
      } else {
        firstAgeValue = int.tryParse(getFirstValue(selectedScopeAge.first))!;
      }

      if (getLastValue(selectedScopeAge.last) == 'Semua') {
        lastAgeValue = 99;
      } else if (selectedScopeAge.last == '<20') {
        lastAgeValue = 99;
      } else {
        lastAgeValue = int.tryParse(getLastValue(selectedScopeAge.last))!;
      }
    });

    // print('Load Income Repository : $selectedScopeIncome');
  }

  // GET Gender OPTION
  Future getGenderOption() async {
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
    // print('Load Gender Repository : $selectedScopeGender');
  }

  // GET Occupation OPTION
  Future getOccupationOption() async {
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
    // print('Load Occupation Repository : $selectedScopeOccupation');
  }

  // GET Marital OPTION
  Future getMaritalOption() async {
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
    // print('Load Marital Repository : $selectedScopeMarital');
  }

  // GET Children OPTION
  Future getChildrenOption() async {
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
    // print('Load Children Repository : $selectedScopeChildren');
  }

  // GET Region OPTION
  Future getRegionOption() async {
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
    // print('Load Region Repository : $selectedScopeRegion');
  }

  // GET Religion OPTION
  Future getReligionOption() async {
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
    // print('Load Religion Repository : $selectedScopeReligion');
  }

  // GET Income OPTION
  Future getIncomeOption() async {
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
      if (getFirstValue(selectedScopeIncome.first) == 'Semua') {
        firstIncomeValue = '0';
      } else if (selectedScopeIncome.first == '<1.000.000') {
        firstIncomeValue = '0';
      } else {
        firstIncomeValue = getFirstValue(selectedScopeIncome.first);
      }

      if (getLastValue(selectedScopeIncome.last) == 'Semua') {
        lastIncomeValue = '99.999.999';
      } else if (selectedScopeIncome.last == '>10.000.000') {
        lastIncomeValue = '99.999.999';
      } else {
        lastIncomeValue = getLastValue(selectedScopeIncome.last);
      }
    });
    // print('Load Income Repository : $selectedScopeIncome');
  }

  // GET Outcome OPTION
  Future getOutcomeOption() async {
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
      if (getFirstValue(selectedScopeOutcome.first) == 'Semua') {
        firstOutcomeValue = '0';
      } else if (selectedScopeOutcome.first == '<1.000.000') {
        firstOutcomeValue = '0';
      } else {
        firstOutcomeValue = getFirstValue(selectedScopeOutcome.first);
      }

      if (getLastValue(selectedScopeOutcome.last) == 'Semua') {
        lastOutcomeValue = '99.999.999';
      } else if (selectedScopeOutcome.last == '>10.000.000') {
        lastOutcomeValue = '99.999.999';
      } else {
        lastOutcomeValue = getLastValue(selectedScopeOutcome.last);
      }
    });
    // print('Load Outcome Repository : $selectedScopeOutcome');
  }

  // GET Price Value
  Future getSurveyDesignPrice() async {
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

  void checkValueDemography() {
    if (selectedScopeAge.first != 'Semua' ||
        selectedScopeChildren.first != 'Semua' ||
        selectedScopeMarital.first != 'Semua' ||
        selectedScopeIncome.first != 'Semua' ||
        selectedScopeOutcome.first != 'Semua' ||
        selectedScopeGender != 'Semua' ||
        selectedScopeOccupation != 'Semua' ||
        selectedScopeRegion != 'Semua' ||
        selectedScopeReligion != 'Semua') {
      setState(() {
        valueTextDemography = 'Custom';
      });
    } else {
      setState(() {
        valueTextDemography = 'Default : Semua Demography';
      });
    }

    // print(valueTextDemography);
  }

  // SAVE OPTION SCREENER
  Future setScreenerOption() async {
    var setOption = {
      'scope': screenerOptionValue,
    };
    String setOptionJson = jsonEncode(setOption);
    await screenerRepository.setOption(setOptionJson);
    print('Screener $screenerOptionValue');
  }

  // DELETE ALL OPTION
  Future<void> deleteAllOptiondValue() async {
    await respondentRepository.deleteOption();
    await questionRepository.deleteOption();
    await reportTimeRepository.deleteOption();
    await screenerRepository.deleteOption();
    await ageRepository.deleteOption();
    await occupationRepository.deleteOption();
    await childrenRepository.deleteOption();
    await maritalRepository.deleteOption();
    await genderRepository.deleteOption();
    await regionRepository.deleteOption();
    await religionRepository.deleteOption();
    await incomeRepository.deleteOption();
    await outcomeRepository.deleteOption();
    await surveyDesignPriceRepository.deleteOption();
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
          child:
              BlocListener<SurveyDesignIsCreateBloc, SurveyDesignIsCreateState>(
            listener: (context, state) {
              state.maybeWhen(
                orElse: () {},
                loaded: (data) {
                  print('createQuestionUrl $data');
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SurveyDesignListPage()));
                },
                error: (message) {
                  print('message $message');
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SurveyDesignListPage()));
                },
              );
            },
            child: Row(
              children: [
                Expanded(
                    flex: 5,
                    child: totalPrice == 0
                        ? Container(
                            padding: const EdgeInsets.all(6.0),
                          )
                        : Padding(
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
                  child: BlocBuilder<SurveyDesignIsCreateBloc,
                      SurveyDesignIsCreateState>(
                    builder: (context, state) {
                      return state.maybeWhen(
                        orElse: () {
                          if (totalRespondentValue == 0 ||
                              totalQuestionValue == 0 ||
                              reportTimeValue == 0 ||
                              totalPrice == 0 ||
                              screenerOptionValue == '') {
                            return ButtonFilled.light(
                              text: 'Bayar',
                              onPressed: () {},
                              fontSize: 17,
                              minWidth: 20,
                              height: 50,
                            );
                          } else {
                            return ButtonFilled.primary(
                              text: 'Bayar',
                              onPressed: () {
                                final requestModel = SurveyDesignIsCreateRequestModel(
                                    deviceId: 'xx001',
                                    type: 'Publik',
                                    respondent: totalRespondentValue,
                                    totalQuestion: totalQuestionValue,
                                    reportTime: reportTimeValue,
                                    totalScreener: totalScreener,
                                    ageStart: firstAgeValue,
                                    ageEnd: lastAgeValue,
                                    children: selectedScopeChildren.first ==
                                            'Semua'
                                        ? null
                                        : '${selectedScopeChildren.first} - ${selectedScopeChildren.last}',
                                    gender: selectedScopeGender == 'Semua'
                                        ? null
                                        : selectedScopeGender,
                                    marital: selectedScopeMarital.first ==
                                            'Semua'
                                        ? null
                                        : '${selectedScopeMarital.first} - ${selectedScopeMarital.last}',
                                    occupation:
                                        selectedScopeOccupation == 'Semua'
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
                                    isCalculate: 0);
                                context.read<SurveyDesignIsCreateBloc>().add(
                                    SurveyDesignIsCreateEvent.isCreate(
                                        requestModel));
                              },
                              fontSize: 17,
                              minWidth: 20,
                              height: 50,
                            );
                          }
                        },
                      );
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
                  builder: (context) => DemographyOption(
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
                      setScreenerOption();
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
                      setScreenerOption();
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
