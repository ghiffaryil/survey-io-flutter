import 'dart:convert';

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

// Load Data
Future<Map<String, dynamic>> loadData() async {
  Map<String, dynamic> results = {};

  results['respondentValue'] = await getRespondentOption();
  results['questionValue'] = await getQuestionOption();
  results['reportTimeValue'] = await getReportTimeOption();
  results['screenerValue'] = await getScreenerOption();
  results['ageValues'] = await getAgeOption();
  results['genderValue'] = await getGenderOption();
  results['occupationValue'] = await getOccupationOption();
  results['maritalValue'] = await getMaritalOption();
  results['childrenValue'] = await getChildrenOption();

  return results;
}

void getDemographyFunction() async {
  Map<String, dynamic> results = await loadData();

  int respondentValue = results['respondentValue'];
  int questionValue = results['questionValue'];
  int reportTimeValue = results['reportTimeValue'];
  int screenerValue = results['screenerValue'];
  List<String> ageValues = results['ageValues'];
  String genderValue = results['genderValue'];
  String occupationValue = results['occupationValue'];
  List<String> maritalValue = results['maritalValue'];
  List<String> childrenValue = results['childrenValue'];

  // Now you have access to all the values returned by the functions.
  print(respondentValue);
  print(questionValue);
  print(reportTimeValue);
  print(screenerValue);
  print(ageValues);
  print(genderValue);
  print(occupationValue);
  print(maritalValue);
  print(childrenValue);

  // Rest of your code
  // ...
}

// GET RESPONDENT OPTION
Future getRespondentOption() async {
  final getOptionValue = await respondentRepository.getOption();

  if (getOptionValue != null) {
    if (getOptionValue['id'] == null || getOptionValue['scope'] == null) {
      respondentId = 0;
      respondentScope = 'Pilih Jumlah Responden';
      respondentValue = 0;
    } else {
      respondentId = getOptionValue['id'];
      respondentScope = getOptionValue['scope'];
      respondentValue = getOptionValue['scope'];
    }
  } else {
    respondentId = 0;
    respondentScope = 'Pilih Jumlah Responden';
    respondentValue = 0;
  }

  return respondentValue;
  // print('Load Respondent Repository : $respondentScope');
}

// GET QUESTION OPTION
Future getQuestionOption() async {
  final getOptionValue = await questionRepository.getOption();

  if (getOptionValue != null) {
    if (getOptionValue['id'] == null || getOptionValue['scope'] == null) {
      questionId = 0;
      totalQuestionScope = 'Pilih Jumlah Pertanyaan';
      totalQuestionValue = 0;
    } else {
      questionId = getOptionValue['id'];
      totalQuestionScope = getOptionValue['scope'];
      totalQuestionValue = getOptionValue['scope'];
    }
  } else {
    questionId = 0;
    totalQuestionScope = 'Pilih Jumlah Pertanyaan';
    totalQuestionValue = 0;
  }

  return totalQuestionValue;
  // print('Load Question Repository : $totalQuestionScope');
}

// GET REPORT TIME OPTION
Future getReportTimeOption() async {
  final getOptionValue = await reportTimeRepository.getOption();

  if (getOptionValue != null) {
    if (getOptionValue['id'] == null || getOptionValue['scope'] == null) {
      reportTimeId = 0;
      reportTimeScope = 'Pilih Durasi Report';
      reportTimeValue = 0;
    } else {
      reportTimeId = getOptionValue['id'];
      reportTimeScope = getOptionValue['scope'];
      reportTimeValue = int.parse(reportTimeScope);
    }
  } else {
    reportTimeId = 0;
    reportTimeScope = 'Pilih Durasi Report';
    reportTimeValue = 0;
  }

  return reportTimeValue;
  // print('Load Report Time Repository : $reportTimeScope');
}

