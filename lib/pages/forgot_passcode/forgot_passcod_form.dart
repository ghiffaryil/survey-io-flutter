import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:survey_io/common/components/elevated_button.dart';
import 'package:survey_io/common/components/input_field_passcode.dart';
import 'package:survey_io/bloc/forgot_pasccode/update_passcode/update_passcode_bloc.dart';
import 'package:survey_io/datasources/guest/auth_local_guest_datasource.dart';

// Import Component
import 'package:survey_io/common/constants/colors.dart';
import 'package:survey_io/common/constants/styles.dart';
import 'package:survey_io/common/components/divider.dart';
import 'package:survey_io/common/components/label.dart';
import 'package:survey_io/common/components/appbar_plain.dart';
import 'package:survey_io/pages/login/login.dart';

class ForgotPasscodeFormPage extends StatefulWidget {
  final String inputEmail;

  const ForgotPasscodeFormPage({super.key, required this.inputEmail});

  @override
  State<ForgotPasscodeFormPage> createState() => _ForgotPasscodeFormPageState();
}

class _ForgotPasscodeFormPageState extends State<ForgotPasscodeFormPage> {
  TextEditingController passcodeField = TextEditingController();
  FocusNode passcodeFieldFocus = FocusNode();

  TextEditingController passcodeFieldConfirmation = TextEditingController();
  FocusNode passcodeFieldConfirmationFocus = FocusNode();

  bool isLogged = false;
  bool isExpiredToken = false;
  bool _hidePasscode = true;
  bool _hidePasscodeConfirmation = true;

  @override
  void initState() {
    super.initState();
  }

  void unfocusAll() {
    passcodeFieldFocus.unfocus();
    passcodeFieldConfirmationFocus.unfocus();
  }

  void _showHidePasscodeTogle() {
    setState(() {
      _hidePasscode = !_hidePasscode;
    });
  }

  void _showHidePasscodeConfirmationTogle() {
    setState(() {
      _hidePasscodeConfirmation = !_hidePasscodeConfirmation;
    });
  }

  bool _validateForm() {
    if (passcodeField.text.isEmpty) {
      Fluttertoast.showToast(
        msg: 'Masukkan 6 Digit Angka',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: AppColors.secondary.withOpacity(0.8),
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return false;
    } else if (passcodeFieldConfirmation.text.isEmpty) {
      Fluttertoast.showToast(
        msg: 'Masukkan Kembali 6 Digit Angka di atas',
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
    return Scaffold(
      appBar: PlainAppBar(
        height: 40,
        leadingIcon: Icons.arrow_back_ios,
        iconColor: AppColors.white,
        onPressed: () {},
      ),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            labelText(),
            CustomDividers.verySmallDivider(),
            formInputField(),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.42,
            ),
            BlocProvider(
              create: (context) => UpdatePasscodeBloc(),
              child: buttonSubmit(),
            ),
            CustomDividers.smallDivider(),
          ],
        ),
      ),
    );
  }

  Widget labelText() {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        'Sedikit Lagi ...',
        style: TextStyles.h2(color: AppColors.secondary),
      ),
    );
  }

  Widget formInputField() {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
            'Ubah Passcode kamu',
            style: TextStyles.h4(color: AppColors.secondary),
          ),
        ),
        CustomDividers.regularDivider(),
        LabelInput(
          labelText: 'Passcode',
          labelStyle: TextStyles.h4(color: AppColors.secondary),
        ),
        CustomDividers.verySmallDivider(),
        PasscodeTextInput(
          focusNode: passcodeFieldFocus,
          controller: passcodeField,
          hintText: 'Masukkan 6 Digit Angka',
          hidePassword: _hidePasscode,
          onPasswordVisibilityToggle: _showHidePasscodeTogle,
        ),
        CustomDividers.smallDivider(),
        LabelInput(
          labelText: 'Verifikasi Passcode',
          labelStyle: TextStyles.h4(color: AppColors.secondary),
        ),
        CustomDividers.verySmallDivider(),
        PasscodeTextInput(
          focusNode: passcodeFieldConfirmationFocus,
          controller: passcodeFieldConfirmation,
          hintText: 'Masukkan 6 Digit Angka',
          hidePassword: _hidePasscodeConfirmation,
          onPasswordVisibilityToggle: _showHidePasscodeConfirmationTogle,
        ),
      ],
    );
  }

  Widget buttonSubmit() {
    return BlocListener<UpdatePasscodeBloc, UpdatePasscodeState>(
      listener: (context, state) {
        state.maybeWhen(
            orElse: () {},
            loaded: (data) {
              AuthLocalGuestDatasource().removeAuthData();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                return const LoginPage();
              }));
            },
            error: (message) {
              Fluttertoast.showToast(
                  msg: message,
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: AppColors.secondary.withOpacity(0.8),
                  textColor: Colors.white,
                  fontSize: 16.0);
            });
      },
      child: BlocBuilder<UpdatePasscodeBloc, UpdatePasscodeState>(
        builder: (context, state) {
          return state.maybeWhen(orElse: () {
            return ButtonFilled.primary(
                text: 'Ubah Passcode',
                onPressed: () {
                  if (_validateForm()) {
                    context.read<UpdatePasscodeBloc>().add(
                        UpdatePasscodeEvent.updatePasscode(
                            widget.inputEmail, passcodeField.text));
                  }
                });
          }, loading: () {
            return ButtonFilled.primary(
                textColor: AppColors.white,
                text: '',
                loading: true,
                onPressed: () {});
          });
        },
      ),
    );
  }
}
