import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:survey_io/common/components/text_button.dart';
import 'package:survey_io/pages/survey_design/survey_design.dart';
import '../../../common/components/input_field_text.dart';
import '../../../common/components/label.dart';
import '../../../common/constants/padding.dart';
import '../../../common/components/appbar_plain.dart';
import '../../../common/components/divider.dart';
import '../../../common/constants/colors.dart';

import '../../datasources/survey_design/repository/localRepositoryAge.dart';
import '../../datasources/survey_design/repository/localRepositoryChildren.dart';
import '../../datasources/survey_design/repository/localRepositoryGender.dart';
import '../../datasources/survey_design/repository/localRepositoryIncome.dart';
import '../../datasources/survey_design/repository/localRepositoryOccupation.dart';
import '../../datasources/survey_design/repository/localRepositoryOutcome.dart';
import '../../datasources/survey_design/repository/localRepositoryRegion.dart';
import '../../datasources/survey_design/repository/localRepositoryReligion.dart';
import '../../datasources/survey_design/repository/localRepositoryMarital.dart';

import 'widgets/modal_option_age.dart';
import 'widgets/modal_option_gender.dart';
import 'widgets/modal_option_income.dart';
import 'widgets/modal_option_marital.dart';
import 'widgets/modal_option_outcome.dart';
import 'widgets/modal_option_region.dart';
import 'widgets/modal_option_religion.dart';
import 'widgets/modal_option_occupation.dart';
import 'widgets/modal_option_children.dart';

class DemographyOption extends StatefulWidget {
  const DemographyOption({super.key});

  @override
  State<DemographyOption> createState() => _DemographyOptionState();
}

class _DemographyOptionState extends State<DemographyOption> {
  final ageRepository = LocalRepositoryDemographyAge();
  final genderRepository = LocalRepositoryDemographyGender();
  final religionRepository = LocalRepositoryDemographyReligion();
  final occupationRepository = LocalRepositoryDemographyOccupation();
  final maritalRepository = LocalRepositoryDemographyMarital();
  final childrenRepository = LocalRepositoryDemographyChildren();
  final regionRepository = LocalRepositoryDemographyRegion();
  final incomeRepository = LocalRepositoryDemographyIncome();
  final outcomeRepository = LocalRepositoryDemographyOutcome();

  // Text Editing
  TextEditingController inputDemographyAge = TextEditingController();
  TextEditingController inputDemographyGender = TextEditingController();
  TextEditingController inputDemographyReligion = TextEditingController();
  TextEditingController inputDemographyOccupation = TextEditingController();
  TextEditingController inputDemographyMarital = TextEditingController();
  TextEditingController inputDemographyChildren = TextEditingController();
  TextEditingController inputDemographyRegion = TextEditingController();
  TextEditingController inputDemographyIncome = TextEditingController();
  TextEditingController inputDemographyOutcome = TextEditingController();

  // Variabel
  List<String> selectedScopeAge = [];
  List<int> selectedIdAge = [];

  int selectedIdGender = 0;
  String selectedScopeGender = '';

  int selectedIdReligion = 0;
  String selectedScopeReligion = '';

  int selectedIdOccupation = 0;
  String selectedScopeOccupation = '';

  List<String> selectedScopeMarital = [];
  List<int> selectedIdMarital = [];

  List<String> selectedScopeChildren = [];
  List<int> selectedIdChildren = [];

  int selectedIdRegion = 0;
  String selectedScopeRegion = '';

  List<String> selectedScopeIncome = [];
  List<int> selectedIdIncome = [];

  List<String> selectedScopeOutcome = [];
  List<int> selectedIdOutcome = [];

  @override
  void initState() {
    super.initState();
    loadOptionAge();
    loadOptionGender();
    loadOptionReligion();
    loadOptionOccupation();
    loadOptionMarital();
    loadOptionChildren();
    loadOptionRegion();
    loadOptionIncome();
    loadOptionOutcome();
  }

  void updateState() {
    loadOptionAge();
    loadOptionGender();
    loadOptionReligion();
    loadOptionOccupation();
    loadOptionMarital();
    loadOptionChildren();
    loadOptionRegion();
    loadOptionIncome();
    loadOptionOutcome();
  }

  // Load Option Age From Shared References
  void loadOptionAge() async {
    final savedData = await ageRepository.getOption();
    if (savedData != null) {
      setState(() {
        selectedIdAge = (savedData['id'] as List<dynamic>).cast<int>();
        selectedScopeAge = (savedData['scope'] as List<dynamic>).cast<String>();
        inputDemographyAge.text =
            selectedScopeAge.isEmpty ? "Semua" : selectedScopeAge.join(', ');
      });
      print('Load Age Repository : $selectedScopeAge');
    } else {
      print('Age is Empty');
      setState(() {
        selectedIdAge.add(0);
        selectedScopeAge.add('Semua');
      });
      final data = {
        'id': selectedIdAge,
        'scope': selectedScopeAge,
      };
      final jsonData = jsonEncode(data);
      await ageRepository.setOption(jsonData);
    }
  }