// GET SCREENER OPTION
Future getScreenerOption() async {
  final getOptionValue = await screenerRepository.getOption();

  if (getOptionValue != null) {
    if (getOptionValue['scope'] == null) {
      screenerOptionValue = '';
      totalScreener = 0;
    } else {
      screenerOptionValue = getOptionValue['scope'];
      totalScreener = 1;
    }
  } else {
    screenerOptionValue = '';
    totalScreener = 0;
  }

  return totalScreener;
}

// GET Age OPTION
Future getAgeOption() async {
  final savedData = await ageRepository.getOption();
  if (savedData != null) {
    selectedIdAge = (savedData['id'] as List<dynamic>).cast<int>();
    selectedScopeAge = (savedData['scope'] as List<dynamic>).cast<String>();
  } else {
    selectedIdAge.add(0);
    selectedScopeAge.add('Semua');

    final data = {
      'id': 0,
      'scope': 'Semua',
    };
    final jsonData = jsonEncode(data);
    await ageRepository.setOption(jsonData);
  }

  // SET FIRST & LAST VALUE OF AGE

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

  return selectedScopeAge;
  // print('Load Age Repository : $selectedScopeAge');
}

// GET Gender OPTION
Future getGenderOption() async {
  final savedData = await genderRepository.getOption();
  if (savedData != null) {
    selectedIdGender = savedData['id'];
    selectedScopeGender = savedData['scope'];
  } else {
    selectedIdGender = 0;
    selectedScopeGender = 'Semua';

    final data = {
      'id': 0,
      'scope': 'Semua',
    };
    final jsonData = jsonEncode(data);
    await genderRepository.setOption(jsonData);
  }
  return selectedScopeGender;
  // print('Load Gender Repository : $selectedScopeGender');
}

// GET Occupation OPTION
Future getOccupationOption() async {
  final savedData = await occupationRepository.getOption();
  if (savedData != null) {
    selectedIdOccupation = savedData['id'];
    selectedScopeOccupation = savedData['scope'];
  } else {
    selectedIdOccupation = 0;
    selectedScopeOccupation = 'Semua';

    final data = {
      'id': 0,
      'scope': 'Semua',
    };
    final jsonData = jsonEncode(data);
    await occupationRepository.setOption(jsonData);
  }

  return selectedScopeOccupation;
  // print('Load Occupation Repository : $selectedScopeOccupation');
}

// GET Marital OPTION
Future getMaritalOption() async {
  final savedData = await maritalRepository.getOption();
  if (savedData != null) {
    selectedIdMarital = (savedData['id'] as List<dynamic>).cast<int>();
    selectedScopeMarital = (savedData['scope'] as List<dynamic>).cast<String>();
  } else {
    selectedIdMarital.add(0);
    selectedScopeMarital.add('Semua');

    final data = {
      'id': 0,
      'scope': 'Semua',
    };
    final jsonData = jsonEncode(data);
    await maritalRepository.setOption(jsonData);
  }
  return selectedScopeMarital;
  // print('Load Marital Repository : $selectedScopeMarital');
}

// GET Children OPTION
Future getChildrenOption() async {
  final savedData = await childrenRepository.getOption();
  if (savedData != null) {
    selectedIdChildren = (savedData['id'] as List<dynamic>).cast<int>();
    selectedScopeChildren =
        (savedData['scope'] as List<dynamic>).cast<String>();
  } else {
    selectedIdChildren.add(0);
    selectedScopeChildren.add('Semua');

    final data = {
      'id': 0,
      'scope': 'Semua',
    };
    final jsonData = jsonEncode(data);
    await childrenRepository.setOption(jsonData);
  }
  return selectedScopeChildren;
  // print('Load Children Repository : $selectedScopeChildren');
}

// GET Region OPTION
Future getRegionOption() async {
  final savedData = await regionRepository.getOption();
  if (savedData != null) {
    selectedIdRegion = savedData['id'];
    selectedScopeRegion = savedData['scope'];
  } else {
    selectedIdRegion = 0;
    selectedScopeRegion = 'Semua';

    final data = {
      'id': 0,
      'scope': 'Semua',
    };
    final jsonData = jsonEncode(data);
    await regionRepository.setOption(jsonData);
  }

  return selectedScopeRegion;
  // print('Load Region Repository : $selectedScopeRegion');
}

