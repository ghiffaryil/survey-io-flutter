// ignore_for_file: must_be_immutable

import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:survey_io/common/constants/colors.dart';
import 'package:survey_io/common/constants/styles.dart';

// TEXT INPUT
class TextInputField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final FocusNode focusNode;
  final TextInputType keyboardType;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? suffixIconSVG;
  final String? suffixIconPNG;

  const TextInputField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.focusNode,
    required this.keyboardType,
    this.prefixIcon, // Added parameter for prefix icon
    this.suffixIcon, // Added parameter for suffix icon
    this.suffixIconSVG,
    this.suffixIconPNG,
  });

  @override
  Widget build(BuildContext context) {
    Widget? suffixWidget;
    if (suffixIconSVG != null) {
      suffixWidget = buildSvgSuffixIcon(suffixIconSVG!);
    } else if (suffixIconPNG != null) {
      suffixWidget = buildPngSuffixIcon(suffixIconPNG!);
    } else {
      suffixWidget = suffixIcon;
    }

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
        prefixIcon: prefixIcon,
        suffixIcon: Padding(
          padding: const EdgeInsets.all(12.0),
          child: suffixWidget,
        ),
        contentPadding: const EdgeInsets.all(18.0),
      ),
    );
  }

  Widget buildSvgSuffixIcon(String svgAssetPath) {
    return SvgPicture.asset(
      svgAssetPath,
      width: 4,
      height: 4,
    );
  }

  Widget buildPngSuffixIcon(String pngAssetPath) {
    return Image.asset(
      pngAssetPath,
      width: 4,
      height: 4,
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
    super.key,
    required this.focusNode,
    required this.controller,
    required this.hintText,
    required this.firstDate,
    required this.lastDate,
    this.showSuffixIcon = false,
    this.showPrefixIcon = false,
  });

  @override
  DateInputFieldState createState() => DateInputFieldState();
}

class DateInputFieldState extends State<DateInputField> {
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
        contentPadding: const EdgeInsets.all(18.0),
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

// PASSWORD TEXT INPUT
class PasswordTextInput extends StatefulWidget {
  final FocusNode focusNode;
  final TextEditingController controller;
  final bool hidePassword;
  final String hintText;
  final VoidCallback onPasswordVisibilityToggle;

  const PasswordTextInput({
    super.key,
    required this.focusNode,
    required this.hintText,
    required this.controller,
    required this.hidePassword,
    required this.onPasswordVisibilityToggle,
  });

  @override
  PasswordTextInputState createState() => PasswordTextInputState();
}

class PasswordTextInputState extends State<PasswordTextInput> {
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

class RadioTextInput extends StatefulWidget {
  String parameter;
  final String value;

  RadioTextInput({
    super.key,
    required this.parameter,
    required this.value,
  });

  @override
  State<RadioTextInput> createState() => _RadioTextInputState();
}

class _RadioTextInputState extends State<RadioTextInput> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: widget.parameter == widget.value
              ? AppColors.secondaryColor
              : AppColors.secondaryColor.withOpacity(0.4),
          width: 1.0,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 15),
              child: Text(
                widget.value,
                style: TextStyles.extraLarge(
                    color: widget.parameter == widget.value
                        ? AppColors.secondaryColor
                        : AppColors.secondaryColor.withOpacity(0.4)),
              )),
          Radio(
            value: widget.value,
            groupValue: widget.parameter,
            onChanged: (value) {
              setState(() {
                // print('${widget.parameter} => ${value}');
                widget.parameter = value.toString();
              });
            },
          ),
        ],
      ),
    );
  }
}
