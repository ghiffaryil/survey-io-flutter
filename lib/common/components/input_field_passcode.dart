import 'package:flutter/material.dart';
import 'package:survey_io/common/constants/colors.dart';

// PASSWORD TEXT INPUT
class PasscodeTextInput extends StatefulWidget {
  final FocusNode focusNode;
  final TextEditingController controller;
  final bool hidePassword;
  final String hintText;
  final VoidCallback onPasswordVisibilityToggle;

  const PasscodeTextInput({
    super.key,
    required this.focusNode,
    required this.hintText,
    required this.controller,
    required this.hidePassword,
    required this.onPasswordVisibilityToggle,
  });

  @override
  PasscodeTextInputState createState() => PasscodeTextInputState();
}

class PasscodeTextInputState extends State<PasscodeTextInput> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: widget.focusNode,
      keyboardType: TextInputType.number,
      obscureText: widget.hidePassword,
      controller: widget.controller,
      obscuringCharacter: '*',
      decoration: InputDecoration(
        hintText: widget.hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: const BorderSide(
            color: AppColors.secondary,
            width: 1.0,
          ),
        ),
        contentPadding: const EdgeInsets.all(18.0),
        suffixIcon: IconButton(
          onPressed: () {
            widget.onPasswordVisibilityToggle(); // Call the callback here
          },
          icon: Icon(
            widget.hidePassword ? Icons.visibility_off : Icons.visibility,
            color: Colors.grey, // Adjust the color as needed
          ),
        ),
      ),
    );
  }
}
