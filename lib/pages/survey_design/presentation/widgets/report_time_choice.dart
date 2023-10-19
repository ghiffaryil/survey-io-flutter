// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:survey_io/common/components/elevated_button.dart';
import 'package:survey_io/pages/survey_design/data/list_report_time.dart';
import 'package:survey_io/pages/survey_design/models/report_time.dart';
import 'package:survey_io/pages/survey_design/presentation/survey_design.dart';

import '../../../../common/components/appbar_plain.dart';
import '../../../../common/components/divider.dart';
import '../../../../common/components/label.dart';
import '../../../../common/constants/colors.dart';
import '../../../../common/constants/styles.dart';
import '../../../../common/constants/padding.dart';
import '../../../../common/extension/helper/currency_helper.dart';
import '../../data/repository/local/localRepositoryReportTime.dart';

class ReportTimeChoice extends StatefulWidget {
  const ReportTimeChoice({super.key});

  @override
  State<ReportTimeChoice> createState() => _ReportTimeChoiceState();
}

class _ReportTimeChoiceState extends State<ReportTimeChoice> {
  // Initialize respondentId and respondentScope variable type
  int? selectedId;
  var selectedScope;
  int? selectedPrice;

  // Get shared Preferences Class
  final _ReportTimeChoiceRepository = ReportTimeChoiceRepository();

  @override
  void initState() {
    getChoice(); // Load Get Choice
    super.initState();
  }

  // Get Selected Choice
  Future getChoice() async {
    final getChoiceValue = await _ReportTimeChoiceRepository.getChoice();

    if (getChoiceValue != null) {
      if (getChoiceValue['id'] != null || getChoiceValue['scope'] != null) {
        setState(() {
          selectedId = getChoiceValue['id'];
          selectedScope = getChoiceValue['scope'];
          selectedPrice = getChoiceValue['Price'];
        });
      } else {
        setState(() {
          selectedId = 0;
          selectedPrice = 0;
          selectedScope = 'Pilih Durasi Report';
        });
      }
    }
  }

  // Save Choice
  Future<void> saveChoice() async {
    var setChoiceValue = {
      'id': selectedId,
      'scope': selectedScope,
      'price': selectedPrice,
    };
    String setChoiceValueJson = jsonEncode(setChoiceValue);

    try {
      await _ReportTimeChoiceRepository.setChoice(setChoiceValueJson);

      print('setChoiceValueJson: $setChoiceValueJson');
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
                labelText: 'Durasi Report', labelStyle: TextStyles.h3()),
          ),
          ListView.separated(
            separatorBuilder: (context, index) {
              return const Divider();
            },
            shrinkWrap: true,
            itemCount: ListReportTime.getReportTimeList().length,
            itemBuilder: (context, index) {
              final ReportTimeModel data =
                  ListReportTime.getReportTimeList()[index];

              String? formatterRupiahPrice;
              formatterRupiahPrice = formatCurrency(data.price.toDouble());

              return ListTile(
                title: Text(data.scope, style: TextStyles.medium()),
                leading: Radio(
                  activeColor: AppColors.primary,
                  value: data.id,
                  groupValue: selectedId,
                  onChanged: (value) {
                    // Update Data
                    setState(() {
                      selectedId = value!; // Update selected id
                      selectedScope = data.scope; // Update selected scope
                      selectedPrice = data.price; // Update selected scope
                      saveChoice(); // Save to Shared Preferences
                    });
                  },
                ),
                trailing: Text(
                  '$formatterRupiahPrice,-', // Use formatterRupiahPrice
                  style: TextStyles.medium(),
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
