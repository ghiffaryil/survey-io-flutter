// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:survey_io/common/constants/function/get_split_strip_value.dart';
import 'package:survey_io/datasources/survey_design/repository/localRepositoryQuestion.dart';
import 'package:survey_io/datasources/survey_design/repository/localRepositoryReportTime.dart';
import 'package:survey_io/datasources/survey_design/repository/localRepositoryScreener.dart';
import 'package:survey_io/models/survey_design/is_calculate/survey_design_is_calculate_request_model.dart';
import 'package:survey_io/pages/survey_design/survey_design.dart';
import 'package:survey_io/common/components/elevated_button.dart';
import 'package:survey_io/common/components/appbar_plain.dart';
import 'package:survey_io/common/components/divider.dart';
import 'package:survey_io/common/constants/padding.dart';
import 'package:survey_io/common/components/label.dart';
import 'package:survey_io/common/constants/colors.dart';
import 'package:survey_io/common/constants/styles.dart';

import 'package:survey_io/datasources/survey_design/repository/localRepositoryPrice.dart';
import 'package:survey_io/bloc/survey_design/survey_design_is_calculate/survey_design_is_calculate_bloc.dart';
import 'package:survey_io/bloc/survey_design/survey_design_option/survey_design_list_respondent/survey_design_list_respondent_bloc.dart';
import 'package:survey_io/datasources/survey_design/repository/localRepositoryRespondent.dart';
import 'package:survey_io/datasources/survey_design/repository/localRepositoryAge.dart';
import 'package:survey_io/datasources/survey_design/repository/localRepositoryChildren.dart';
import 'package:survey_io/datasources/survey_design/repository/localRepositoryGender.dart';
import 'package:survey_io/datasources/survey_design/repository/localRepositoryIncome.dart';
import 'package:survey_io/datasources/survey_design/repository/localRepositoryMarital.dart';
import 'package:survey_io/datasources/survey_design/repository/localRepositoryOccupation.dart';
import 'package:survey_io/datasources/survey_design/repository/localRepositoryOutcome.dart';
import 'package:survey_io/datasources/survey_design/repository/localRepositoryRegion.dart';
import 'package:survey_io/datasources/survey_design/repository/localRepositoryReligion.dart';

class RespondentOption extends StatefulWidget {
  final String designAction;

  const RespondentOption({super.key, required this.designAction});

  @override
  State<RespondentOption> createState() => _RespondentOptionState();
}

class _RespondentOptionState extends State<RespondentOption> {
  // Initialize respondentId and respondentScope variable type
  int? selectedId;
  var selectedScope;

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
  int respondentValue = 0;
  int questionId = 0;
  int totalQuestionValue = 0;
  int reportTimeId = 0;
  int reportTimeValue = 0;
  int reportTimePrice = 0;
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

  @override
  void initState() {
    super.initState();
    getOption();
    loadData();
  }

