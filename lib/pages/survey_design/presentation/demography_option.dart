import 'dart:convert';

import 'package:flutter/material.dart';
import '../../../common/components/input_field_text.dart';
import '../../../common/components/label.dart';
import '../../../common/constants/padding.dart';
import '../../../common/components/appbar_plain.dart';
import '../../../common/components/divider.dart';
import '../../../common/constants/colors.dart';
import '../../../common/constants/styles.dart';
import '../models/demography_age_model.dart';
import '../data/list_demography_age.dart';
import '../data/repository/local/localRepositoryAge.dart';
import 'widgets/modal_option_age.dart';

class DemographyOption extends StatefulWidget {
  const DemographyOption({super.key});

  @override
  State<DemographyOption> createState() => _DemographyOptionState();
}

class _DemographyOptionState extends State<DemographyOption> {
  final demographyLocalRepository = LocalRepositoryDemographyAge();

  final List<DemographyAgeModel> demographyAgeList =
      ListDemographyAge.getDemographyAgeList();

  TextEditingController inputDemographyAge = TextEditingController();

  List<int> selectedIds = [];
  List<String> selectedScopes = [];
  bool selectAll = false;

  @override
  void initState() {
    loadOptionAge();
    inputDemographyAge.text =
        selectedScopes.isEmpty ? "Semua" : selectedScopes.join(', ');
    selectAll = selectedScopes.isEmpty ? true : false;
    super.initState();
  }

  // Function to save the selected options to SharedPreferences
  void saveOptionAge() async {
    final data = {
      'id': selectedIds,
      'scope': selectedScopes,
    };
    final jsonData = jsonEncode(data);
    await demographyLocalRepository.setOption(jsonData);
  }

  // Function to load saved selection from SharedPreferences
  void loadOptionAge() async {
    final savedData = await demographyLocalRepository.getOption();
    if (savedData != null) {
      setState(() {
        selectedIds = (savedData['id'] as List<dynamic>).cast<int>();
        selectedScopes = (savedData['scope'] as List<dynamic>).cast<String>();
        selectAll = selectedScopes.isEmpty ? true : false;
        print('Load Select Age');
        print(selectedScopes);
        selectedScopes.isEmpty
            ? inputDemographyAge.text = "Semua"
            : inputDemographyAge.text = selectedScopes.join(', ');
      });
    } else {
      setState(() {
        inputDemographyAge.text = "Usia";
      });
    }
  }

  // UpdateState
  void updateState() {
    loadOptionAge();
    setState(() {
      inputDemographyAge.text =
          selectedScopes.isEmpty ? "Semua" : selectedScopes.join(', ');
    });
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
      body: Container(
        padding: CustomPadding.pdefault,
        child: Column(
          children: [
            const LabelHeading(
                labelText: 'Atur Demografi', labelColor: AppColors.secondary),
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  CustomDividers.regularDivider(),
                  GestureDetector(
                    onTap: () {
                      _showModalBottomSheet(context);
                    },
                    child: TextInputField(
                      controller: inputDemographyAge,
                      editable: false,
                      hintText: 'Semua',
                      labelText: 'Usia',
                      labelStyle: TextStyles.extraLarge(),
                      hintStyle: TextStyles.extraLarge(color: AppColors.black),
                      keyboardType: TextInputType.text,
                      suffixIcon: Icon(
                        inputDemographyAge.text == "Usia"
                            ? Icons.add
                            : Icons.edit,
                        color: AppColors.info,
                      ),
                    ),
                  ),
                  CustomDividers.regularDivider(),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }

  void _showModalBottomSheet(BuildContext context) async {
    await showModalBottomSheet(
      backgroundColor: AppColors.white,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      isScrollControlled: true,
      builder: (BuildContext context) {
        return ModalOptionAge(
          demographyAgeList: demographyAgeList,
          selectedIds: selectedIds,
          selectedScopes: selectedScopes,
          selectAll: selectAll,
          onSave: () {
            saveOptionAge();
          },
          onUpdate: () {
            updateState();
          },
          onChanged: (value) {
            setState(() {
              selectAll = value ?? false;
              selectedIds.clear();
              selectedScopes.clear();
            });
          },
        );
      },
    );
  }
}
