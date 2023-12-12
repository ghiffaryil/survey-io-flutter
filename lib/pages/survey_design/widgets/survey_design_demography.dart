import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:survey_io/common/components/elevated_button.dart';
import 'package:survey_io/common/constants/function/get_split_strip_value.dart';
import 'package:survey_io/datasources/survey_design/repository/localRepositoryPrice.dart';
import 'package:survey_io/datasources/survey_design/repository/localRepositoryQuestion.dart';
import 'package:survey_io/datasources/survey_design/repository/localRepositoryReportTime.dart';
import 'package:survey_io/datasources/survey_design/repository/localRepositoryRespondent.dart';
import 'package:survey_io/datasources/survey_design/repository/localRepositoryScreener.dart';
import 'package:survey_io/pages/survey_design/survey_design.dart';
import 'package:survey_io/common/components/input_field_text.dart';
import 'package:survey_io/common/components/label.dart';
import 'package:survey_io/common/constants/padding.dart';
import 'package:survey_io/common/components/appbar_plain.dart';
import 'package:survey_io/common/components/divider.dart';
import 'package:survey_io/common/constants/colors.dart';
import 'package:survey_io/bloc/survey_design/survey_design_is_calculate/survey_design_is_calculate_bloc.dart';
import 'package:survey_io/models/survey_design/is_calculate/survey_design_is_calculate_request_model.dart';

import 'package:survey_io/datasources/survey_design/repository/localRepositoryAge.dart';
import 'package:survey_io/datasources/survey_design/repository/localRepositoryChildren.dart';
import 'package:survey_io/datasources/survey_design/repository/localRepositoryGender.dart';
import 'package:survey_io/datasources/survey_design/repository/localRepositoryIncome.dart';
import 'package:survey_io/datasources/survey_design/repository/localRepositoryOccupation.dart';
import 'package:survey_io/datasources/survey_design/repository/localRepositoryOutcome.dart';
import 'package:survey_io/datasources/survey_design/repository/localRepositoryRegion.dart';
import 'package:survey_io/datasources/survey_design/repository/localRepositoryReligion.dart';
import 'package:survey_io/datasources/survey_design/repository/localRepositoryMarital.dart';

import 'modal_option_age.dart';
import 'modal_option_gender.dart';
import 'modal_option_income.dart';
import 'modal_option_marital.dart';
import 'modal_option_outcome.dart';
import 'modal_option_region.dart';
import 'modal_option_religion.dart';
import 'modal_option_occupation.dart';
import 'modal_option_children.dart';

class DemographyOption extends StatefulWidget {
  final String designAction;

  const DemographyOption({super.key, required this.designAction});

  @override
  State<DemographyOption> createState() => _DemographyOptionState();
}

