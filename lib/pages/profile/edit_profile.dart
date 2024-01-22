import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:survey_io/bloc/profile/get_list_city/get_list_city_bloc.dart';
import 'package:survey_io/bloc/profile/get_list_province/get_list_province_bloc.dart';
import 'package:survey_io/datasources/profile/get_list_province_datasource.dart';
import 'package:survey_io/datasources/profile/get_profile_datasource.dart';
import 'package:survey_io/models/user/list_city_response_model.dart';
import 'package:survey_io/models/user/list_province_response_model.dart';
import 'package:survey_io/pages/profile/profile.dart';
import 'package:survey_io/bloc/profile/edit_profile/edit_profile_bloc.dart';
import 'package:survey_io/models/user/edit_profile_request_model.dart';
import 'package:survey_io/common/components/elevated_button.dart';
import 'package:survey_io/common/components/input_field_date.dart';
import 'package:survey_io/common/components/input_field_radio.dart';
import 'package:survey_io/common/components/input_field_text.dart';
import 'package:survey_io/common/constants/colors.dart';
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

  TextEditingController inputKTP = TextEditingController();
  TextEditingController inputNPWP = TextEditingController();

  TextEditingController province = TextEditingController();
  TextEditingController city = TextEditingController();

  FocusNode fullNameFocus = FocusNode();
  FocusNode dateOfBirthFocus = FocusNode();
  FocusNode emailFocus = FocusNode();
  FocusNode phoneNumberFocus = FocusNode();

  int userId = 0;
  int userActive = 0;
  int emailVerified = 0;
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

  bool isLoadedProvince = false;
  bool isLoadedCity = false;
  bool isHavePhoneNumber = false;

  String genderSelected = '';

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
        (error) => print('Error: $error'),
        (data) {
          final userProfile = data.data.userProfile;
          final user = data.data.user;

          setState(() {
            userId = user.id;
            fullName.text = user.name;
            email.text = user.email;

            isHavePhoneNumber = user.phoneNumber != "null";
            phoneNumber.text = isHavePhoneNumber ? user.phoneNumber : '';

            DateTime localDob = userProfile.dob.toLocal();
            dateOfBirth.text = DateFormat('dd-MM-yyyy').format(localDob);

            genderSelected =
                userProfile.gender == "man" || userProfile.gender == "male"
                    ? "Laki-laki"
                    : "Perempuan";
            userGender =
                userProfile.gender == "man" || userProfile.gender == "male"
                    ? "male"
                    : "female";

            userActive = user.active;
            emailVerified = user.emailVerified;

            userKTP = userProfile.ktp;
            userNPWP = userProfile.npwp;

            inputKTP.text = userProfile.ktp;
            inputNPWP.text = userProfile.npwp;

            provinceNameSelected = userProfile.province;
            cityNameSelected = userProfile.city;

            isLoadedProvince = userProfile.province.isNotEmpty;
            isLoadedCity = userProfile.city.isNotEmpty;
          });

          if (userProfile.province.isNotEmpty) {
            loadProvinceList();
            loadProvinceListWithName(userProfile.province);
          }
        },
      );
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

  void loadProvinceListWithName(String provinceNameExist) async {
    print('load province with name');

    try {
      final result = await GetListProvinceDatasource().getProvinceList();

      result.fold(
        (error) {
          // Handle error
          print('Error loading province list: $error');
        },
        (provinceList) {
          final provinceId =
              getProvinceIdByName(provinceList, provinceNameExist);
          if (provinceId != -1) {
            // Province id found, use it in the next function
            // Call the next function with provinceId
            // Example: nextFunction(provinceId);
            loadCityList(provinceId);
          } else {
            print('Province not found');
          }
        },
      );
    } catch (e) {
      print('Exception: $e');
    }
  }

  // Helper function to extract province id by name
  int getProvinceIdByName(
      ListProvinceResponseModel provinceList, String provinceName) {
    for (var province in provinceList.data) {
      if (province.name == provinceName) {
        print('province id ${province.id}');
        return province.id;
      }
    }

    return -1; // Return -1 if province not found
  }

  void loadCityList(getProvinceId) {
    context
        .read<GetListCityBloc>()
        .add(GetListCityEvent.getListCity(getProvinceId));
  }

  bool _validateForm() {
    if (phoneNumber.text.isEmpty) {
      Fluttertoast.showToast(
        msg: 'Masukkan momor Handphone kamu',
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
        msg: 'Masukkan Nama Nengkap kamu',
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
        msg: 'Masukkan Email kamu',
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
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
              color: Colors.white,
              child: Text(
                'Edit Profil',
                style: TextStyles.h3ExtraBold(color: AppColors.secondary),
              ),
            ),
            CustomDividers.verySmallDivider(),
            Expanded(
              child: SingleChildScrollView(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  child: formInputSection()),
            ),
          ],
        ),
      ),
    );
  }

  Widget formInputSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          LabelInput(
            labelText: 'Nama Lengkap*',
            labelStyle: TextStyles.h4(color: AppColors.secondary),
          ),
          CustomDividers.verySmallDivider(),
          TextInputField(
            focusNode: fullNameFocus,
            keyboardType: TextInputType.text,
            controller: fullName,
            hintText: 'Masukkan Nama Lengkap',
          ),
          CustomDividers.smallDivider(),
          LabelInput(
            labelText: 'Jenis Kelamin*',
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
                    selectedOption: genderSelected,
                    onChanged: (value) {
                      setState(() {
                        genderSelected = value;
                        userGender = 'male';
                      });
                    },
                  )),
              Container(
                width: 10,
              ),
              Expanded(
                  flex: 5,
                  child: RadioTextInput(
                    value: 'Perempuan',
                    selectedOption: genderSelected,
                    onChanged: (value) {
                      setState(() {
                        genderSelected = value;
                        userGender = 'female';
                      });
                    },
                  )),
            ],
          ),
          CustomDividers.smallDivider(),
          LabelInput(
            labelText: 'Tanggal Lahir*',
            labelStyle: TextStyles.h4(color: AppColors.secondary),
          ),
          CustomDividers.verySmallDivider(),
          DateInputField(
            focusNode: dateOfBirthFocus,
            controller: dateOfBirth,
            hintText: 'dd-mm-yyyy',
            firstDate: DateTime(1980),
            lastDate: DateTime.now(),
            showPrefixIcon: false,
            showSuffixIcon: true,
          ),

          CustomDividers.smallDivider(),
          LabelInput(
            labelText: 'Email*',
            labelStyle: TextStyles.h4(color: AppColors.secondary),
          ),
          CustomDividers.verySmallDivider(),
          TextInputField(
            focusNode: emailFocus,
            keyboardType: TextInputType.emailAddress,
            controller: email,
            editable: false,
            hintText: 'Masukkan Email',
            suffixIconPNG:
                emailVerified == 1 ? IconName.pollingCheckInfo : null,
          ),
          CustomDividers.smallDivider(),
          LabelInput(
            labelText: 'Nomor Handphone',
            labelStyle: TextStyles.h4(color: AppColors.secondary),
          ),
          CustomDividers.verySmallDivider(),

          TextInputField(
            focusNode: phoneNumberFocus,
            keyboardType: TextInputType.phone,
            controller: phoneNumber,
            hintText: 'Mauskkan Nomor Handphone',
            editable: isHavePhoneNumber && emailVerified == 1 ? false : true,
          ),
          CustomDividers.smallDivider(),
          userKTP.isEmpty
              ? Container()
              : Column(
                  children: [
                    LabelInput(
                      labelText: 'KTP',
                      labelStyle: TextStyles.h4(color: AppColors.secondary),
                    ),
                    CustomDividers.verySmallDivider(),
                    TextInputField(
                      keyboardType: TextInputType.text,
                      controller: inputKTP,
                      editable: false,
                      hintText: 'Masukkan KTP Kamu',
                    ),
                    CustomDividers.smallDivider(),
                  ],
                ),

          userNPWP.isEmpty
              ? Container()
              : Column(
                  children: [
                    LabelInput(
                      labelText: 'NPWP',
                      labelStyle: TextStyles.h4(color: AppColors.secondary),
                    ),
                    CustomDividers.verySmallDivider(),
                    TextInputField(
                      keyboardType: TextInputType.text,
                      controller: inputNPWP,
                      editable: false,
                      hintText: 'Masukkan NPWP Kamu',
                    ),
                    CustomDividers.smallDivider(),
                  ],
                ),

          // PROVINCE
          LabelInput(
            labelText: 'Provinsi',
            labelStyle: TextStyles.h4(color: AppColors.secondary),
          ),
          CustomDividers.verySmallDivider(),

          isLoadedProvince
              ? widgetListProvince()
              : GestureDetector(
                  onTap: () {
                    loadProvinceList();
                    setState(() {
                      isLoadedProvince = true;
                    });
                  },
                  child: TextInputField(
                    keyboardType: TextInputType.text,
                    editable: false,
                    controller: province,
                    hintText: 'Pilih Provinsi',
                    suffixIcon: const Icon(Icons.arrow_drop_down),
                  ),
                ),

          // CITY
          CustomDividers.smallDivider(),
          LabelInput(
            labelText: 'Kota/Kabupaten',
            labelStyle: TextStyles.h4(color: AppColors.secondary),
          ),
          CustomDividers.verySmallDivider(),

          isLoadedCity
              ? widgetListCity()
              : GestureDetector(
                  onTap: () {
                    setState(() {
                      isLoadedProvince = true;
                      isLoadedCity = true;
                    });
                    loadCityList(provinceIdSelected);
                  },
                  child: TextInputField(
                    keyboardType: TextInputType.text,
                    editable: false,
                    controller: city,
                    hintText: 'Pilih Kota',
                    suffixIcon: const Icon(Icons.arrow_drop_down),
                  ),
                ),

          CustomDividers.regularDivider(),
          submitButton(),
          CustomDividers.smallDivider(),
        ],
      ),
    );
  }

  Widget widgetListProvince() {
    return Container(
      height: 55,
      width: double.infinity,
      padding: const EdgeInsets.only(left: 15, right: 10),
      decoration: BoxDecoration(
        border: Border.all(width: 1.0, color: AppColors.light),
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: BlocBuilder<GetListProvinceBloc, GetListProvinceState>(
        builder: (context, state) {
          return state.maybeWhen(
            orElse: () {
              return Container();
            },
            loading: () {
              return const Center(child: Text('Load data ...'));
            },
            loaded: (data) {
              return Row(
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
                          print('$provinceIdSelected / $provinceNameSelected');
                        }
                      },
                      // ignore: unnecessary_null_comparison
                      value: provinceNameSelected != null
                          ? data.firstWhere(
                              (dataProvince) =>
                                  dataProvince.name == provinceNameSelected,
                              orElse: () => data.first)
                          : null,
                      isExpanded: true, // Set to true for full width
                      icon: const Icon(Icons.arrow_drop_down),
                    ),
                  ),
                  // Add additional space or padding if needed
                ],
              );
            },
          );
        },
      ),
    );
  }

  Widget widgetListCity() {
    return Container(
      height: 60,
      width: double.infinity,
      padding: const EdgeInsets.only(left: 15, right: 10),
      decoration: BoxDecoration(
        border: Border.all(width: 1.0, color: AppColors.light),
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: BlocBuilder<GetListCityBloc, GetListCityState>(
        builder: (context, state) {
          return state.maybeWhen(
            orElse: () {
              return Container();
            },
            loading: () {
              return const Center(child: Text('Load data ...'));
            },
            loaded: (data) {
              if (cityIdSelected == 0 && cityNameSelected == '') {
                // Set initial values based on the first item in the loaded data
                cityIdSelected = data.first.id;
                cityNameSelected = data.first.name;
                print('$cityIdSelected / $cityNameSelected');
              }
              return Row(
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
                              (dataCity) => dataCity.name == cityNameSelected,
                              orElse: () => data.first,
                            )
                          : null,
                      isExpanded: true, // Set to true for full width
                      icon: const Icon(Icons.arrow_drop_down),
                    ),
                  ),
                  // Add additional space or padding if needed
                ],
              );
            },
          );
        },
      ),
    );
  }

  Widget submitButton() {
    return BlocListener<EditProfileBloc, EditProfileState>(
      listener: (context, state) {
        state.maybeWhen(
            orElse: () {},
            loaded: (data) {
              // loadProfileInformation();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const Profile()));
            },
            error: (message) {
              Fluttertoast.showToast(
                  msg: message,
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: AppColors.secondary,
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
                        city: cityNameSelected,
                        province: provinceNameSelected,
                      );
                      context
                          .read<EditProfileBloc>()
                          .add(EditProfileEvent.editProfile(requestModel));
                    }
                  });
            },
            loading: () {
              return ButtonFilled.primary(
                text: '',
                onPressed: () {},
                textColor: AppColors.white,
                loading: true,
              );
            },
          );
        },
      ),
    );
  }
}
