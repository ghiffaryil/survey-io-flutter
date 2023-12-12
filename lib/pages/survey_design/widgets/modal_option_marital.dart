import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:survey_io/bloc/survey_design/survey_design_demography/survey_design_list_demography_marital/survey_design_list_demography_marital_bloc.dart';
import 'package:survey_io/models/survey_design/data/demography_marital_model.dart';

import '../../../../common/components/notice_card.dart';
import '../../../../common/components/divider.dart';
import '../../../../common/components/checkbox.dart';
import '../../../../common/constants/colors.dart';
import '../../../../common/constants/widgets/indicator.dart';
import '../../../../common/constants/styles.dart';
import '../../../../common/components/elevated_button.dart';
import '../../../../common/constants/padding.dart';

import '../../../datasources/survey_design/data/list_demography_marital.dart';
import '../../../datasources/survey_design/repository/localRepositoryMarital.dart';

class ModalOptionMarital extends StatefulWidget {
  final void Function() onUpdate;

  const ModalOptionMarital({super.key, required this.onUpdate});

  @override
  State<ModalOptionMarital> createState() => _ModalOptionMaritalState();
}

class _ModalOptionMaritalState extends State<ModalOptionMarital> {
  final List<DemographyMaritalModel> list =
      ListDemographyMarital.getDemographyMaritalList();
  final maritalRepository = LocalRepositoryDemographyMarital();

  List<int> selectedId = [];
  List<String> selectedScope = [];
  bool selectAll = false;

  @override
  void initState() {
    super.initState();
    selectedScope = [];
    context.read<SurveyDesignListDemographyMaritalBloc>().add(
        const SurveyDesignListDemographyMaritalEvent
            .getListDemographyMarital());
    onLoad();
  }

  // Save to Shared References
  void onSave() async {
    final data = {
      'id': selectedId,
      'scope': selectedScope,
    };
    final jsonData = jsonEncode(data);
    await maritalRepository.setOption(jsonData);
  }

  // Load from Shared References
  void onLoad() async {
    final savedData = await maritalRepository.getOption();
    if (savedData != null) {
      setState(() {
        selectedId = (savedData['id'] as List<dynamic>).cast<int>();
        selectedScope = (savedData['scope'] as List<dynamic>).cast<String>();
        selectAll = selectedScope.isEmpty ? true : false;
        print('Load Selected Age');
        print(selectedScope);
      });
    } else {
      print('Marital is Empty');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
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
              'Status Pernikahan',
              style: TextStyles.h2(color: AppColors.secondary),
            ),
          ),
          Container(
            padding: CustomPadding.p1,
            child: Text(
              'Rp80.000 - 120.000 / 50 Responden',
              style: TextStyles.extraLarge(color: AppColors.secondary),
            ),
          ),
          CustomDividers.verySmallDivider(),
          Expanded(
            child: SingleChildScrollView(
              child: BlocBuilder<SurveyDesignListDemographyMaritalBloc,
                  SurveyDesignListDemographyMaritalState>(
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
          CustomDividers.smallDivider(),
        ],
      ),
    );
  }
}
