import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:survey_io/datasources/profile/get_profile_datasource.dart';
import 'package:survey_io/pages/profile/profile.dart';
import 'package:survey_io/bloc/profile/edit_profile/edit_profile_bloc.dart';
import 'package:survey_io/bloc/profile/get_profile/profile_bloc.dart';
import 'package:survey_io/models/user/edit_profile_request_model.dart';
import 'package:survey_io/common/components/elevated_button.dart';
import 'package:survey_io/common/components/input_field_date.dart';
import 'package:survey_io/common/components/input_field_radio.dart';
import 'package:survey_io/common/components/input_field_text.dart';
import 'package:survey_io/common/constants/colors.dart';
import 'package:survey_io/common/constants/padding.dart';
import 'package:survey_io/common/constants/styles.dart';
import 'package:survey_io/common/components/divider.dart';
import 'package:survey_io/common/components/label.dart';
import 'package:survey_io/common/constants/icons.dart';
import 'package:survey_io/common/components/appbar_plain.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController fullName = TextEditingController();
  TextEditingController dateOfBirth = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();

  FocusNode fullNameFocus = FocusNode();
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
  String userKTP = '';
  String userNPWP = '';
  int userAge = 0;
  String selectedGender = '';

  @override
  void initState() {
    super.initState();
    loadProfileInformation();
  }

  void unfocusAll() {
    fullNameFocus.unfocus();
    dateOfBirthFocus.unfocus();
    emailFocus.unfocus();
    phoneNumberFocus.unfocus();
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
            userActive = data.data.user.active;
            userKTP = data.data.userProfile.ktp;
            userNPWP = data.data.userProfile.npwp;
          });
        },
      );
    } catch (e) {
      print('Exception: $e');
    }
  }

  bool _validateForm() {
    if (phoneNumber.text.isEmpty) {
      Fluttertoast.showToast(
        msg: 'Please enter your phone number',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: AppColors.light.withOpacity(0.3),
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return false;
    } else if (fullName.text.isEmpty) {
      Fluttertoast.showToast(
        msg: 'Please enter your Name',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: AppColors.light.withOpacity(0.3),
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return false;
    } else if (email.text.isEmpty) {
      Fluttertoast.showToast(
        msg: 'Please enter your Email',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: AppColors.light.withOpacity(0.3),
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
              return const Profile();
            }));
          },
        ),
        backgroundColor: AppColors.bg,
        body: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              color: Colors.white,
              child: Text(
                'Edit Profil',
                style: TextStyles.h2ExtraBold(color: AppColors.secondary),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: Container(
                  padding: CustomPadding.p2,
                  child: BlocBuilder<ProfileBloc, ProfileState>(
                    builder: (context, state) {
                      return state.maybeWhen(
                        orElse: () {
                          return Container();
                        },
                        loading: () {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                        error: (message) {
                          return Center(
                            child: Text(message),
                          );
                        },
                        loaded: (data) {
                          return formInputSection();
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget formInputSection() {
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
          editable: false,
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
        CustomDividers.mediumDivider(),
        submitButton(),
      ],
    );
  }

  Widget submitButton() {
    return BlocListener<EditProfileBloc, EditProfileState>(
      listener: (context, state) {
        state.maybeWhen(
            orElse: () {},
            loaded: (data) {
              loadProfileInformation();
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
                    print('userGender $userGender');

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
                        ktp: userKTP,
                        npwp: userNPWP,
                      );
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