class _DemographyOptionState extends State<DemographyOption> {
  // Text Editing
  TextEditingController inputDemographyAge = TextEditingController();
  TextEditingController inputDemographyGender = TextEditingController();
  TextEditingController inputDemographyReligion = TextEditingController();
  TextEditingController inputDemographyOccupation = TextEditingController();
  TextEditingController inputDemographyMarital = TextEditingController();
  TextEditingController inputDemographyChildren = TextEditingController();
  TextEditingController inputDemographyRegion = TextEditingController();
  TextEditingController inputDemographyIncome = TextEditingController();
  TextEditingController inputDemographyOutcome = TextEditingController();

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
    loadData();
  }

  void loadData() {
    getRespondentOption();
    getQuestionOption();
    getReportTimeOption();
    getScreenerOption();
    getAgeOption();
    getGenderOption();
    getReligionOption();
    getOccupationOption();
    getMaritalOption();
    getChildrenOption();
    getRegionOption();
    getIncomeOption();
    getOutcomeOption();
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
  void getAgeOption() async {
    final savedData = await ageRepository.getOption();
    if (savedData != null) {
      setState(() {
        selectedIdAge = (savedData['id'] as List<dynamic>).cast<int>();
        selectedScopeAge = (savedData['scope'] as List<dynamic>).cast<String>();
        inputDemographyAge.text =
            selectedScopeAge.isEmpty ? "Semua" : selectedScopeAge.join(', ');
      });
      print('Load Age Repository : $selectedScopeAge');
    } else {
      print('Age is Empty');
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
      print('selectedScopeAge' + selectedScopeAge.first);

      if (getFirstValue(selectedScopeAge.first) == 'Semua') {
        firstAgeValue = 1;
      } else if (selectedScopeAge.first == '<20') {
        firstAgeValue = 1;
      } else {
        firstAgeValue = int.tryParse(getFirstValue(selectedScopeAge.first))!;
      }

      print('firstAgeValue' + firstAgeValue.toString());

      if (getLastValue(selectedScopeAge.last) == 'Semua') {
        lastAgeValue = 99;
      } else if (selectedScopeAge.last == '<20') {
        lastAgeValue = 99;
      } else {
        lastAgeValue = int.tryParse(getLastValue(selectedScopeAge.last))!;
      }
    });
  }

  // GET Gender OPTION
  void getGenderOption() async {
    final savedData = await genderRepository.getOption();
    if (savedData != null) {
      setState(() {
        selectedIdGender = savedData['id'];
        selectedScopeGender = savedData['scope'];
        if (selectedScopeGender.isEmpty) {
          inputDemographyGender.text = "Semua";
        } else {
          inputDemographyGender.text = selectedScopeGender;
        }
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
        if (selectedScopeOccupation.isEmpty) {
          inputDemographyOccupation.text = "Semua";
        } else {
          inputDemographyOccupation.text = selectedScopeOccupation;
        }
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
        inputDemographyMarital.text = selectedScopeMarital.isEmpty
            ? "Semua"
            : selectedScopeMarital.join(', ');
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
        inputDemographyChildren.text = selectedScopeChildren.isEmpty
            ? "Semua"
            : selectedScopeChildren.join(', ');
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
        if (selectedScopeRegion.isEmpty) {
          inputDemographyRegion.text = "Semua";
        } else {
          inputDemographyRegion.text = selectedScopeRegion;
        }
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
        if (selectedScopeReligion.isEmpty) {
          inputDemographyReligion.text = "Semua";
        } else {
          inputDemographyReligion.text = selectedScopeReligion;
        }
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
        inputDemographyIncome.text = selectedScopeIncome.isEmpty
            ? "Semua"
            : selectedScopeIncome.join(', ');
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
        inputDemographyOutcome.text = selectedScopeOutcome.isEmpty
            ? "Semua"
            : selectedScopeOutcome.join(', ');
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PlainAppBar(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const SurveyDesign(
                          designAction: 'Create',
                        )));
          },
          leadingIcon: Icons.close,
          iconColor: AppColors.black),
      body: Column(
        children: [
          Container(
            padding: CustomPadding.px2,
            child: const LabelHeading(
                labelText: 'Atur Demografi', labelColor: AppColors.secondary),
          ),
          Expanded(
              child: Container(
            padding: CustomPadding.p2,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CustomDividers.verySmallDivider(),
                  GestureDetector(
                    onTap: () {
                      _showModalAge(context);
                    },
                    child: TextInputField(
                      controller: inputDemographyAge,
                      editable: false,
                      hintText: 'Semua',
                      labelText: 'Usia',
                      keyboardType: TextInputType.text,
                      suffixIcon: Icon(
                        selectedScopeAge.isEmpty ? Icons.add : Icons.edit,
                        color: AppColors.info,
                      ),
                    ),
                  ),
                  CustomDividers.verySmallDivider(),
                  GestureDetector(
                    onTap: () {
                      _showModalGender(context);
                    },
                    child: TextInputField(
                      controller: inputDemographyGender,
                      editable: false,
                      hintText: 'Semua',
                      labelText: 'Jenis Kelamin',
                      keyboardType: TextInputType.text,
                      suffixIcon: Icon(
                        selectedScopeGender == '' ? Icons.add : Icons.edit,
                        color: AppColors.info,
                      ),
                    ),
                  ),
                  CustomDividers.verySmallDivider(),
                  GestureDetector(
                    onTap: () {
                      _showModalReligion(context);
                    },
                    child: TextInputField(
                      controller: inputDemographyReligion,
                      editable: false,
                      hintText: 'Semua',
                      labelText: 'Agama',
                      keyboardType: TextInputType.text,
                      suffixIcon: Icon(
                        selectedScopeReligion == '' ? Icons.add : Icons.edit,
                        color: AppColors.info,
                      ),
                    ),
                  ),
                  CustomDividers.verySmallDivider(),
                  GestureDetector(
                    onTap: () {
                      _showModalOccupation(context);
                    },
                    child: TextInputField(
                      controller: inputDemographyOccupation,
                      editable: false,
                      hintText: 'Semua',
                      labelText: 'Status Pekerjaan',
                      keyboardType: TextInputType.text,
                      suffixIcon: Icon(
                        selectedScopeOccupation == '' ? Icons.add : Icons.edit,
                        color: AppColors.info,
                      ),
                    ),
                  ),
                  CustomDividers.verySmallDivider(),
                  GestureDetector(
                    onTap: () {
                      _showModalMarital(context);
                    },
                    child: TextInputField(
                      controller: inputDemographyMarital,
                      editable: false,
                      hintText: 'Semua',
                      labelText: 'Status Pernikahan',
                      keyboardType: TextInputType.text,
                      suffixIcon: Icon(
                        selectedScopeMarital.isEmpty ? Icons.add : Icons.edit,
                        color: AppColors.info,
                      ),
                    ),
                  ),
                  CustomDividers.verySmallDivider(),
                  GestureDetector(
                    onTap: () {
                      _showModalChildren(context);
                    },
                    child: TextInputField(
                      controller: inputDemographyChildren,
                      editable: false,
                      hintText: 'Semua',
                      labelText: 'Jumlah Anak',
                      keyboardType: TextInputType.text,
                      suffixIcon: Icon(
                        selectedScopeChildren.isEmpty ? Icons.add : Icons.edit,
                        color: AppColors.info,
                      ),
                    ),
                  ),
                  CustomDividers.verySmallDivider(),
                  GestureDetector(
                    onTap: () {
                      _showModalRegion(context);
                    },
                    child: TextInputField(
                      controller: inputDemographyRegion,
                      editable: false,
                      hintText: 'Semua',
                      labelText: 'Wilayah',
                      keyboardType: TextInputType.text,
                      suffixIcon: Icon(
                        selectedScopeRegion == '' ? Icons.add : Icons.edit,
                        color: AppColors.info,
                      ),
                    ),
                  ),
                  CustomDividers.verySmallDivider(),
                  GestureDetector(
                    onTap: () {
                      _showModalIncome(context);
                    },
                    child: TextInputField(
                      controller: inputDemographyIncome,
                      editable: false,
                      hintText: 'Semua',
                      labelText: 'Pendapatan per Bulan',
                      keyboardType: TextInputType.text,
                      suffixIcon: Icon(
                        selectedScopeIncome.isEmpty ? Icons.add : Icons.edit,
                        color: AppColors.info,
                      ),
                    ),
                  ),
                  CustomDividers.verySmallDivider(),
                  GestureDetector(
                    onTap: () {
                      _showModalOutcome(context);
                    },
                    child: TextInputField(
                      controller: inputDemographyOutcome,
                      editable: false,
                      hintText: 'Semua',
                      labelText: 'Pengeluaran per Bulan',
                      keyboardType: TextInputType.text,
                      suffixIcon: Icon(
                        selectedScopeOutcome.isEmpty ? Icons.add : Icons.edit,
                        color: AppColors.info,
                      ),
                    ),
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
                                          builder: (context) => SurveyDesign(
                                              designAction:
                                                  widget.designAction)));
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
                    ),
                  ),
                ],
              ),
            ),
          ))
        ],
      ),
    );
  }

  void _showModalAge(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      isScrollControlled: true,
      builder: (BuildContext context) {
        return ModalOptionAge(
          onUpdate: () {
            loadData();
          },
        );
      },
    );
  }

  void _showModalGender(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      isScrollControlled: true,
      builder: (BuildContext context) {
        return ModalOptionGender(
          onUpdate: () {
            loadData();
          },
        );
      },
    );
  }

  void _showModalReligion(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      isScrollControlled: true,
      builder: (BuildContext context) {
        return ModalOptionReligion(
          onUpdate: () {
            loadData();
          },
        );
      },
    );
  }

  void _showModalOccupation(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      isScrollControlled: true,
      builder: (BuildContext context) {
        return ModalOptionOccupation(
          onUpdate: () {
            loadData();
          },
        );
      },
    );
  }

  void _showModalMarital(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      isScrollControlled: true,
      builder: (BuildContext context) {
        return ModalOptionMarital(
          onUpdate: () {
            loadData();
          },
        );
      },
    );
  }

  void _showModalChildren(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      isScrollControlled: true,
      builder: (BuildContext context) {
        return ModalOptionChildren(
          onUpdate: () {
            loadData();
          },
        );
      },
    );
  }

  void _showModalRegion(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      isScrollControlled: true,
      builder: (BuildContext context) {
        return ModalOptionRegion(
          onUpdate: () {
            loadData();
          },
        );
      },
    );
  }

  void _showModalIncome(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      isScrollControlled: true,
      builder: (BuildContext context) {
        return ModalOptionIncome(
          onUpdate: () {
            loadData();
          },
        );
      },
    );
  }

  void _showModalOutcome(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      isScrollControlled: true,
      builder: (BuildContext context) {
        return ModalOptionOutcome(
          onUpdate: () {
            loadData();
          },
        );
      },
    );
  }
}
