// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:survey_io/common/components/elevated_button.dart';
import 'package:survey_io/pages/survey_design/data/list_question_value.dart';
import 'package:survey_io/pages/survey_design/models/question_model.dart';
import 'package:survey_io/pages/survey_design/presentation/survey_design.dart';

import '../../../../common/components/appbar_plain.dart';
import '../../../../common/components/divider.dart';
import '../../../../common/components/label.dart';
import '../../../../common/constants/colors.dart';
import '../../../../common/constants/styles.dart';
import '../../../../common/constants/padding.dart';
import '../../data/repository/local/localRepositoryQuestion.dart';

class QuestionChoice extends StatefulWidget {
  const QuestionChoice({super.key});

  @override
  State<QuestionChoice> createState() => _QuestionChoiceState();
}

class _QuestionChoiceState extends State<QuestionChoice> {
  // Initialize respondentId and respondentScope variable type
  int? selectedId;
  var selectedScope;

  // Get shared Preferences Class
  final _QuestionRepository = QuestionChoiceRepository();

  @override
  void initState() {
    getChoice(); // Load Get Choice
    super.initState();
  }

  // Get Selected Choice
  Future getChoice() async {
    final getChoiceValue = await _QuestionRepository.getChoice();

    if (getChoiceValue != null) {
      if (getChoiceValue['id'] != null || getChoiceValue['scope'] != null) {
        setState(() {
          selectedId = getChoiceValue['id'];
          selectedScope = getChoiceValue['scope'];
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
  Future<void> saveChoice() async {
    var setChoiceValue = {
      'id': selectedId,
      'scope': selectedScope,
    };
    String setChoiceValueJson = jsonEncode(setChoiceValue);

    try {
      await _QuestionRepository.setChoice(setChoiceValueJson);

      print('Set value to JSON: $setChoiceValueJson');
    } catch (e) {
      print('Error saving setChoiceValue: $e');
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
                title: Text('${data.scope}'),
                leading: Radio(
                  activeColor: AppColors.primary,
                  value: data.id,
                  groupValue: selectedId,
                  onChanged: (value) {
                    // Update Data
                    setState(() {
                      selectedId = value!; // Update selected id
                      selectedScope = data.scope; // Update selected scope
                      saveChoice(); // Save to Shared Preferences
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