  // Load Option Gender From Shared References
  void loadOptionGender() async {
    final savedData = await genderRepository.getOption();
    if (savedData != null) {
      setState(() {
        selectedIdGender = savedData['id'];
        selectedScopeGender = savedData['scope'];
        if (selectedScopeGender.isEmpty) {
          inputDemographyGender.text = "Semua";
        } else {
          inputDemographyGender.text = selectedScopeGender;
        }
      });
    } else {
      setState(() {
        selectedIdGender = 0;
        selectedScopeGender = 'Semua';
      });
      final data = {
        'id': selectedIdGender,
        'scope': selectedScopeGender,
      };
      final jsonData = jsonEncode(data);
      await genderRepository.setOption(jsonData);
    }
    print('Load Gender Repository : $selectedScopeGender');
  }

  // Load Option Occupation From Shared References
  void loadOptionOccupation() async {
    final savedData = await occupationRepository.getOption();
    if (savedData != null) {
      setState(() {
        selectedIdOccupation = savedData['id'];
        selectedScopeOccupation = savedData['scope'];
        if (selectedScopeOccupation.isEmpty) {
          inputDemographyOccupation.text = "Semua";
        } else {
          inputDemographyOccupation.text = selectedScopeOccupation;
        }
      });
    } else {
      setState(() {
        selectedIdOccupation = 0;
        selectedScopeOccupation = 'Semua';
      });
      final data = {
        'id': selectedIdOccupation,
        'scope': selectedScopeOccupation,
      };
      final jsonData = jsonEncode(data);
      await occupationRepository.setOption(jsonData);
    }
    print('Load Occupation Repository : $selectedScopeOccupation');
  }

  // Load Option Marital From Shared References
  void loadOptionMarital() async {
    final savedData = await maritalRepository.getOption();
    if (savedData != null) {
      setState(() {
        selectedIdMarital = (savedData['id'] as List<dynamic>).cast<int>();
        selectedScopeMarital =
            (savedData['scope'] as List<dynamic>).cast<String>();
        inputDemographyMarital.text = selectedScopeMarital.isEmpty
            ? "Semua"
            : selectedScopeMarital.join(', ');
      });
    } else {
      setState(() {
        selectedIdMarital.add(0);
        selectedScopeMarital.add('Semua');
      });
      final data = {
        'id': selectedIdMarital,
        'scope': selectedScopeMarital,
      };
      final jsonData = jsonEncode(data);
      await maritalRepository.setOption(jsonData);
    }
    print('Load Marital Repository : $selectedScopeMarital');
  }

  // Load Option Children From Shared References
  void loadOptionChildren() async {
    final savedData = await childrenRepository.getOption();
    if (savedData != null) {
      setState(() {
        selectedIdChildren = (savedData['id'] as List<dynamic>).cast<int>();
        selectedScopeChildren =
            (savedData['scope'] as List<dynamic>).cast<String>();
        inputDemographyChildren.text = selectedScopeChildren.isEmpty
            ? "Semua"
            : selectedScopeChildren.join(', ');
      });
    } else {
      setState(() {
        selectedIdChildren.add(0);
        selectedScopeChildren.add('Semua');
      });
      final data = {
        'id': selectedIdChildren,
        'scope': selectedScopeChildren,
      };
      final jsonData = jsonEncode(data);
      await childrenRepository.setOption(jsonData);
    }
    print('Load Children Repository : $selectedScopeChildren');
  }

  // Load Option Region From Shared References
  void loadOptionRegion() async {
    final savedData = await regionRepository.getOption();
    if (savedData != null) {
      setState(() {
        selectedIdRegion = savedData['id'];
        selectedScopeRegion = savedData['scope'];
        if (selectedScopeRegion.isEmpty) {
          inputDemographyRegion.text = "Semua";
        } else {
          inputDemographyRegion.text = selectedScopeRegion;
        }
      });
    } else {
      setState(() {
        selectedIdRegion = 0;
        selectedScopeRegion = 'Semua';
      });
      final data = {
        'id': selectedIdRegion,
        'scope': selectedScopeRegion,
      };
      final jsonData = jsonEncode(data);
      await regionRepository.setOption(jsonData);
    }
    print('Load Region Repository : $selectedScopeRegion');
  }

