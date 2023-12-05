// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:survey_io/models/survey_design/data/report_time.dart';
import 'package:survey_io/pages/survey_design/survey_design.dart';
import '../../../../common/components/appbar_plain.dart';
import '../../../../common/components/divider.dart';
import '../../../../common/components/label.dart';
import '../../../../common/constants/colors.dart';
import '../../../../common/constants/styles.dart';
import '../../../../common/constants/padding.dart';
import '../../../../common/extension/helper/currency_helper.dart';
import '../../../../common/components/elevated_button.dart';
import '../../../datasources/survey_design/data/list_report_time.dart';
import '../../../datasources/survey_design/repository/localRepositoryReportTime.dart';

class ReportTimeOption extends StatefulWidget {
  const ReportTimeOption({super.key});

  @override
  State<ReportTimeOption> createState() => _ReportTimeOptionState();
}

class _ReportTimeOptionState extends State<ReportTimeOption> {
  // Initialize respondentId and respondentScope variable type
  int? selectedId;
  var selectedScope;
  int? selectedPrice;

  // Get shared Preferences Class
  final _ReportTimeOptionRepository = LocalRepositoryReportTime();

  @override
  void initState() {
    getOption(); // Load Get Choice
    super.initState();
  }

  // Get Selected Choice
  Future getOption() async {
    final getOptionValue = await _ReportTimeOptionRepository.getOption();

    if (getOptionValue != null) {
      if (getOptionValue['id'] != null || getOptionValue['scope'] != null) {
        setState(() {
          selectedId = getOptionValue['id'];
          selectedScope = getOptionValue['scope'];
          selectedPrice = getOptionValue['Price'];
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
  Future<void> setOption() async {
    var setOptionValue = {
      'id': selectedId,
      'scope': selectedScope,
      'price': selectedPrice,
    };
    String setOptionValueJson = jsonEncode(setOptionValue);

    try {
      await _ReportTimeOptionRepository.setOption(setOptionValueJson);

      print('setOptionValueJson: $setOptionValueJson');
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
                dense: true,
                title: Text(
                  data.scope,
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
                      selectedPrice = data.price; // Update selected scope
                      setOption(); // Save to Shared Preferences
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
