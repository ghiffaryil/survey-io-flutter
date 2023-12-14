import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/components/notice_card.dart';
import '../../../../common/components/divider.dart';
import '../../../../common/components/checkbox.dart';
import '../../../../common/constants/colors.dart';
import '../../../../common/constants/widgets/indicator.dart';
import '../../../../common/constants/styles.dart';
import '../../../../common/components/elevated_button.dart';
import '../../../../common/constants/padding.dart';

import 'package:survey_io/datasources/survey_design/repository/localRepositoryOutcome.dart';
import 'package:survey_io/bloc/survey_design/survey_design_demography/survey_design_list_demography_outcome/survey_design_list_demography_outcome_bloc.dart';

class ModalOptionOutcome extends StatefulWidget {
  final void Function() onUpdate;

  const ModalOptionOutcome({super.key, required this.onUpdate});

  @override
  State<ModalOptionOutcome> createState() => _ModalOptionOutcomeState();
}

class _ModalOptionOutcomeState extends State<ModalOptionOutcome> {
  
  final outcomeRepository = LocalRepositoryDemographyOutcome();

  List<int> selectedId = [];
  List<String> selectedScope = [];
  bool selectAll = false;

  @override
  void initState() {
    super.initState();
    selectedScope = [];
    context.read<SurveyDesignListDemographyOutcomeBloc>().add(
        const SurveyDesignListDemographyOutcomeEvent
            .getListDemographyOutcome());
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
      height: MediaQuery.of(context).size.height * 0.85,
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          color: Colors.white),
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
              child: BlocBuilder<SurveyDesignListDemographyOutcomeBloc,
                  SurveyDesignListDemographyOutcomeState>(
                builder: (context, state) {
                  return state.maybeWhen(
                    orElse: () {
                      return Container();
                    },
                    loading: () {
                      return Container();
                    },
                    error: (message) {
                      return Text(message);
                    },
                    loaded: (data) {
                      if (selectedId.isEmpty && selectedScope.isEmpty) {
                        selectedId.add(0);
                        selectedScope.add('Semua');
                      }

                      void clearSelection() {
                        selectedId.clear();
                        selectedScope.clear();
                      }

                      void selectAllItem() {
                        selectAll = true;
                        selectedId.add(0);
                        selectedScope.add('Semua');
                      }

                      return ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: data.length,
                        separatorBuilder: ((context, index) {
                          return const Divider(
                            thickness: 0.3,
                          );
                        }),
                        itemBuilder: (BuildContext context, int index) {
                          final item = data[index];
                          return ListTile(
                              dense: true,
                              visualDensity: const VisualDensity(
                                  horizontal: 0, vertical: -4),
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
                                    // IF CHECKED
                                    if (value == true) {
                                      selectedId.add(item.id);
                                      selectedScope.add(item.scope);
                                    } else {
                                      // IF UNCHECK
                                      selectedId.remove(item.id);
                                      selectedScope.remove(item.scope);
                                    }

                                    // IF NO ONE SELECTED
                                    if (selectedId.isEmpty) {
                                      clearSelection();
                                      selectAllItem();
                                      // IF CHOOSE 'SEMUA'
                                    } else if (item.id == 0) {
                                      clearSelection();
                                      selectAllItem();
                                    } else if (selectedId.length ==
                                            data.length - 1 &&
                                        !selectedId.contains(0)) {
                                      // IF ALL OPTION SELECTED
                                      clearSelection();
                                      selectAllItem();
                                    } else {
                                      // IF AT LEAST ONE OPTION SELECTED BUT NOT OF ALL
                                      selectAll = false;
                                      selectedId.remove(0);
                                      selectedScope.remove('Semua');

                                      int count = selectedId.length;
                                      int firstArray = selectedId.first;
                                      int lastArray = selectedId.last;

                                      // IF CHOICE > THAN 1
                                      if (count > 1) {
                                        for (int i = firstArray + 1;
                                            i <= lastArray;
                                            i++) {
                                          if (!selectedId.contains(i)) {
                                            selectedId.add(i);
                                            final correspondingScope = data
                                                .firstWhere(
                                                    (item) => item.id == i)
                                                .scope;
                                            selectedScope
                                                .add(correspondingScope);
                                          }
                                        }
                                      }
                                    }

                                    selectedId.sort();

                                    if (selectedId.length == data.length - 1) {
                                      clearSelection();
                                      selectAllItem();
                                    }

                                    selectedScope.sort((a, b) {
                                      final indexA = data.indexWhere(
                                          (item) => item.scope == a);
                                      final indexB = data.indexWhere(
                                          (item) => item.scope == b);
                                      return selectedId.indexOf(indexA) -
                                          selectedId.indexOf(indexB);
                                    });

                                    print(selectAll);
                                    print(selectedId);
                                    print(selectedScope);
                                  });
                                },
                              ));
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ),
          const NoticeCard(
            text:
                'Jumlah responden belum tentu sama banyaknya dari setiap kategori, karena tergantung pada kecepatan responden mengambil survei.',
            textLink: 'Klik disini untuk info lanjut',
          ),
          CustomDividers.smallDivider(),
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