  // Load Option Religion From Shared References
  void loadOptionReligion() async {
    final savedData = await religionRepository.getOption();
    if (savedData != null) {
      setState(() {
        selectedIdReligion = savedData['id'];
        selectedScopeReligion = savedData['scope'];
        if (selectedScopeReligion.isEmpty) {
          inputDemographyReligion.text = "Semua";
        } else {
          inputDemographyReligion.text = selectedScopeReligion;
        }
      });
    } else {
      setState(() {
        selectedIdReligion = 0;
        selectedScopeReligion = 'Semua';
      });
      final data = {
        'id': selectedIdReligion,
        'scope': selectedScopeReligion,
      };
      final jsonData = jsonEncode(data);
      await religionRepository.setOption(jsonData);
    }
    print('Load Religion Repository : $selectedScopeReligion');
  }

  // Load Option Income From Shared References
  void loadOptionIncome() async {
    final savedData = await incomeRepository.getOption();
    if (savedData != null) {
      setState(() {
        selectedIdIncome = (savedData['id'] as List<dynamic>).cast<int>();
        selectedScopeIncome =
            (savedData['scope'] as List<dynamic>).cast<String>();
        inputDemographyIncome.text = selectedScopeIncome.isEmpty
            ? "Semua"
            : selectedScopeIncome.join(', ');
      });
    } else {
      setState(() {
        selectedIdIncome.add(0);
        selectedScopeIncome.add('Semua');
      });
      final data = {
        'id': selectedIdIncome,
        'scope': selectedScopeIncome,
      };
      final jsonData = jsonEncode(data);
      await incomeRepository.setOption(jsonData);
    }
    print('Load Income Repository : $selectedScopeIncome');
  }

