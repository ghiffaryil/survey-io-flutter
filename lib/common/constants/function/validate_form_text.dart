import 'package:survey_io/common/constants/function/show_toast.dart';

bool validateTextForm(String text) {
  text = text.trim();

  if (text.isEmpty) {
    showToast(message: 'Masukkan Input yang valid');
    return false;
  }

  return true;
}
