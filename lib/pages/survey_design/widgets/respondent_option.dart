// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:survey_io/models/survey_design/data/respondent_model.dart';
import 'package:survey_io/pages/survey_design/survey_design.dart';

import '../../../../common/components/elevated_button.dart';
import '../../../../common/components/appbar_plain.dart';
import '../../../../common/components/divider.dart';
import '../../../../common/components/label.dart';
import '../../../../common/constants/colors.dart';
import '../../../../common/constants/styles.dart';
import '../../../../common/constants/padding.dart';
import '../../../datasources/survey_design/data/list_respondent.dart';
import '../../../datasources/survey_design/repository/local/localRepositoryRespondent.dart';

class RespondentOption extends StatefulWidget {
  const RespondentOption({super.key});

  @override
  State<RespondentOption> createState() => _RespondentOptionState();
}

class _RespondentOptionState extends State<RespondentOption> {
  // Initialize respondentId and respondentScope variable type
  int? selectedId;
  var selectedScope;

  // Get shared Preferences Class
  final _RespondentOptionRepository = LocalRepositoryRespondent();

  @override
  void initState() {
    getOption(); // Load Get Choice
    super.initState();
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
          ListView.separated(
            separatorBuilder: (context, index) {
              return const Divider();
            },
            shrinkWrap: true,
            itemCount: ListRespondent.getRespondentList().length,
            itemBuilder: (context, index) {
              final RespondentModel data =
                  ListRespondent.getRespondentList()[index];

              return ListTile(
                dense: true,
                title: Text(
                  '${data.scope}',
                  style: TextStyles.medium(),
                ),
                leading: Radio(
                  activeColor: AppColors.primary,
                  value: data.id,
                  groupValue: selectedId,
                  onChanged: (value) {
                    // Update Data
                    setState(() {
                      selectedId = value!; // Update selected id
                      selectedScope = data.scope; // Update selected scope
                      setOption(); // Save to Shared Preferences
                    });
                  },
                ),
              );
            },
          ),
          CustomDividers.smallDivider(),
          Container(
            padding: CustomPadding.pdefault,
            child: ButtonFilled.primary(
                text: 'OK',
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SurveyDesign()));
                }),
          )
          // Container(
          //   padding: CustomPadding.py3,
          //   child: Text(
          //     'Lebih dari 1.000 responden?',
          //     style: TextStyles.h5(
          //         color: AppColors.info,
          //         textDecoration: TextDecoration.underline),
          //   ),
          // )
        ],
      ),
    );
  }
}