  // Load Option Outcome From Shared References
  void loadOptionOutcome() async {
    final savedData = await outcomeRepository.getOption();
    if (savedData != null) {
      setState(() {
        selectedIdOutcome = (savedData['id'] as List<dynamic>).cast<int>();
        selectedScopeOutcome =
            (savedData['scope'] as List<dynamic>).cast<String>();
        inputDemographyOutcome.text = selectedScopeOutcome.isEmpty
            ? "Semua"
            : selectedScopeOutcome.join(', ');
      });
    } else {
      setState(() {
        selectedIdOutcome.add(0);
        selectedScopeOutcome.add('Semua');
      });
      final data = {
        'id': selectedIdOutcome,
        'scope': selectedScopeOutcome,
      };
      final jsonData = jsonEncode(data);
      await outcomeRepository.setOption(jsonData);
    }
    print('Load Outcome Repository : $selectedScopeOutcome');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PlainAppBar(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const SurveyDesign(
                          designAction: 'Create',
                        )));
          },
          leadingIcon: Icons.close,
          iconColor: AppColors.black),
      body: Column(
        children: [
          Container(
            padding: CustomPadding.px2,
            child: const LabelHeading(
                labelText: 'Atur Demografi', labelColor: AppColors.secondary),
          ),
          Expanded(
              child: Container(
            padding: CustomPadding.p2,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CustomDividers.verySmallDivider(),
                  GestureDetector(
                    onTap: () {
                      _showModalAge(context);
                    },
                    child: TextInputField(
                      controller: inputDemographyAge,
                      editable: false,
                      hintText: 'Semua',
                      labelText: 'Usia',
                      keyboardType: TextInputType.text,
                      suffixIcon: Icon(
                        selectedScopeAge.isEmpty ? Icons.add : Icons.edit,
                        color: AppColors.info,
                      ),
                    ),
                  ),
                  CustomDividers.verySmallDivider(),
                  GestureDetector(
                    onTap: () {
                      _showModalGender(context);
                    },
                    child: TextInputField(
                      controller: inputDemographyGender,
                      editable: false,
                      hintText: 'Semua',
                      labelText: 'Jenis Kelamin',
                      keyboardType: TextInputType.text,
                      suffixIcon: Icon(
                        selectedScopeGender == '' ? Icons.add : Icons.edit,
                        color: AppColors.info,
                      ),
                    ),
                  ),
                  CustomDividers.verySmallDivider(),
                  GestureDetector(
                    onTap: () {
                      _showModalReligion(context);
                    },
                    child: TextInputField(
                      controller: inputDemographyReligion,
                      editable: false,
                      hintText: 'Semua',
                      labelText: 'Agama',
                      keyboardType: TextInputType.text,
                      suffixIcon: Icon(
                        selectedScopeReligion == '' ? Icons.add : Icons.edit,
                        color: AppColors.info,
                      ),
                    ),
                  ),
                  CustomDividers.verySmallDivider(),
                  GestureDetector(
                    onTap: () {
                      _showModalOccupation(context);
                    },
                    child: TextInputField(
                      controller: inputDemographyOccupation,
                      editable: false,
                      hintText: 'Semua',
                      labelText: 'Status Pekerjaan',
                      keyboardType: TextInputType.text,
                      suffixIcon: Icon(
                        selectedScopeOccupation == '' ? Icons.add : Icons.edit,
                        color: AppColors.info,
                      ),
                    ),
                  ),
                  CustomDividers.verySmallDivider(),
                  GestureDetector(
                    onTap: () {
                      _showModalMarital(context);
                    },
                    child: TextInputField(
                      controller: inputDemographyMarital,
                      editable: false,
                      hintText: 'Semua',
                      labelText: 'Status Pernikahan',
                      keyboardType: TextInputType.text,
                      suffixIcon: Icon(
                        selectedScopeMarital.isEmpty ? Icons.add : Icons.edit,
                        color: AppColors.info,
                      ),
                    ),
                  ),
                  CustomDividers.verySmallDivider(),
                  GestureDetector(
                    onTap: () {
                      _showModalChildren(context);
                    },
                    child: TextInputField(
                      controller: inputDemographyChildren,
                      editable: false,
                      hintText: 'Semua',
                      labelText: 'Jumlah Anak',
                      keyboardType: TextInputType.text,
                      suffixIcon: Icon(
                        selectedScopeChildren.isEmpty ? Icons.add : Icons.edit,
                        color: AppColors.info,
                      ),
                    ),
                  ),
                  CustomDividers.verySmallDivider(),
                  GestureDetector(
                    onTap: () {
                      _showModalRegion(context);
                    },
                    child: TextInputField(
                      controller: inputDemographyRegion,
                      editable: false,
                      hintText: 'Semua',
                      labelText: 'Wilayah',
                      keyboardType: TextInputType.text,
                      suffixIcon: Icon(
                        selectedScopeRegion == '' ? Icons.add : Icons.edit,
                        color: AppColors.info,
                      ),
                    ),
                  ),
                  CustomDividers.verySmallDivider(),
                  GestureDetector(
                    onTap: () {
                      _showModalIncome(context);
                    },
                    child: TextInputField(
                      controller: inputDemographyIncome,
                      editable: false,
                      hintText: 'Semua',
                      labelText: 'Pendapatan per Bulan',
                      keyboardType: TextInputType.text,
                      suffixIcon: Icon(
                        selectedScopeIncome.isEmpty ? Icons.add : Icons.edit,
                        color: AppColors.info,
                      ),
                    ),
                  ),
                  CustomDividers.verySmallDivider(),
                  GestureDetector(
                    onTap: () {
                      _showModalOutcome(context);
                    },
                    child: TextInputField(
                      controller: inputDemographyOutcome,
                      editable: false,
                      hintText: 'Semua',
                      labelText: 'Pengeluaran per Bulan',
                      keyboardType: TextInputType.text,
                      suffixIcon: Icon(
                        selectedScopeOutcome.isEmpty ? Icons.add : Icons.edit,
                        color: AppColors.info,
                      ),
                    ),
                  ),
                  CustomDividers.smallDivider(),
                  TextButtonFilled.primary(
                      text: 'Ok',
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SurveyDesign(
                                    designAction: 'Create')));
                      })
                ],
              ),
            ),
          ))
        ],
      ),
    );
  }

  void _showModalAge(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      isScrollControlled: true,
      builder: (BuildContext context) {
        return ModalOptionAge(
          onUpdate: () {
            updateState();
          },
        );
      },
    );
  }

  void _showModalGender(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      isScrollControlled: true,
      builder: (BuildContext context) {
        return ModalOptionGender(
          onUpdate: () {
            updateState();
          },
        );
      },
    );
  }

  void _showModalReligion(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      isScrollControlled: true,
      builder: (BuildContext context) {
        return ModalOptionReligion(
          onUpdate: () {
            updateState();
          },
        );
      },
    );
  }

  void _showModalOccupation(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      isScrollControlled: true,
      builder: (BuildContext context) {
        return ModalOptionOccupation(
          onUpdate: () {
            updateState();
          },
        );
      },
    );
  }

  void _showModalMarital(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      isScrollControlled: true,
      builder: (BuildContext context) {
        return ModalOptionMarital(
          onUpdate: () {
            updateState();
          },
        );
      },
    );
  }

  void _showModalChildren(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      isScrollControlled: true,
      builder: (BuildContext context) {
        return ModalOptionChildren(
          onUpdate: () {
            updateState();
          },
        );
      },
    );
  }

  void _showModalRegion(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      isScrollControlled: true,
      builder: (BuildContext context) {
        return ModalOptionRegion(
          onUpdate: () {
            updateState();
          },
        );
      },
    );
  }

  void _showModalIncome(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      isScrollControlled: true,
      builder: (BuildContext context) {
        return ModalOptionIncome(
          onUpdate: () {
            updateState();
          },
        );
      },
    );
  }

  void _showModalOutcome(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      isScrollControlled: true,
      builder: (BuildContext context) {
        return ModalOptionOutcome(
          onUpdate: () {
            updateState();
          },
        );
      },
    );
  }
}
