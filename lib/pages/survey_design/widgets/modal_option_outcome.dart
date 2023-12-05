import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:survey_io/models/survey_design/data/demography_outcome_model.dart';

import '../../../../common/components/notice_card.dart';
import '../../../../common/components/divider.dart';
import '../../../../common/components/checkbox.dart';
import '../../../../common/constants/colors.dart';
import '../../../../common/constants/widgets/indicator.dart';
import '../../../../common/constants/styles.dart';
import '../../../../common/components/elevated_button.dart';
import '../../../../common/constants/padding.dart';
import '../../../datasources/survey_design/data/list_demography_outcome.dart';
import '../../../datasources/survey_design/repository/localRepositoryOutcome.dart';

class ModalOptionOutcome extends StatefulWidget {
  final void Function() onUpdate;

  const ModalOptionOutcome({super.key, required this.onUpdate});

  @override
  State<ModalOptionOutcome> createState() => _ModalOptionOutcomeState();
}

class _ModalOptionOutcomeState extends State<ModalOptionOutcome> {
  final List<DemographyOutcomeModel> list =
      ListDemographyOutcome.getDemographyOutcomeList();
  final outcomeRepository = LocalRepositoryDemographyOutcome();

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
    await outcomeRepository.setOption(jsonData);
  }

  // Load from Shared References
  void onLoad() async {
    final savedData = await outcomeRepository.getOption();
    if (savedData != null) {
      setState(() {
        selectedId = (savedData['id'] as List<dynamic>).cast<int>();
        selectedScope = (savedData['scope'] as List<dynamic>).cast<String>();
        selectAll = selectedScope.isEmpty ? true : false;
        print('Load Selected Outcome');
        print(selectedScope);
      });
    } else {
      print('Outcome is Empty');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
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
              'Pengeluaran Bulanan',
              style: TextStyles.h2(color: AppColors.secondary),
            ),
          ),
          Container(
            padding: CustomPadding.p1,
            child: Text(
              'Rp25.000 - 100.000 / 50 Responden',
              style: TextStyles.extraLarge(color: AppColors.secondary),
            ),
          ),
          CustomDividers.verySmallDivider(),
          Expanded(
            child: SingleChildScrollView(
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: list.length + 1,
                separatorBuilder: ((context, index) {
                  return const Divider();
                }),
                itemBuilder: (BuildContext context, int index) {
                  if (index == 0) {
                    return ListTile(
                      dense: true,
                      visualDensity:
                          const VisualDensity(horizontal: 0, vertical: -4),
                      title: Text(
                        'Semua pendapatan',
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
                        dense: true,
                        visualDensity:
                            const VisualDensity(horizontal: 0, vertical: -4),
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
                                selectedId.add(item.id);
                                selectedScope.add(item.scope);
                              } else {
                                selectedId.remove(item.id);
                                selectedScope.remove(item.scope);
                              }
                              selectedId.sort();

                              selectedScope.sort((a, b) {
                                final indexA =
                                    list.indexWhere((item) => item.scope == a);
                                final indexB =
                                    list.indexWhere((item) => item.scope == b);
                                return selectedId.indexOf(indexA) -
                                    selectedId.indexOf(indexB);
                              });

                              // If All option selected
                              if (selectedId.length == list.length) {
                                selectAll = true;
                                selectedId.clear();
                                selectedScope.clear();
                              } else if (selectedId.isEmpty) {
                                // If no one selected
                                selectAll = true;
                                selectedId.clear();
                                selectedScope.clear();
                              } else {
                                // If at least one option selected but not of all
                                selectAll = false;
                                selectedId.remove(0);
                                selectedScope.remove('Semua');
                              }
                            });
                          },
                        ));
                  }
                },
              ),
            ),
          ),
          const NoticeCard(
            text:
                'Jumlah responden belum tentu sama banyaknya dari setiap kategori, karena tergantung pada kecepatan responden mengambil survei.',
            textLink: 'Klik disini untuk info lanjut',
          ),
          CustomDividers.regularDivider(),
          ButtonFilled.primary(
              text: 'OK',
              onPressed: () {
                onSave();
                onLoad();
                widget.onUpdate();
                Navigator.of(context).pop();
              }),
        ],
      ),
    );
  }
}
