import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:survey_io/common/constants/function/get_split_strip_value.dart';
import 'package:survey_io/datasources/survey_design/repository/localRepositoryScreener.dart';
import 'package:survey_io/datasources/survey_design/repository/localRepositoryReportTime.dart';
import 'package:survey_io/datasources/survey_design/repository/localRepositoryQuestion.dart';
import 'package:survey_io/datasources/survey_design/repository/localRepositoryPrice.dart';
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

class GetDemographyValue extends StatefulWidget {
  const GetDemographyValue({super.key});

  @override
  State<GetDemographyValue> createState() => _GetDemographyValueState();

}

class _GetDemographyValueState extends State<GetDemographyValue> {
  // Load Data
  Future loadData() async {
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
      } else {
        firstAgeValue = int.tryParse(getFirstValue(selectedScopeAge.first))!;
      }

      if (getLastValue(selectedScopeAge.last) == 'Semua') {
        lastAgeValue = 99;
      } else {
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

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
