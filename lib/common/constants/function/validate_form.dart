import 'package:survey_io/common/constants/function/show_toast.dart';

bool validateForm(
  String input,
  bool Function(String) validationFunction,
  String errorMessage, {
  bool isEmail = false,
  bool isPhone = false,
}) {
  input = input.trim();

  if (input.isEmpty) {
    showToast(message: errorMessage);
    return false;
  }

  if (isEmail) {
    // Regular expression for a simple email validation
    RegExp emailRegExp = RegExp(
      r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$',
    );

    if (!emailRegExp.hasMatch(input)) {
      showToast(message: 'Masukkan Email yang valid');
      return false;
    }
  }

  if (isPhone) {
    // Regular expression for phone number (numeric only)
    RegExp phoneRegExp = RegExp(
      r'^[0-9]+$',
    );

    if (!phoneRegExp.hasMatch(input)) {
      showToast(message: 'Masukkan Nomor handphone yang valid');
      return false;
    }
  }

  return validationFunction(input);
}
