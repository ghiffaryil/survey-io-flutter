// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'dart:convert';
import 'package:flutter/material.dart';

import '../../../../common/components/appbar_plain.dart';
import '../../../../common/components/divider.dart';
import '../../../../common/components/label.dart';
import '../../../../common/constants/colors.dart';
import '../../../../common/constants/styles.dart';
import '../../../../common/constants/padding.dart';
import '../../data/repository/local/localRepositoryQuestion.dart';
import '../../../../common/components/elevated_button.dart';
import '../../data/list_question_value.dart';
import '../../models/question_model.dart';
import '../survey_design.dart';

class QuestionOption extends StatefulWidget {
  const QuestionOption({super.key});

  @override
  State<QuestionOption> createState() => _QuestionOptionState();
}

class _QuestionOptionState extends State<QuestionOption> {
  // Initialize respondentId and respondentScope variable type
  int? selectedId;
  var selectedScope;

  // Get shared Preferences Class
  final _QuestionRepository = LocalRepositoryQuestion();

  @override
  void initState() {
    getOption(); // Load Get Choice
    super.initState();
  }

  // Get Selected Choice
  Future getOption() async {
    final getOptionValue = await _QuestionRepository.getOption();

    if (getOptionValue != null) {
      if (getOptionValue['id'] != null || getOptionValue['scope'] != null) {
        setState(() {
          selectedId = getOptionValue['id'];
          selectedScope = getOptionValue['scope'];
        });
      } else {
        setState(() {
          selectedId = 0;
          selectedScope = 'Pilih Jumlah Pertanyaan';
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
      await _QuestionRepository.setOption(setOptionValueJson);
      print('Set value to JSON: $setOptionValueJson');
    } catch (e) {
      print('Error saving setOptionValue: $e');
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
                labelText: 'Jumlah Pertanyaan', labelStyle: TextStyles.h3()),
          ),
          ListView.separated(
            separatorBuilder: (context, index) {
              return const Divider();
            },
            shrinkWrap: true,
            itemCount: ListQuestion.getQuestionList().length,
            itemBuilder: (context, index) {
              final QuestionModel data = ListQuestion.getQuestionList()[index];

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
        ],
      ),
    );
  }
}
