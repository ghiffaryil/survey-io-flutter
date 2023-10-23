import 'package:flutter/material.dart';
import '../../../common/components/input_field_text.dart';
import '../../../common/components/label.dart';
import '../../../common/constants/padding.dart';
import '../../../common/components/appbar_plain.dart';
import '../../../common/components/divider.dart';
import '../../../common/constants/colors.dart';
import '../../../common/constants/styles.dart';
import '../data/repository/local/localRepositoryAge.dart';
import '../data/repository/local/localRepositoryGender.dart';
import '../data/repository/local/localRepositoryOccupation.dart';
import '../data/repository/local/localRepositoryReligion.dart';
import 'widgets/modal_option_age.dart';
import 'widgets/modal_option_gender.dart';
import 'widgets/modal_option_regligion.dart';
import 'widgets/modal_option_occupation.dart';

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

  // Text Editing
  TextEditingController inputDemographyAge = TextEditingController();
  TextEditingController inputDemographyGender = TextEditingController();
  TextEditingController inputDemographyReligion = TextEditingController();
  TextEditingController inputDemographyOccupation = TextEditingController();

  // Variabel
  List<String> selectedScopeAge = [];
  List<int> selectedIdAge = [];

  int selectedIdGender = 0;
  String selectedScopeGender = '';

  int selectedIdReligion = 0;
  String selectedScopeReligion = '';

  int selectedIdOccupation = 0;
  String selectedScopeOccupation = '';

  @override
  void initState() {
    super.initState();

    inputDemographyAge.text = '...';
    inputDemographyGender.text = '...';
    inputDemographyReligion.text = '...';
    inputDemographyOccupation.text = '...';

    loadOptionAge();
    loadOptionGender();
    loadOptionReligion();
    loadOptionOccupation();
  }

  void updateState() {
    loadOptionAge();
    loadOptionGender();
    loadOptionReligion();
    loadOptionOccupation();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PlainAppBar(
          onPressed: () {
            Navigator.pop(context);
          },
          leadingIcon: Icons.close,
          iconColor: AppColors.black),
      body: Container(
        padding: CustomPadding.p2,
        child: Column(
          children: [
            const LabelHeading(
                labelText: 'Atur Demografi', labelColor: AppColors.secondary),
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  CustomDividers.regularDivider(),
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
                ],
              ),
            ))
          ],
        ),
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
}
