import 'package:flutter/gestures.dart' show TapGestureRecognizer;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:survey_io/bloc/profile/edit_profile/edit_profile_bloc.dart';
import 'package:survey_io/common/components/appbar_plain.dart';
import 'package:survey_io/common/constants/icons.dart';
import 'package:survey_io/datasources/profile/profile_datasource.dart';
import 'package:survey_io/models/user/edit_profile_request_model.dart';
import 'package:survey_io/common/components/elevated_button.dart';
import 'package:survey_io/common/components/input_field_date.dart';
import 'package:survey_io/common/components/input_field_radio.dart';
import 'package:survey_io/common/components/input_field_text.dart';
import 'package:survey_io/common/constants/colors.dart';
import 'package:survey_io/common/constants/styles.dart';
import 'package:survey_io/common/components/divider.dart';
import 'package:survey_io/common/components/label.dart';
import 'package:survey_io/common/constants/padding.dart';
import 'package:survey_io/pages/survey_design/survey_design_list.dart';

class EditProfileComplete extends StatefulWidget {
  const EditProfileComplete({super.key});

  @override
  State<EditProfileComplete> createState() => _EditProfileCompleteState();
}

class _EditProfileCompleteState extends State<EditProfileComplete> {
  TextEditingController fullName = TextEditingController();
  TextEditingController placeOfBirth = TextEditingController();
  TextEditingController passcode = TextEditingController();
  TextEditingController inputKtpNumber = TextEditingController();
  TextEditingController inputNpwpNumber = TextEditingController();
  TextEditingController referalCode = TextEditingController();

  TextEditingController email = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController dateOfBirth = TextEditingController();

  FocusNode fullNameFocus = FocusNode();
  FocusNode placeOfBirthFocus = FocusNode();
  FocusNode passcodeFocus = FocusNode();
  FocusNode inputKtpNumberFocus = FocusNode();
  FocusNode inputNpwpNumberFocus = FocusNode();
  FocusNode referalCodeFocus = FocusNode();
  FocusNode dateOfBirthFocus = FocusNode();
  FocusNode emailFocus = FocusNode();
  FocusNode phoneNumberFocus = FocusNode();

  int userId = 0;
  int userActive = 0;
  String userCreatedTime = '';
  String userProvince = '';
  String userCity = '';
  String userProvider = '';
  String userPlatform = '';
  String createdTime = '';
  String userGender = '';
  String selectedGender = '';

  @override
  void initState() {
    super.initState();
    loadProfileInformation();
  }

  void loadProfileInformation() async {
    try {
      final result = await ProfileRemoteDatasource().getProfile();

      result.fold(
        (error) {
          print('Error: $error');
        },
        (data) {
          setState(() {
            userId = data.data.user.id;
            fullName.text = data.data.user.name;
            email.text = data.data.user.email;
            inputKtpNumber.text = data.data.userProfile.ktp;
            inputNpwpNumber.text = data.data.userProfile.npwp;
            phoneNumber.text = data.data.user.phoneNumber;
            DateTime localDob = data.data.userProfile.dob.toLocal();
            String formattedDob = DateFormat('dd-MM-yyyy').format(localDob);
            dateOfBirth.text = formattedDob;

            if (data.data.userProfile.gender == "man" ||
                data.data.userProfile.gender == "male" ||
                selectedGender == "Laki-laki") {
              selectedGender = "Laki-laki";
              userGender = "male";
            } else {
              selectedGender = "Perempuan";
              userGender = "female";
            }
          });
          userActive = data.data.user.active;
        },
      );
    } catch (e) {
      print('Exception: $e');
    }
  }

  void unfocusAll() {
    fullNameFocus.unfocus();
    placeOfBirthFocus.unfocus();
    passcodeFocus.unfocus();
    inputKtpNumberFocus.unfocus();
    inputNpwpNumberFocus.unfocus();
    referalCodeFocus.unfocus();
    dateOfBirthFocus.unfocus();
    emailFocus.unfocus();
    phoneNumberFocus.unfocus();
  }

