// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:survey_io/pages/survey_design/models/demography_age_model.dart';
import 'package:survey_io/common/components/divider.dart';
import 'package:survey_io/common/components/checkbox.dart';
import 'package:survey_io/common/constants/colors.dart';
import 'package:survey_io/common/constants/styles.dart';

import '../../../../common/components/elevated_button.dart';
import '../../../../common/constants/padding.dart';

class ModalOptionAge extends StatefulWidget {
  final List<DemographyAgeModel> demographyAgeList;
  final List<int> selectedIds;
  final List<String> selectedScopes;
  late bool selectAll;
  final void Function(bool?) onChanged;
  final void Function() onSave; // Callback for saving
  final void Function() onUpdate; // Callback for updating

  ModalOptionAge({
    required this.demographyAgeList,
    required this.selectedIds,
    required this.selectedScopes,
    required this.selectAll,
    required this.onChanged,
    required this.onSave, // Add this parameter
    required this.onUpdate, // Add this parameter
  });

  @override
  _CustomModalBottomSheetState createState() => _CustomModalBottomSheetState();
}

class _CustomModalBottomSheetState extends State<ModalOptionAge> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: CustomPadding.p2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.1,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: AppColors.indicator, // Indicator color
              ),
              height: 5, // Indicator height
            ),
          ),
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
          ListView.separated(
            shrinkWrap: true,
            itemCount: widget.demographyAgeList.length + 1,
            separatorBuilder: ((context, index) {
              return Divider();
            }),
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) {
                return ListTile(
                  title: Text(
                    'Semua',
                    style: TextStyles.large(
                        fontWeight: FontWeight.w600,
                        color: widget.selectedIds.isEmpty &&
                                widget.selectedScopes.isEmpty
                            ? AppColors.black
                            : AppColors.light.withOpacity(0.6)),
                  ),
                  leading: CustomCheckbox(
                      value: widget.selectAll,
                      onChanged: (bool? value) {
                        setState(() {
                          widget.selectAll = value ?? false;
                          widget.selectedIds.clear();
                          widget.selectedScopes.clear();
                        });
                      }),
                );
              } else {
                final option = widget.demographyAgeList[index - 1];
                return ListTile(
                    title: Text(
                      option.scope.toString(),
                      style: TextStyles.large(
                          fontWeight: FontWeight.w600,
                          color: widget.selectedIds.contains(option.id) &&
                                  widget.selectedScopes.contains(option.scope)
                              ? AppColors.black
                              : AppColors.light.withOpacity(0.6)),
                    ),
                    leading: CustomCheckbox(
                      value: widget.selectedIds.contains(option.id),
                      onChanged: (bool? value) {
                        setState(() {
                          if (value == true) {
                            // When an option other than "Semua" is selected
                            // int currentIndex = widget.demographyAgeList
                            //     .indexWhere(
                            //         (element) => element.id == option.id);
                            // Select all previous items up to the current item
                            // for (int i = 0; i <= currentIndex; i++) {
                            //   if (!widget.selectedIds
                            //       .contains(widget.demographyAgeList[i].id)) {
                            //     widget.selectedIds
                            //         .add(widget.demographyAgeList[i].id);
                            //     widget.selectedScopes
                            //         .add(widget.demographyAgeList[i].scope);
                            //   }
                            // }

                            widget.selectedIds.add(option.id);
                            widget.selectedScopes.add(option.scope);
                          } else {
                            // When an item is unselected
                            // int currentIndex = widget.demographyAgeList
                            //     .indexWhere(
                            //         (element) => element.id == option.id);

                            // Uncheck all items with larger IDs
                            // for (int i = currentIndex + 1;
                            //     i < widget.demographyAgeList.length;
                            //     i++) {
                            //   widget.selectedIds
                            //       .remove(widget.demographyAgeList[i].id);
                            //   widget.selectedScopes
                            //       .remove(widget.demographyAgeList[i].scope);
                            // }
                            // Uncheck this item
                            widget.selectedIds.remove(option.id);
                            widget.selectedScopes.remove(option.scope);
                          }

                          // First, sort the selectedIds list
                          widget.selectedIds.sort();

                          // Then, sort the selectedScopes list based on the latest id
                          widget.selectedScopes.sort((a, b) {
                            final indexA = widget.demographyAgeList
                                .indexWhere((option) => option.scope == a);
                            final indexB = widget.demographyAgeList
                                .indexWhere((option) => option.scope == b);
                            return widget.selectedIds.indexOf(indexA) -
                                widget.selectedIds.indexOf(indexB);
                          });

                          // If all items are deselected, reselect "Semua"
                          if (widget.selectedIds.isEmpty) {
                            widget.selectAll = true;
                            widget.selectedIds.add(0);
                            widget.selectedScopes.add('Semua');
                          } else {
                            // Remove "Semua" if it's in the selected lists
                            widget.selectAll = false;
                            widget.selectedIds.remove(0);
                            widget.selectedScopes.remove('Semua');
                          }

                          // Check if "Semua" should be selected
                          if (widget.selectedIds.length ==
                              widget.demographyAgeList.length) {
                            widget.selectAll = true;
                            widget.selectedIds.clear();
                            widget.selectedScopes.clear();
                          } else if (widget.selectedIds.isEmpty) {
                            // "Semua" is not selected, select it
                            widget.selectAll = true;
                            widget.selectedIds.clear();
                            widget.selectedScopes.clear();
                          }
                        });
                      },
                    ));
              }
            },
          ),
          CustomDividers.smallDivider(),
          Padding(
            padding: CustomPadding.p1,
            child: ButtonFilled.primary(
                text: 'OK',
                onPressed: () {
                  widget.onSave();
                  widget.onUpdate();
                  Navigator.of(context).pop();
                }),
          ),
        ],
      ),
    );
  }
}
