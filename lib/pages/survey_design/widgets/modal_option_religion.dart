import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/constants/widgets/indicator.dart';
import '../../../../common/components/divider.dart';
import '../../../../common/constants/colors.dart';
import '../../../../common/constants/styles.dart';
import '../../../../common/constants/padding.dart';
import '../../../../common/components/elevated_button.dart';

import 'package:survey_io/datasources/survey_design/repository/localRepositoryReligion.dart';
import 'package:survey_io/bloc/survey_design/survey_design_demography/survey_design_list_demography_religion/survey_design_list_demography_religion_bloc.dart';

class ModalOptionReligion extends StatefulWidget {
  final void Function() onUpdate;
  const ModalOptionReligion({super.key, required this.onUpdate});

  @override
  State<ModalOptionReligion> createState() => _ModalOptionReligionState();
}

class _ModalOptionReligionState extends State<ModalOptionReligion> {
  final repository = LocalRepositoryDemographyReligion();

  // Selected Religion
  int selectedId = 0;
  String selectedScope = 'Semua';
  bool selectAll = false;

  @override
  void initState() {
    super.initState();
    selectedScope = '';
    context.read<SurveyDesignListDemographyReligionBloc>().add(
        const SurveyDesignListDemographyReligionEvent
            .getListDemographyReligion());
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
              child: BlocBuilder<SurveyDesignListDemographyReligionBloc,
                  SurveyDesignListDemographyReligionState>(
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
                          return const Divider(
                            thickness: 0.3,
                          );
                        }),
                        itemBuilder: (BuildContext context, int index) {
                          final item = data[index];
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
                      );
                    },
                  );
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
