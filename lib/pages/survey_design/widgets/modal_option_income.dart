import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:survey_io/bloc/survey_design/survey_design_demography/survey_design_list_demography_income/survey_design_list_demography_income_bloc.dart';
import 'package:survey_io/models/survey_design/data/demography_income_model.dart';

import '../../../../common/components/notice_card.dart';
import '../../../../common/components/divider.dart';
import '../../../../common/components/checkbox.dart';
import '../../../../common/constants/colors.dart';
import '../../../../common/constants/widgets/indicator.dart';
import '../../../../common/constants/styles.dart';
import '../../../../common/components/elevated_button.dart';
import '../../../../common/constants/padding.dart';

import '../../../datasources/survey_design/data/list_demography_income.dart';
import '../../../datasources/survey_design/repository/localRepositoryIncome.dart';

class ModalOptionIncome extends StatefulWidget {
  final void Function() onUpdate;

  const ModalOptionIncome({super.key, required this.onUpdate});

  @override
  State<ModalOptionIncome> createState() => _ModalOptionIncomeState();
}

class _ModalOptionIncomeState extends State<ModalOptionIncome> {
  final List<DemographyIncomeModel> list =
      ListDemographyIncome.getDemographyIncomeList();
  final incomeRepository = LocalRepositoryDemographyIncome();

  List<int> selectedId = [];
  List<String> selectedScope = [];
  bool selectAll = false;

  @override
  void initState() {
    super.initState();
    selectedScope = [];
    context.read<SurveyDesignListDemographyIncomeBloc>().add(
        const SurveyDesignListDemographyIncomeEvent.getListDemographyIncome());
    onLoad();
  }

  // Save to Shared References
  void onSave() async {
    final data = {
      'id': selectedId,
      'scope': selectedScope,
    };
    final jsonData = jsonEncode(data);
    await incomeRepository.setOption(jsonData);
  }

  // Load from Shared References
  void onLoad() async {
    final savedData = await incomeRepository.getOption();
    if (savedData != null) {
      setState(() {
        selectedId = (savedData['id'] as List<dynamic>).cast<int>();
        selectedScope = (savedData['scope'] as List<dynamic>).cast<String>();
        selectAll = selectedScope.isEmpty ? true : false;
        print('Load Selected Income');
        print(selectedScope);
      });
    } else {
      print('Income is Empty');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
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
              'Pendapatan Bulanan',
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
              child: BlocBuilder<SurveyDesignListDemographyIncomeBloc,
                  SurveyDesignListDemographyIncomeState>(
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
                      return ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: data.length,
                        separatorBuilder: ((context, index) {
                          return const Divider();
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
                                    if (value == true) {
                                      selectedId.add(item.id);
                                      selectedScope.add(item.scope);
                                    } else {
                                      selectedId.remove(item.id);
                                      selectedScope.remove(item.scope);
                                    }
                                    selectedId.sort();

                                    selectedScope.sort((a, b) {
                                      final indexA = data.indexWhere(
                                          (item) => item.scope == a);
                                      final indexB = data.indexWhere(
                                          (item) => item.scope == b);
                                      return selectedId.indexOf(indexA) -
                                          selectedId.indexOf(indexB);
                                    });

                                    // If All option selected
                                    if (selectedId.length == data.length) {
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
