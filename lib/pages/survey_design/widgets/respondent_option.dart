// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  final _RespondentOptionRepository = LocalRepositoryRespondent();
  final localRepositorySurceyDesignPrice = LocalRepositorySurveyDesignPrice();
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

  List demographyAgeValue = [];
  String demographyGenderValue = '';
  List demographyChildrenValue = [];
  List demographyIncomeValue = [];
  List demographyMaritalValue = [];
  String demographyOccupationValue = '';
  List demographyOutcomeValue = [];
  String demographyRegionValue = '';
  String demographyReligionValue = '';

  @override
  void initState() {
    super.initState();
    getOption(); // Load Get Choice
    loadData();
  }

  Future loadData() async {
    context.read<SurveyDesignListRespondentBloc>().add(
        const SurveyDesignListRespondentEvent.getSurveyDesignListRespondent());
  }

  // Get Selected Choice
  Future getOption() async {
    final getOptionValue = await _RespondentOptionRepository.getOption();

    if (getOptionValue != null) {
      if (getOptionValue['id'] != null || getOptionValue['scope'] != null) {
        setState(() {
          selectedId = getOptionValue['id'];
          selectedScope = getOptionValue['scope'];
        });
      } else {
        setState(() {
          selectedId = 0;
          selectedScope = 'Pilih Jumlah Responden';
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
      await _RespondentOptionRepository.setOption(setOptionValueJson);
      print('Set value to JSON: $setOptionValueJson');
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
                                    // Update Data
                                    setState(() {
                                      selectedId = value!; // Update selected id
                                      selectedScope = dataRespondent
                                          .scope; // Update selected scope
                                      setOption(); // Save to Shared Preferences
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
                          localRepositorySurceyDesignPrice.setOption(jsonData);
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
                                  text: 'OK',
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => SurveyDesign(
                                                designAction:
                                                    widget.designAction)));
                                  });
                            },
                            loading: () {
                              return ButtonFilled.primary(
                                  text: '',
                                  textColor: AppColors.white,
                                  loading: true,
                                  onPressed: () {});
                            },
                          );
                        },
                      ),
                    ),
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
