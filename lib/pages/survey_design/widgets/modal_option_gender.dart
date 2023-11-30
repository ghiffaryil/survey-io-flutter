import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:survey_io/models/survey_design/data/demography_gender_model.dart';

import '../../../../common/constants/imageSize.dart';
import '../../../../common/constants/widgets/indicator.dart';
import '../../../../common/components/divider.dart';
import '../../../../common/constants/colors.dart';
import '../../../../common/constants/styles.dart';
import '../../../../common/components/elevated_button.dart';
import '../../../../common/constants/padding.dart';

import '../../../datasources/survey_design/data/list_demography_gender.dart';
import '../../../datasources/survey_design/repository/local/localRepositoryGender.dart';

class ModalOptionGender extends StatefulWidget {
  final void Function() onUpdate;
  const ModalOptionGender({super.key, required this.onUpdate});

  @override
  State<ModalOptionGender> createState() => _ModalOptionGenderState();
}

class _ModalOptionGenderState extends State<ModalOptionGender> {
  final List<DemographyGenderModel> list =
      ListDemographyGender.getDemographyGenderList();
  final repository = LocalRepositoryDemographyGender();

  // Selected Gender
  int selectedId = 0;
  String selectedScope = 'Semua';
  bool selectAll = false;

  @override
  void initState() {
    super.initState();
    selectedScope = '';
    onLoad();
  }

  // Save to Shared References
  void onSave() async {
    final data = {
      'id': selectedId,
      'scope': selectedScope,
    };
    final jsonData = jsonEncode(data);
    print(jsonData);
    await repository.setOption(jsonData);
  }

  // Load from Shared References
  void onLoad() async {
    final savedData = await repository.getOption();
    if (savedData != null) {
      setState(() {
        selectedId = savedData['id'];
        selectedScope = savedData['scope'];
        selectAll = selectedScope == "Semua" ? true : false;
        print('Load Selected Gender');
        print(selectedScope);
      });
      print(selectedScope);
    } else {
      print('Gender is Empty');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppHeight.imageSize(context, AppHeight.large),
      padding: CustomPadding.p1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const IndicatorModal(),
          CustomDividers.smallDivider(),
          Container(
            padding: CustomPadding.p1,
            child: Text(
              'Jenis Kelamin',
              style: TextStyles.h2(color: AppColors.secondary),
            ),
          ),
          Container(
            padding: CustomPadding.p1,
            child: Text(
              'Rp5.000 / 50 Responden',
              style: TextStyles.extraLarge(color: AppColors.secondary),
            ),
          ),
          CustomDividers.verySmallDivider(),
          Expanded(
            child: SingleChildScrollView(
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: list.length,
                itemBuilder: (BuildContext context, int index) {
                  final item = list[index];
                  return ListTile(
                      dense: true,
                      title: Text(
                        item.scope,
                        style: TextStyles.extraLarge(
                          color: item.id == selectedId
                              ? Colors.black
                              : Colors.grey.withOpacity(0.6),
                        ),
                      ),
                      leading: Radio(
                        activeColor: AppColors.primary,
                        value: item.id,
                        groupValue: selectedId,
                        onChanged: (value) {
                          setState(() {
                            selectedId = value!;
                            selectedScope = item.scope;
                          });
                          print(selectedId);
                          print(selectedScope);
                        },
                      ));
                },
              ),
            ),
          ),
          CustomDividers.smallDivider(),
          Padding(
            padding: CustomPadding.p1,
            child: ButtonFilled.primary(
                text: 'OK',
                onPressed: () {
                  onSave();
                  onLoad();
                  widget.onUpdate();
                  Navigator.of(context).pop();
                }),
          ),
        ],
      ),
    );
  }
}