  bool _validateForm() {
    if (fullName.text.isEmpty) {
      Fluttertoast.showToast(
        msg: 'Harap masukkan Nama Lengkap Anda',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: AppColors.secondary.withOpacity(0.8),
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return false;
    } else if (email.text.isEmpty) {
      Fluttertoast.showToast(
        msg: 'Harap masukkan Email Anda',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: AppColors.secondary.withOpacity(0.8),
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return false;
    } else if (dateOfBirth.text.isEmpty) {
      Fluttertoast.showToast(
        msg: 'Harap masukkan Tanggal Lahir Anda',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: AppColors.secondary.withOpacity(0.8),
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return false;
    } else if (phoneNumber.text.isEmpty) {
      Fluttertoast.showToast(
        msg: 'Harap masukkan Nomor Telepon Anda',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: AppColors.secondary.withOpacity(0.8),
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return false;
    } else if (inputKtpNumber.text.isEmpty) {
      Fluttertoast.showToast(
        msg: 'Harap masukkan Nomor KTP Anda',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: AppColors.secondary.withOpacity(0.8),
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return false;
    } else if (inputNpwpNumber.text.isEmpty) {
      Fluttertoast.showToast(
        msg: 'Harap masukkan Nomor NPWP Anda',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: AppColors.secondary.withOpacity(0.8),
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        unfocusAll();
      },
      child: Scaffold(
        appBar: PlainAppBar(
          leadingIcon: Icons.close,
          iconSize: 35.0,
          iconColor: AppColors.secondary,
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const SurveyDesignList();
            }));
          },
        ),
        body: Column(
          children: [
            Container(padding: CustomPadding.px2, child: labelText()),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: CustomPadding.p2,
                  child: Column(
                    children: [
                      formInputField(),
                      CustomDividers.smallDivider(),
                      labelTermAndCondition(),
                      CustomDividers.smallDivider(),
                      submitButton(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget labelText() {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
            'Sedikit Lagi....',
            style: TextStyles.h2(color: AppColors.secondary),
          ),
        ),
        CustomDividers.smallDivider(),
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
            '3. Lengkapi Profil Kamu',
            style: TextStyles.h4(color: AppColors.secondary),
          ),
        ),
        CustomDividers.smallDivider(),
      ],
    );
  }

  Widget formInputField() {
    return Column(
      children: [
        LabelInput(
          labelText: 'Nama Lengkap',
          labelStyle: TextStyles.h4(color: AppColors.secondary),
        ),
        CustomDividers.verySmallDivider(),
        TextInputField(
          focusNode: fullNameFocus,
          keyboardType: TextInputType.text,
          controller: fullName,
          hintText: 'Nama Lengkap',
        ),
        CustomDividers.smallDivider(),
        LabelInput(
          labelText: 'Jenis Kelamin',
          labelStyle: TextStyles.h4(color: AppColors.secondary),
        ),
        CustomDividers.verySmallDivider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                flex: 5,
                child: RadioTextInput(
                  value: 'Laki-laki',
                  selectedOption: selectedGender,
                  onChanged: (value) {
                    setState(() {
                      selectedGender = value;
                      userGender = 'male';
                      print(selectedGender);
                    });
                  },
                )),
            Container(
              width: 15,
            ),
            Expanded(
                flex: 5,
                child: RadioTextInput(
                  value: 'Perempuan',
                  selectedOption: selectedGender,
                  onChanged: (value) {
                    setState(() {
                      selectedGender = value;
                      userGender = 'female';
                      print(selectedGender);
                    });
                  },
                )),
          ],
        ),
        CustomDividers.smallDivider(),
        LabelInput(
          labelText: 'Tanggal Lahir',
          labelStyle: TextStyles.h4(color: AppColors.secondary),
        ),
        CustomDividers.verySmallDivider(),
        DateInputField(
          focusNode: dateOfBirthFocus,
          controller: dateOfBirth,
          hintText: '01-01-1991',
          firstDate: DateTime(1980),
          lastDate: DateTime.now(),
          showPrefixIcon: false,
          showSuffixIcon: true,
        ),
        CustomDividers.smallDivider(),
        LabelInput(
          labelText: 'No. Telepon',
          labelStyle: TextStyles.h4(color: AppColors.secondary),
        ),
        CustomDividers.verySmallDivider(),
        TextInputField(
          focusNode: phoneNumberFocus,
          keyboardType: TextInputType.phone,
          controller: phoneNumber,
          hintText: '081234567890',
          suffixIconPNG: userActive == 1 ? IconName.pollingCheckInfo : null,
        ),
        CustomDividers.smallDivider(),
        LabelInput(
          labelText: 'Email',
          labelStyle: TextStyles.h4(color: AppColors.secondary),
        ),
        CustomDividers.verySmallDivider(),
        TextInputField(
          focusNode: emailFocus,
          keyboardType: TextInputType.emailAddress,
          controller: email,
          hintText: 'Masukkan Email Kamu',
        ),
        CustomDividers.smallDivider(),
        LabelInput(
          labelText: 'No. KTP',
          labelStyle: TextStyles.h4(color: AppColors.secondary),
        ),
        CustomDividers.verySmallDivider(),
        TextInputField(
          focusNode: inputKtpNumberFocus,
          keyboardType: TextInputType.number,
          controller: inputKtpNumber,
          hintText: 'Masukkan No. KTP',
        ),
        CustomDividers.smallDivider(),
        LabelInput(
          labelText: 'No. NPWP',
          labelStyle: TextStyles.h4(color: AppColors.secondary),
        ),
        CustomDividers.verySmallDivider(),
        TextInputField(
          focusNode: inputNpwpNumberFocus,
          keyboardType: TextInputType.number,
          controller: inputNpwpNumber,
          hintText: 'Masukkan No. NPWP (Jika Ada)',
        ),
      ],
    );
  }

