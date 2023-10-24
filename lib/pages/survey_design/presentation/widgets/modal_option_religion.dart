import 'dart:convert';
import 'package:flutter/material.dart';

import '../../../../common/constants/imageSize.dart';
import '../../../../common/constants/indicator.dart';
import '../../../../common/components/divider.dart';
import '../../../../common/constants/colors.dart';
import '../../../../common/constants/styles.dart';
import '../../../../common/components/elevated_button.dart';
import '../../../../common/constants/padding.dart';
import '../../data/list_demography_religion.dart';
import '../../data/repository/local/localRepositoryReligion.dart';
import '../../models/demography_religion_model.dart';

class ModalOptionReligion extends StatefulWidget {
  final void Function() onUpdate;
  const ModalOptionReligion({super.key, required this.onUpdate});

  @override
  State<ModalOptionReligion> createState() => _ModalOptionReligionState();
}

class _ModalOptionReligionState extends State<ModalOptionReligion> {
  final List<DemographyReligionModel> list =
      ListDemographyReligion.getDemographyReligionList();
  final repository = LocalRepositoryDemographyReligion();

  // Selected Religion
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
        print('Load Selected Religion');
        print(selectedScope);
      });
      print(selectedScope);
    } else {
      print('Religion is Empty');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppHeight.imageSize(context, AppHeight.extraLarge),
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
              'Agama',
              style: TextStyles.h2(color: AppColors.secondary),
            ),
          ),
          Container(
            padding: CustomPadding.p1,
            child: Text(
              'Rp50.000 - 250.000 / 50 Responden',
              style: TextStyles.extraLarge(color: AppColors.secondary),
            ),
          ),
          CustomDividers.verySmallDivider(),
          Expanded(
            child: SingleChildScrollView(
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: list.length + 1,
                itemBuilder: (BuildContext context, int index) {
                  if (index == 0) {
                    return ListTile(
                        dense: true,
                        title: Text(
                          'Semua Agama',
                          style: TextStyles.extraLarge(
                            color: selectedId == 0
                                ? Colors.black
                                : Colors.grey.withOpacity(0.6),
                          ),
                        ),
                        leading: Radio(
                          activeColor: AppColors.primary,
                          value: 0,
                          groupValue: selectedId,
                          onChanged: (value) {
                            setState(() {
                              selectedId = 0;
                              selectedScope = 'Semua';
                            });
                            print(selectedId);
                            print(selectedScope);
                          },
                        ));
                  } else {
                    final item = list[index - 1];
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
                  }
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
