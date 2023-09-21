import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:survey_io/components/color/color_component.dart';

// TEXT INPUT
class TextInputField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final FocusNode focusNode;
  final TextInputType keyboardType;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  TextInputField({
    required this.controller,
    required this.hintText,
    required this.focusNode,
    required this.keyboardType,
    this.prefixIcon, // Added parameter for prefix icon
    this.suffixIcon, // Added parameter for suffix icon
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: focusNode,
      keyboardType: keyboardType,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: const BorderSide(
            color: AppColors.secondaryColor,
            width: 1.0,
          ),
        ),
        prefixIcon: prefixIcon, // Set prefix icon
        suffixIcon: Padding(
          padding: const EdgeInsets.all(8.0),
          child: suffixIcon,
        ),
        contentPadding: const EdgeInsets.all(20.0),
      ),
    );
  }
}

// DATE INPUT
class DateInputField extends StatefulWidget {
  final FocusNode focusNode;
  final TextEditingController controller;
  final String hintText;
  final DateTime firstDate;
  final DateTime lastDate;
  final bool showSuffixIcon;
  final bool showPrefixIcon;

  const DateInputField({
    required this.focusNode,
    required this.controller,
    required this.hintText,
    required this.firstDate,
    required this.lastDate,
    this.showSuffixIcon = false,
    this.showPrefixIcon = false,
  });

  @override
  _DateInputFieldState createState() => _DateInputFieldState();
}

class _DateInputFieldState extends State<DateInputField> {
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: true,
      focusNode: widget.focusNode,
      controller: widget.controller,
      decoration: InputDecoration(
        hintText: widget.hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: const BorderSide(
            color: AppColors.secondaryColor,
            width: 1.0,
          ),
        ),
        contentPadding: const EdgeInsets.all(20),
        prefixIcon: widget.showPrefixIcon
            ? const Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 4, 0),
                child: Icon(Icons.calendar_today),
              )
            : null,
        suffixIcon: widget.showSuffixIcon
            ? const Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 4, 0),
                child: Icon(Icons.calendar_today),
              )
            : null,
      ),
      onTap: () async {
        DateTime? selectedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: widget.firstDate,
          lastDate: widget.lastDate,
        );

        if (selectedDate != null && selectedDate != _selectedDate) {
          setState(() {
            _selectedDate = selectedDate;
            widget.controller.text =
                DateFormat('dd-MM-yyyy').format(selectedDate);
          });
        }
      },
    );
  }
}

// PASSWORD TEXT INPUA
class PasswordTextInput extends StatefulWidget {
  final FocusNode focusNode;
  final TextEditingController controller;
  final bool hidePassword;
  final String hintText;
  final VoidCallback onPasswordVisibilityToggle;

  const PasswordTextInput({
    required this.focusNode,
    required this.hintText,
    required this.controller,
    required this.hidePassword,
    required this.onPasswordVisibilityToggle,
  });

  @override
  _PasswordTextInputState createState() => _PasswordTextInputState();
}

class _PasswordTextInputState extends State<PasswordTextInput> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: widget.focusNode,
      keyboardType: TextInputType.visiblePassword,
      obscureText: widget.hidePassword,
      controller: widget.controller,
      obscuringCharacter: '*',
      decoration: InputDecoration(
        hintText: widget.hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: const BorderSide(
            color: AppColors.secondaryColor,
            width: 1.0,
          ),
        ),
        contentPadding: const EdgeInsets.all(20.0),
        suffixIcon: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
          child: GestureDetector(
            onTap: () {
              widget.onPasswordVisibilityToggle;
            },
            child: Icon(
              widget.hidePassword
                  ? Icons.visibility_off_rounded
                  : Icons.visibility_rounded,
              size: 20,
            ),
          ),
        ),
      ),
    );
  }
}
