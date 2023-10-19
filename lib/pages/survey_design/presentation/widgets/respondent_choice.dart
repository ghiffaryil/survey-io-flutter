// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:survey_io/common/components/elevated_button.dart';
import 'package:survey_io/pages/survey_design/presentation/survey_design.dart';

import '../../../../common/components/appbar_plain.dart';
import '../../../../common/components/divider.dart';
import '../../../../common/components/label.dart';
import '../../../../common/constants/colors.dart';
import '../../../../common/constants/styles.dart';
import '../../../../common/constants/padding.dart';
import '../../data/list_respondent.dart';
import '../../data/repository/local/localRepositoryRespondent.dart';
import '../../models/respondent_model.dart';

class RespondentChoice extends StatefulWidget {
  const RespondentChoice({super.key});

  @override
  State<RespondentChoice> createState() => _RespondentChoiceState();
}

class _RespondentChoiceState extends State<RespondentChoice> {
  // Initialize respondentId and respondentScope variable type
  int? selectedId;
  var selectedScope;

  // Get shared Preferences Class
  final _RespondentChoiceRepository = RespondentChoiceRepository();

  @override
  void initState() {
    getChoice(); // Load Get Choice
    super.initState();
  }

  // Get Selected Choice
  Future getChoice() async {
    final getChoiceValue = await _RespondentChoiceRepository.getChoice();

    if (getChoiceValue != null) {
      if (getChoiceValue['id'] != null || getChoiceValue['scope'] != null) {
        setState(() {
          selectedId = getChoiceValue['id'];
          selectedScope = getChoiceValue['scope'];
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
  Future<void> saveChoice() async {
    var setChoiceValue = {
      'id': selectedId,
      'scope': selectedScope,
    };
    String setChoiceValueJson = jsonEncode(setChoiceValue);

    try {
      await _RespondentChoiceRepository.setChoice(setChoiceValueJson);
      print('Set value to JSON: $setChoiceValueJson');
    } catch (e) {
      print('Error saving respondentChoice: $e');
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
