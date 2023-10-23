import 'dart:convert';
import 'package:flutter/material.dart';

import '../../../../common/components/divider.dart';
import '../../../../common/components/checkbox.dart';
import '../../../../common/constants/colors.dart';
import '../../../../common/constants/imageSize.dart';
import '../../../../common/constants/indicator.dart';
import '../../../../common/constants/styles.dart';
import '../../../../common/components/elevated_button.dart';
import '../../../../common/constants/padding.dart';

import '../../data/list_demography_age.dart';
import '../../data/repository/local/localRepositoryAge.dart';
import '../../models/demography_age_model.dart';

class ModalOptionAge extends StatefulWidget {
  final void Function() onUpdate;

  const ModalOptionAge({super.key, required this.onUpdate});

  @override
  State<ModalOptionAge> createState() => _ModalOptionAgeState();
}

class _ModalOptionAgeState extends State<ModalOptionAge> {
  final List<DemographyAgeModel> list =
      ListDemographyAge.getDemographyAgeList();
  final ageRepository = LocalRepositoryDemographyAge();

  List<int> selectedId = [];
  List<String> selectedScope = [];
  bool selectAll = false;

  @override
  void initState() {
    super.initState();
    selectedScope = [];
    onLoad();
  }

  // Save to Shared References
  void onSave() async {
    final data = {
      'id': selectedId,
      'scope': selectedScope,
    };
    final jsonData = jsonEncode(data);
    await ageRepository.setOption(jsonData);
  }

  // Load from Shared References
  void onLoad() async {
    final savedData = await ageRepository.getOption();
    if (savedData != null) {
      setState(() {
        selectedId = (savedData['id'] as List<dynamic>).cast<int>();
        selectedScope = (savedData['scope'] as List<dynamic>).cast<String>();
        selectAll = selectedScope.isEmpty ? true : false;
        print('Load Selected Age');
        print(selectedScope);
      });
    } else {
      print('Age is Empty');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppHeight.imageSize(context, AppHeight.extraLarge),
      padding: CustomPadding.p2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const IndicatorModal(),
          CustomDividers.smallDivider(),
          Container(
            padding: CustomPadding.p1,
            child: Text(
              'Usia',
              style: TextStyles.h2(color: AppColors.secondary),
            ),
          ),
          Container(
            padding: CustomPadding.p1,
            child: Text(
              'Rp40.000 - 80.000 / 50 Responden',
              style: TextStyles.extraLarge(color: AppColors.secondary),
            ),
          ),
          CustomDividers.verySmallDivider(),
          Expanded(
            child: SingleChildScrollView(
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: list.length + 1,
                separatorBuilder: ((context, index) {
                  return const Divider();
                }),
                itemBuilder: (BuildContext context, int index) {
                  if (index == 0) {
                    return ListTile(
                      title: Text(
                        'Semua',
                        style: TextStyles.large(
                            fontWeight: FontWeight.w600,
                            color: selectedId.isEmpty && selectedScope.isEmpty
                                ? AppColors.black
                                : AppColors.light.withOpacity(0.6)),
                      ),
                      leading: CustomCheckbox(
                          value: selectAll,
                          onChanged: (bool? value) {
                            setState(() {
                              selectAll = value ?? false;
                              selectedId.clear();
                              selectedScope.clear();
                            });
                          }),
                    );
                  } else {
                    final item = list[index - 1];
                    return ListTile(
                        title: Text(
                          item.scope.toString(),
                          style: TextStyles.large(
                              fontWeight: FontWeight.w600,
                              color: selectedId.contains(item.id) &&
                                      selectedScope.contains(item.scope)
                                  ? AppColors.black
                                  : AppColors.light.withOpacity(0.6)),
                        ),
                        leading: CustomCheckbox(
                          value: selectedId.contains(item.id),
                          onChanged: (bool? value) {
                            setState(() {
                              if (value == true) {
                                // When an item other than "Semua" is selected
                                // int currentIndex = list
                                //     .indexWhere(
                                //         (element) => element.id == item.id);
                                // Select all previous items up to the current item
                                // for (int i = 0; i <= currentIndex; i++) {
                                //   if (!selectedId
                                //       .contains(list[i].id)) {
                                //     selectedId
                                //         .add(list[i].id);
                                //     selectedScope
                                //         .add(list[i].scope);
                                //   }
                                // }

                                selectedId.add(item.id);
                                selectedScope.add(item.scope);
                              } else {
                                // When an item is unselected
                                // int currentIndex = list
                                //     .indexWhere(
                                //         (element) => element.id == item.id);

                                // Uncheck all items with larger IDs
                                // for (int i = currentIndex + 1;
                                //     i < list.length;
                                //     i++) {
                                //   selectedId
                                //       .remove(list[i].id);
                                //   selectedScope
                                //       .remove(list[i].scope);
                                // }
                                // Uncheck this item
                                selectedId.remove(item.id);
                                selectedScope.remove(item.scope);
                              }

                              // First, sort the selectedId list
                              selectedId.sort();

                              // Then, sort the selectedScope list based on the latest id
                              selectedScope.sort((a, b) {
                                final indexA =
                                    list.indexWhere((item) => item.scope == a);
                                final indexB =
                                    list.indexWhere((item) => item.scope == b);
                                return selectedId.indexOf(indexA) -
                                    selectedId.indexOf(indexB);
                              });

                              // If all items are deselected, reselect "Semua"
                              if (selectedId.isEmpty) {
                                selectAll = true;
                                selectedId.add(0);
                                selectedScope.add('Semua');
                              } else {
                                // Remove "Semua" if it's in the selected lists
                                selectAll = false;
                                selectedId.remove(0);
                                selectedScope.remove('Semua');
                              }

                              // Check if "Semua" should be selected
                              if (selectedId.length == list.length) {
                                selectAll = true;
                                selectedId.clear();
                                selectedScope.clear();
                              } else if (selectedId.isEmpty) {
                                // "Semua" is not selected, select it
                                selectAll = true;
                                selectedId.clear();
                                selectedScope.clear();
                              }
                            });
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
