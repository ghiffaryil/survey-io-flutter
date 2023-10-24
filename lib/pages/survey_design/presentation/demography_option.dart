import 'package:flutter/material.dart';
import '../../../common/components/input_field_text.dart';
import '../../../common/components/label.dart';
import '../../../common/constants/padding.dart';
import '../../../common/components/appbar_plain.dart';
import '../../../common/components/divider.dart';
import '../../../common/constants/colors.dart';
import '../../../common/constants/styles.dart';

import '../data/repository/local/localRepositoryAge.dart';
import '../data/repository/local/localRepositoryChildren.dart';
import '../data/repository/local/localRepositoryGender.dart';
import '../data/repository/local/localRepositoryIncome.dart';
import '../data/repository/local/localRepositoryOccupation.dart';
import '../data/repository/local/localRepositoryOutcome.dart';
import '../data/repository/local/localRepositoryRegion.dart';
import '../data/repository/local/localRepositoryReligion.dart';
import '../data/repository/local/localRepositoryMarital.dart';

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
      print('Load Age Repository');
      setState(() {
        selectedIdAge = (savedData['id'] as List<dynamic>).cast<int>();
        selectedScopeAge = (savedData['scope'] as List<dynamic>).cast<String>();
        inputDemographyAge.text =
            selectedScopeAge.isEmpty ? "Semua" : selectedScopeAge.join(', ');
      });
      print(selectedScopeAge);
    } else {
      print('Age is Empty');
    }
  }

  // Load Option Gender From Shared References
  void loadOptionGender() async {
    final savedData = await genderRepository.getOption();
    if (savedData != null) {
      print('Load Gender Repository');
      setState(() {
        selectedIdGender = savedData['id'];
        selectedScopeGender = savedData['scope'];
        if (selectedScopeGender.isEmpty) {
          inputDemographyGender.text = "Semua";
        } else {
          inputDemographyGender.text = selectedScopeGender;
        }
      });
      print(selectedScopeGender);
    } else {
      print('Gender is Empty');
    }
  }

  // Load Option Religion From Shared References
  void loadOptionReligion() async {
    final savedData = await religionRepository.getOption();
    if (savedData != null) {
      print('Load Religion Repository');
      setState(() {
        selectedIdReligion = savedData['id'];
        selectedScopeReligion = savedData['scope'];
        if (selectedScopeReligion.isEmpty) {
          inputDemographyReligion.text = "Semua";
        } else {
          inputDemographyReligion.text = selectedScopeReligion;
        }
      });
      print(selectedScopeReligion);
    } else {
      print('Religion is Empty');
    }
  }

  // Load Option Occupation From Shared References
  void loadOptionOccupation() async {
    final savedData = await occupationRepository.getOption();
    if (savedData != null) {
      print('Load Occupation Repository');
      setState(() {
        selectedIdOccupation = savedData['id'];
        selectedScopeOccupation = savedData['scope'];
        if (selectedScopeOccupation.isEmpty) {
          inputDemographyOccupation.text = "Semua";
        } else {
          inputDemographyOccupation.text = selectedScopeOccupation;
        }
      });
      print(selectedScopeOccupation);
    } else {
      print('Occupation is Empty');
    }
  }

  // Load Option Marital From Shared References
  void loadOptionMarital() async {
    final savedData = await maritalRepository.getOption();
    if (savedData != null) {
      print('Load Marital Repository');
      setState(() {
        selectedIdMarital = (savedData['id'] as List<dynamic>).cast<int>();
        selectedScopeMarital =
            (savedData['scope'] as List<dynamic>).cast<String>();
        inputDemographyMarital.text = selectedScopeMarital.isEmpty
            ? "Semua"
            : selectedScopeMarital.join(', ');
      });
      print(selectedScopeMarital);
    } else {
      print('Marital is Empty');
    }
  }

  // Load Option Children From Shared References
  void loadOptionChildren() async {
    final savedData = await childrenRepository.getOption();
    if (savedData != null) {
      print('Load Children Repository');
      setState(() {
        selectedIdChildren = (savedData['id'] as List<dynamic>).cast<int>();
        selectedScopeChildren =
            (savedData['scope'] as List<dynamic>).cast<String>();
        inputDemographyChildren.text = selectedScopeChildren.isEmpty
            ? "Semua"
            : selectedScopeChildren.join(', ');
      });
      print(selectedScopeChildren);
    } else {
      print('Children is Empty');
    }
  }

  // Load Option Region From Shared References
  void loadOptionRegion() async {
    final savedData = await regionRepository.getOption();
    if (savedData != null) {
      print('Load Region Repository');
      setState(() {
        selectedIdRegion = savedData['id'];
        selectedScopeRegion = savedData['scope'];
        if (selectedScopeRegion.isEmpty) {
          inputDemographyRegion.text = "Semua";
        } else {
          inputDemographyRegion.text = selectedScopeRegion;
        }
      });
      print(selectedScopeRegion);
    } else {
      print('Region is Empty');
    }
  }

  // Load Option Income From Shared References
  void loadOptionIncome() async {
    final savedData = await incomeRepository.getOption();
    if (savedData != null) {
      print('Load Income Repository');
      setState(() {
        selectedIdIncome = (savedData['id'] as List<dynamic>).cast<int>();
        selectedScopeIncome =
            (savedData['scope'] as List<dynamic>).cast<String>();
        inputDemographyIncome.text = selectedScopeIncome.isEmpty
            ? "Semua"
            : selectedScopeIncome.join(', ');
      });
      print(selectedScopeIncome);
    } else {
      print('Income is Empty');
    }
  }

  // Load Option Outcome From Shared References
  void loadOptionOutcome() async {
    final savedData = await outcomeRepository.getOption();
    if (savedData != null) {
      print('Load Outcome Repository');
      setState(() {
        selectedIdOutcome = (savedData['id'] as List<dynamic>).cast<int>();
        selectedScopeOutcome =
            (savedData['scope'] as List<dynamic>).cast<String>();
        inputDemographyOutcome.text = selectedScopeOutcome.isEmpty
            ? "Semua"
            : selectedScopeOutcome.join(', ');
      });
      print(selectedScopeOutcome);
    } else {
      print('Outcome is Empty');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PlainAppBar(
          onPressed: () {
            Navigator.pop(context);
          },
          leadingIcon: Icons.close,
          iconColor: AppColors.black),
      body: Column(
        children: [
          Container(
            padding: CustomPadding.p2,
            child: const LabelHeading(
                labelText: 'Atur Demografi', labelColor: AppColors.secondary),
          ),
          Expanded(
              child: Container(
            padding: CustomPadding.pdefault,
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
                      labelStyle: TextStyles.extraLarge(),
                      hintStyle: TextStyles.extraLarge(color: AppColors.black),
                      keyboardType: TextInputType.text,
                      suffixIcon: Icon(
                        selectedScopeAge.isEmpty ? Icons.add : Icons.edit,
                        color: AppColors.info,
                      ),
                    ),
                  ),
                  CustomDividers.smallDivider(),
                  GestureDetector(
                    onTap: () {
                      _showModalGender(context);
                    },
                    child: TextInputField(
                      controller: inputDemographyGender,
                      editable: false,
                      hintText: 'Semua',
                      labelText: 'Jenis Kelamin',
                      labelStyle: TextStyles.extraLarge(),
                      hintStyle: TextStyles.extraLarge(color: AppColors.black),
                      keyboardType: TextInputType.text,
                      suffixIcon: Icon(
                        selectedScopeGender == '' ? Icons.add : Icons.edit,
                        color: AppColors.info,
                      ),
                    ),
                  ),
                  CustomDividers.smallDivider(),
                  GestureDetector(
                    onTap: () {
                      _showModalReligion(context);
                    },
                    child: TextInputField(
                      controller: inputDemographyReligion,
                      editable: false,
                      hintText: 'Semua',
                      labelText: 'Agama',
                      labelStyle: TextStyles.extraLarge(),
                      hintStyle: TextStyles.extraLarge(color: AppColors.black),
                      keyboardType: TextInputType.text,
                      suffixIcon: Icon(
                        selectedScopeReligion == '' ? Icons.add : Icons.edit,
                        color: AppColors.info,
                      ),
                    ),
                  ),
                  CustomDividers.smallDivider(),
                  GestureDetector(
                    onTap: () {
                      _showModalOccupation(context);
                    },
                    child: TextInputField(
                      controller: inputDemographyOccupation,
                      editable: false,
                      hintText: 'Semua',
                      labelText: 'Status Pekerjaan',
                      labelStyle: TextStyles.extraLarge(),
                      hintStyle: TextStyles.extraLarge(color: AppColors.black),
                      keyboardType: TextInputType.text,
                      suffixIcon: Icon(
                        selectedScopeOccupation == '' ? Icons.add : Icons.edit,
                        color: AppColors.info,
                      ),
                    ),
                  ),
                  CustomDividers.smallDivider(),
                  GestureDetector(
                    onTap: () {
                      _showModalMarital(context);
                    },
                    child: TextInputField(
                      controller: inputDemographyMarital,
                      editable: false,
                      hintText: 'Semua',
                      labelText: 'Status Pernikahan',
                      labelStyle: TextStyles.extraLarge(),
                      hintStyle: TextStyles.extraLarge(color: AppColors.black),
                      keyboardType: TextInputType.text,
                      suffixIcon: Icon(
                        selectedScopeMarital.isEmpty ? Icons.add : Icons.edit,
                        color: AppColors.info,
                      ),
                    ),
                  ),
                  CustomDividers.smallDivider(),
                  GestureDetector(
                    onTap: () {
                      _showModalChildren(context);
                    },
                    child: TextInputField(
                      controller: inputDemographyChildren,
                      editable: false,
                      hintText: 'Semua',
                      labelText: 'Jumlah Anak',
                      labelStyle: TextStyles.extraLarge(),
                      hintStyle: TextStyles.extraLarge(color: AppColors.black),
                      keyboardType: TextInputType.text,
                      suffixIcon: Icon(
                        selectedScopeChildren.isEmpty ? Icons.add : Icons.edit,
                        color: AppColors.info,
                      ),
                    ),
                  ),
                  CustomDividers.smallDivider(),
                  GestureDetector(
                    onTap: () {
                      _showModalRegion(context);
                    },
                    child: TextInputField(
                      controller: inputDemographyRegion,
                      editable: false,
                      hintText: 'Semua',
                      labelText: 'Wilayah',
                      labelStyle: TextStyles.extraLarge(),
                      hintStyle: TextStyles.extraLarge(color: AppColors.black),
                      keyboardType: TextInputType.text,
                      suffixIcon: Icon(
                        selectedScopeRegion == '' ? Icons.add : Icons.edit,
                        color: AppColors.info,
                      ),
                    ),
                  ),
                  CustomDividers.smallDivider(),
                  GestureDetector(
                    onTap: () {
                      _showModalIncome(context);
                    },
                    child: TextInputField(
                      controller: inputDemographyIncome,
                      editable: false,
                      hintText: 'Semua',
                      labelText: 'Pendapatan per Bulan',
                      labelStyle: TextStyles.extraLarge(),
                      hintStyle: TextStyles.extraLarge(color: AppColors.black),
                      keyboardType: TextInputType.text,
                      suffixIcon: Icon(
                        selectedScopeIncome.isEmpty ? Icons.add : Icons.edit,
                        color: AppColors.info,
                      ),
                    ),
                  ),
                  CustomDividers.smallDivider(),
                  GestureDetector(
                    onTap: () {
                      _showModalOutcome(context);
                    },
                    child: TextInputField(
                      controller: inputDemographyOutcome,
                      editable: false,
                      hintText: 'Semua',
                      labelText: 'Pengeluaran per Bulan',
                      labelStyle: TextStyles.extraLarge(),
                      hintStyle: TextStyles.extraLarge(color: AppColors.black),
                      keyboardType: TextInputType.text,
                      suffixIcon: Icon(
                        selectedScopeOutcome.isEmpty ? Icons.add : Icons.edit,
                        color: AppColors.info,
                      ),
                    ),
                  ),
                  CustomDividers.mediumDivider(),
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
      backgroundColor: AppColors.white,
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
      backgroundColor: AppColors.white,
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
      backgroundColor: AppColors.white,
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
      backgroundColor: AppColors.white,
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
      backgroundColor: AppColors.white,
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
      backgroundColor: AppColors.white,
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
      backgroundColor: AppColors.white,
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
      backgroundColor: AppColors.white,
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
      backgroundColor: AppColors.white,
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