  Widget labelTermAndCondition() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            TextSpan(
                text: 'Dengan menekan “Submit”, kamu menyutujui',
                style: TextStyles.regular(color: AppColors.secondary)),
            TextSpan(
              text: ' Ketentuan Layanan',
              style: TextStyles.regular(color: AppColors.primary),
              recognizer: TapGestureRecognizer()..onTap = () {},
            ),
            TextSpan(
                text: ' Survei.io',
                style: TextStyles.regular(color: AppColors.secondary)),
          ],
        ),
      ),
    );
  }

  Widget submitButton() {
    return BlocListener<EditProfileBloc, EditProfileState>(
      listener: (context, state) {
        state.maybeWhen(
            orElse: () {},
            loaded: (data) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SurveyDesignList()));
            },
            error: (message) {
              Fluttertoast.showToast(
                  msg: message,
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: AppColors.light.withOpacity(0.3),
                  textColor: Colors.white,
                  fontSize: 16.0);
            });
      },
      child: BlocBuilder<EditProfileBloc, EditProfileState>(
        builder: (context, state) {
          return state.maybeWhen(
            orElse: () {
              return ButtonFilled.primary(
                  text: 'Submit',
                  onPressed: () {
                    if (_validateForm()) {
                      DateTime parsedDate =
                          DateFormat('dd-MM-yyyy').parse(dateOfBirth.text);
                      String formattedDate =
                          DateFormat('yyyy-MM-dd').format(parsedDate);
                      final requestModel = EditProfileRequestModel(
                          id: userId,
                          name: fullName.text,
                          email: email.text,
                          dob: formattedDate,
                          gender: userGender,
                          phoneNumber: phoneNumber.text,
                          ktp: inputKtpNumber.text,
                          npwp: inputNpwpNumber.text);
                      context
                          .read<EditProfileBloc>()
                          .add(EditProfileEvent.editProfile(requestModel));
                    }
                  });
            },
            loading: () {
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          );
        },
      ),
    );
  }
}