// GET Religion OPTION
Future getReligionOption() async {
  final savedData = await religionRepository.getOption();
  if (savedData != null) {
    selectedIdReligion = savedData['id'];
    selectedScopeReligion = savedData['scope'];
  } else {
    selectedIdReligion = 0;
    selectedScopeReligion = 'Semua';

    final data = {
      'id': 0,
      'scope': 'Semua',
    };
    final jsonData = jsonEncode(data);
    await religionRepository.setOption(jsonData);
  }

  return selectedScopeReligion;
  // print('Load Religion Repository : $selectedScopeReligion');
}

// GET Income OPTION
Future<List<String>> getIncomeOption() async {
  final savedData = await incomeRepository.getOption();
  if (savedData != null) {
    selectedIdIncome = (savedData['id'] as List<dynamic>).cast<int>();
    selectedScopeIncome = (savedData['scope'] as List<dynamic>).cast<String>();
  } else {
    selectedIdIncome.add(0);
    selectedScopeIncome.add('Semua');

    final data = {
      'id': 0,
      'scope': 'Semua',
    };
    final jsonData = jsonEncode(data);
    await incomeRepository.setOption(jsonData);
  }

  firstIncomeValue = getFirstValue(selectedScopeIncome.first);
  lastIncomeValue = getLastValue(selectedScopeIncome.last);

  if (getFirstValue(selectedScopeIncome.first) == 'Semua') {
    firstIncomeValue = '0';
  } else if (selectedScopeIncome.first == '<1.000.000') {
    firstIncomeValue = '0';
  } else {
    firstIncomeValue = selectedScopeIncome.first;
  }

  if (getLastValue(selectedScopeIncome.last) == 'Semua') {
    lastIncomeValue = '1.000.000';
  } else if (selectedScopeIncome.last == '<1.000.000') {
    lastIncomeValue = '1.000.000';
  } else if (selectedScopeIncome.last == '>10.000.000') {
    lastIncomeValue = '99.999.999';
  } else {
    lastIncomeValue = selectedScopeIncome.last;
  }

  return [firstIncomeValue, lastIncomeValue];

  // print('Load Income Repository : $selectedScopeIncome');
}

// GET Outcome OPTION
Future<List<String>> getOutcomeOption() async {
  final savedData = await outcomeRepository.getOption();
  if (savedData != null) {
    selectedIdOutcome = (savedData['id'] as List<dynamic>).cast<int>();
    selectedScopeOutcome = (savedData['scope'] as List<dynamic>).cast<String>();
  } else {
    selectedIdOutcome.add(0);
    selectedScopeOutcome.add('Semua');

    final data = {
      'id': 0,
      'scope': 'Semua',
    };
    final jsonData = jsonEncode(data);
    await outcomeRepository.setOption(jsonData);
  }

  firstOutcomeValue = getFirstValue(selectedScopeOutcome.first);
  lastOutcomeValue = getLastValue(selectedScopeOutcome.last);

  if (getFirstValue(selectedScopeOutcome.first) == 'Semua') {
    firstOutcomeValue = '0';
  } else if (selectedScopeOutcome.first == '<1.000.000') {
    firstOutcomeValue = '0';
  } else {
    firstOutcomeValue = selectedScopeOutcome.first;
  }

  if (getLastValue(selectedScopeOutcome.last) == 'Semua') {
    lastOutcomeValue = '1.000.000';
  } else if (selectedScopeOutcome.last == '<1.000.000') {
    lastOutcomeValue = '1.000.000';
  } else if (selectedScopeOutcome.last == '>10.000.000') {
    lastOutcomeValue = '99.999.999';
  } else {
    lastOutcomeValue = selectedScopeOutcome.last;
  }

  return [firstOutcomeValue, lastOutcomeValue];

  // print('Load Outcome Repository : $selectedScopeOutcome');
}