  // Load Data
  Future loadData() async {
    context.read<SurveyDesignListRespondentBloc>().add(
        const SurveyDesignListRespondentEvent.getSurveyDesignListRespondent());
    getRespondentOption();
    getQuestionOption();
    getReportTimeOption();
    getScreenerOption();
    getAgeOption();
    getGenderOption();
    getOccupationOption();
    getMaritalOption();
    getChildrenOption();
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

    // SET FIRST & LAST VALUE OF AGE
    setState(() {
      if (getFirstValue(selectedScopeAge.first) == 'Semua') {
        firstAgeValue = 1;
      }  else if (selectedScopeAge.first == '<20') {
        firstAgeValue = 1;
      } else {
        firstAgeValue = int.tryParse(getFirstValue(selectedScopeAge.first))!;
      }

      if (getLastValue(selectedScopeAge.last) == 'Semua') {
        lastAgeValue = 99;
      } else if (selectedScopeAge.last == '<20') {
        lastAgeValue = 99;
      }  else {
        lastAgeValue = int.tryParse(getLastValue(selectedScopeAge.last))!;
      }
    });

    // print('Load Age Repository : $selectedScopeAge');
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
      firstIncomeValue = getFirstValue(selectedScopeIncome.first);
      lastIncomeValue = getLastValue(selectedScopeIncome.last);
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
      firstOutcomeValue = getFirstValue(selectedScopeOutcome.first);
      lastOutcomeValue = getLastValue(selectedScopeOutcome.last);
    });
    // print('Load Outcome Repository : $selectedScopeOutcome');
  }

  // Get Selected Choice
  Future getOption() async {
    final getOptionValue = await respondentRepository.getOption();

    if (getOptionValue != null) {
      if (getOptionValue['id'] != null || getOptionValue['scope'] != null) {
        setState(() {
          selectedId = getOptionValue['id'];
          selectedScope = getOptionValue['scope'];
          respondentValue = getOptionValue['scope'];
        });
      } else {
        setState(() {
          selectedId = 0;
          selectedScope = 'Pilih Jumlah Responden';
          respondentValue = 0;
        });
      }
    }
  }

  // Save Choice
  Future<void> setOption() async {
    var setOptionValue = {
      'id': selectedId,
      'scope': selectedScope,
    };
    String setOptionValueJson = jsonEncode(setOptionValue);

    try {
      await respondentRepository.setOption(setOptionValueJson);
      print('Set value to JSON: $setOptionValueJson');
      getRespondentOption();
    } catch (e) {
      print('Error saving respondentOption: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PlainAppBar(
          onPressed: () {
            Navigator.pop(context);
          },
          leadingIcon: Icons.close,
          iconColor: AppColors.black),
      body: Column(
        children: [
          Container(
            padding: CustomPadding.p2,
            child: LabelInput(
                labelText: 'Jumlah Responden', labelStyle: TextStyles.h3()),
          ),

          // LOAD DATA RESPONDENT
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  BlocBuilder<SurveyDesignListRespondentBloc,
                      SurveyDesignListRespondentState>(
                    builder: (context, state) {
                      return state.maybeWhen(
                        orElse: () {
                          return Container();
                        },
                        loading: () {
                          return Container();
                        },
                        error: (message) {
                          return Container(
                            alignment: Alignment.center,
                            child: Text(message),
                          );
                        },
                        loaded: (data) {
                          return ListView.separated(
                            shrinkWrap: true,
                            itemCount: data.length,
                            separatorBuilder: ((context, index) {
                              return const Divider(
                                thickness: 0.3,
                              );
                            }),
                            itemBuilder: (context, index) {
                              var dataRespondent = data[index];

                              return ListTile(
                                dense: true,
                                title: Text(
                                  '${dataRespondent.scope}',
                                  style: TextStyles.medium(),
                                ),
                                leading: Radio(
                                  activeColor: AppColors.primary,
                                  value: dataRespondent.id,
                                  groupValue: selectedId,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedId = value!;
                                      selectedScope = dataRespondent.scope;
                                      setOption();
                                    });
                                  },
                                ),
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
                  CustomDividers.smallDivider(),
                  BlocListener<SurveyDesignIsCalculateBloc,
                      SurveyDesignIsCalculateState>(
                    listener: (context, state) {
                      state.maybeWhen(
                        orElse: () {},
                        loaded: (data) {
                          final setPrice = {
                            'point': data.point,
                            'price': data.price,
                          };
                          final jsonData = jsonEncode(setPrice);
                          surveyDesignPriceRepository.setOption(jsonData);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SurveyDesign(
                                      designAction: widget.designAction)));
                        },
                      );
                    },
                    child: Container(
                        padding: CustomPadding.pdefault,
                        child: BlocBuilder<SurveyDesignIsCalculateBloc,
                            SurveyDesignIsCalculateState>(
                          builder: (context, state) {
                            return state.maybeWhen(
                              orElse: () {
                                return ButtonFilled.primary(
                                  text: 'Ok',
                                  onPressed: () {
                                    if (respondentValue > 0 &&
                                        totalQuestionValue > 0 &&
                                        reportTimeValue > 0) {
                                      final requestModel = SurveyDesignIsCalculateRequestModel(
                                          deviceId: 'xx001',
                                          type: 'Publik',
                                          respondent: respondentValue,
                                          totalQuestion: totalQuestionValue,
                                          reportTime: reportTimeValue,
                                          totalScreener: totalScreener,
                                          ageStart: firstAgeValue,
                                          ageEnd: lastAgeValue,
                                          children: selectedScopeChildren
                                                      .first ==
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
                                          religion:
                                              selectedScopeReligion == 'Semua'
                                                  ? null
                                                  : selectedScopeReligion,
                                          monthlyIncome: firstIncomeValue ==
                                                  'Semua'
                                              ? null
                                              : '$firstIncomeValue - $lastIncomeValue',
                                          monthlyOutcome: firstOutcomeValue ==
                                                  'Semua'
                                              ? null
                                              : '$firstOutcomeValue - $lastOutcomeValue',
                                          isCalculate: 1);

                                      context
                                          .read<SurveyDesignIsCalculateBloc>()
                                          .add(SurveyDesignIsCalculateEvent
                                              .isCalculate(requestModel));
                                    } else {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  SurveyDesign(
                                                      designAction: widget
                                                          .designAction)));
                                    }
                                  },
                                );
                              },
                              loading: () {
                                return ButtonFilled.primary(
                                  text: '',
                                  onPressed: () {},
                                  loading: true,
                                  textColor: Colors.white,
                                );
                              },
                            );
                          },
                        )),
                  ),
                  Container(
                    padding: CustomPadding.py2,
                    child: Text(
                      'Lebih dari 1.000 responden?',
                      style: TextStyles.h5(
                          color: AppColors.info,
                          textDecoration: TextDecoration.underline),
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
}
