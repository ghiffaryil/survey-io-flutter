import 'package:survey_io/common/constants/function/show_toast.dart';

bool validatePasscodeForm(String passcode) {
  passcode = passcode.trim();

  if (passcode.isEmpty) {
    showToast(message: 'Masukkan Passcode');
    return false;
  }

  return true;
}
