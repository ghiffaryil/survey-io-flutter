import 'package:flutter/gestures.dart' show TapGestureRecognizer;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:survey_io/bloc/profile/edit_profile/edit_profile_bloc.dart';
import 'package:survey_io/bloc/profile/get_list_city/get_list_city_bloc.dart';
import 'package:survey_io/bloc/profile/get_list_province/get_list_province_bloc.dart';
import 'package:survey_io/common/components/appbar_plain.dart';
import 'package:survey_io/common/constants/icons.dart';
import 'package:survey_io/datasources/profile/get_profile_datasource.dart';
import 'package:survey_io/models/user/edit_profile_request_model.dart';
import 'package:survey_io/common/components/elevated_button.dart';
import 'package:survey_io/common/components/input_field_radio.dart';
import 'package:survey_io/common/components/input_field_text.dart';
import 'package:survey_io/common/constants/colors.dart';
import 'package:survey_io/common/constants/styles.dart';
import 'package:survey_io/common/components/divider.dart';
import 'package:survey_io/common/components/label.dart';
import 'package:survey_io/common/constants/padding.dart';
import 'package:survey_io/models/user/list_city_response_model.dart';
import 'package:survey_io/models/user/list_province_response_model.dart';
import 'package:survey_io/pages/survey_design/survey_design.dart';
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

  TextEditingController email = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController dateOfBirth = TextEditingController();

  TextEditingController province = TextEditingController();
  TextEditingController city = TextEditingController();

  FocusNode fullNameFocus = FocusNode();
  FocusNode placeOfBirthFocus = FocusNode();
  FocusNode passcodeFocus = FocusNode();
  FocusNode referalCodeFocus = FocusNode();
  FocusNode dateOfBirthFocus = FocusNode();
  FocusNode emailFocus = FocusNode();
  FocusNode phoneNumberFocus = FocusNode();
  FocusNode inputKtpNumberFocus = FocusNode();
  FocusNode inputNpwpNumberFocus = FocusNode();

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

  int provinceIdSelected = 0;
  int cityIdSelected = 0;

  // Initialize these variables in your state or wherever applicable
  String? provinceNameSelected;
  String? cityNameSelected;

  @override
  void initState() {
    super.initState();
    provinceNameSelected = '';
    cityNameSelected = '';
    loadProfileInformation();
  }

  void loadProfileInformation() async {
    try {
      final result = await ProfileRemoteDatasource().getProfile();

      result.fold((error) {
        print('Error: $error');
      }, (data) {
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
          userActive = data.data.user.active;
          provinceNameSelected = data.data.userProfile.province;
          cityNameSelected = data.data.userProfile.city;
        });
        data.data.userProfile.province != "" ? loadProvinceList() : null;
      });
    } catch (e) {
      print('Exception: $e');
    }
  }

  void loadProvinceList() {
    print('load province');
    context
        .read<GetListProvinceBloc>()
        .add(const GetListProvinceEvent.getListProvince());
  }

  void loadCityList(getProvinceId) {
    context
        .read<GetListCityBloc>()
        .add(GetListCityEvent.getListCity(getProvinceId));
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
    } else if (provinceNameSelected == '') {
      Fluttertoast.showToast(
        msg: 'Harap pilih Provinsi',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: AppColors.secondary.withOpacity(0.8),
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return false;
    } else if (cityNameSelected == '') {
      Fluttertoast.showToast(
        msg: 'Harap pilih Kota',
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
              return const SurveyDesignListPage();
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
          editable: false,
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
                  onChanged: (value) {},
                  editable: false,
                )),
            Container(
              width: 10,
            ),
            Expanded(
                flex: 5,
                child: RadioTextInput(
                  value: 'Perempuan',
                  selectedOption: selectedGender,
                  onChanged: (value) {},
                  editable: false,
                )),
          ],
        ),
        CustomDividers.smallDivider(),
        LabelInput(
          labelText: 'Tanggal Lahir',
          labelStyle: TextStyles.h4(color: AppColors.secondary),
        ),
        CustomDividers.verySmallDivider(),
        TextInputField(
          focusNode: dateOfBirthFocus,
          keyboardType: TextInputType.text,
          controller: dateOfBirth,
          hintText: '',
          editable: false,
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
          editable: false,
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
        CustomDividers.smallDivider(),

        // PROVINCE
        LabelInput(
          labelText: 'Provinsi',
          labelStyle: TextStyles.h4(color: AppColors.secondary),
        ),
        CustomDividers.verySmallDivider(),

        BlocBuilder<GetListProvinceBloc, GetListProvinceState>(
          builder: (context, state) {
            return state.maybeWhen(
              orElse: () {
                return GestureDetector(
                  onTap: () {
                    loadProvinceList();
                  },
                  child: TextInputField(
                    keyboardType: TextInputType.text,
                    editable: false,
                    controller: province,
                    hintText: 'Pilih Provinsi',
                  ),
                );
              },
              loaded: (data) {
                return Container(
                  height: 50,
                  width: double.infinity,
                  padding: const EdgeInsets.only(left: 15, right: 10),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1.0, color: AppColors.light),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: DropdownButton<DataProvince>(
                          items: data.map((dataProvince) {
                            return DropdownMenuItem<DataProvince>(
                              value: dataProvince,
                              child: Text(dataProvince.name),
                            );
                          }).toList(),
                          underline: Container(height: 0),
                          onChanged: (DataProvince? value) {
                            if (value != null) {
                              setState(() {
                                cityIdSelected = 0;
                                cityNameSelected = '';
                                provinceIdSelected = value.id;
                                provinceNameSelected = value.name;
                              });
                              loadCityList(provinceIdSelected);
                              print(
                                  '$provinceIdSelected / $provinceNameSelected');
                            }
                          },
                          // ignore: unnecessary_null_comparison
                          value: provinceNameSelected != null
                              ? data.firstWhere(
                                  (dataProvince) =>
                                      dataProvince.name == provinceNameSelected,
                                  orElse: () => data.first,
                                )
                              : null,
                          isExpanded: true, // Set to true for full width
                          icon: const Icon(Icons.arrow_drop_down),
                        ),
                      ),
                      // Add additional space or padding if needed
                    ],
                  ),
                );
              },
            );
          },
        ),

        // CITY
        CustomDividers.smallDivider(),
        LabelInput(
          labelText: 'Kota/Kabupaten',
          labelStyle: TextStyles.h4(color: AppColors.secondary),
        ),
        CustomDividers.verySmallDivider(),
        BlocBuilder<GetListCityBloc, GetListCityState>(
          builder: (context, state) {
            return state.maybeWhen(
              orElse: () {
                return GestureDetector(
                  onTap: () => loadCityList(provinceIdSelected),
                  child: TextInputField(
                    keyboardType: TextInputType.text,
                    editable: false,
                    controller: city,
                    hintText: 'Pilih Kota',
                  ),
                );
              },
              loaded: (data) {
                if (cityIdSelected == 0 && cityNameSelected == '') {
                  // Set initial values based on the first item in the loaded data
                  cityIdSelected = data.first.id;
                  cityNameSelected = data.first.name;
                  print('$cityIdSelected / $cityNameSelected');
                }
                return Container(
                  height: 60,
                  width: double.infinity,
                  padding: const EdgeInsets.only(left: 15, right: 10),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1.0, color: AppColors.light),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: DropdownButton<DataCity>(
                          items: data.map((dataCity) {
                            return DropdownMenuItem<DataCity>(
                              value: dataCity,
                              child: Text(dataCity.name),
                            );
                          }).toList(),
                          underline: Container(height: 0),
                          onChanged: (DataCity? value) {
                            if (value != null) {
                              setState(() {
                                cityIdSelected = value.id;
                                cityNameSelected = value.name;
                              });
                              print('$cityIdSelected / $cityNameSelected');
                            }
                          },
                          // ignore: unnecessary_null_comparison
                          value: cityNameSelected != null
                              ? data.firstWhere(
                                  (dataCity) =>
                                      dataCity.name == cityNameSelected,
                                  orElse: () => data.first,
                                )
                              : null,
                          isExpanded: true, // Set to true for full width
                          icon: const Icon(Icons.arrow_drop_down),
                        ),
                      ),
                      // Add additional space or padding if needed
                    ],
                  ),
                );
              },
            );
          },
        ),

        CustomDividers.regularDivider(),
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
                      builder: (context) => const SurveyDesign()));
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
                          npwp: inputNpwpNumber.text,
                          city: cityNameSelected,
                          province: provinceNameSelected);
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
