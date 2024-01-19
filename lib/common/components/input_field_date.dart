import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:survey_io/common/constants/colors.dart';

// DATE INPUT
class DateInputField extends StatefulWidget {
  final FocusNode focusNode;
  final TextEditingController controller;
  final String hintText;
  final DateTime firstDate;
  final DateTime lastDate;
  final bool showSuffixIcon;
  final bool showPrefixIcon;
  final DateTime? initialDate;

  const DateInputField({
    Key? key,
    required this.focusNode,
    required this.controller,
    required this.hintText,
    required this.firstDate,
    required this.lastDate,
    this.showSuffixIcon = false,
    this.showPrefixIcon = false,
    this.initialDate,
  }) : super(key: key);

  @override
  DateInputFieldState createState() => DateInputFieldState();
}

class DateInputFieldState extends State<DateInputField> {
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate;
    if (_selectedDate != null) {
      widget.controller.text = DateFormat('dd-MM-yyyy').format(_selectedDate!);
    }
  }

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
            color: AppColors.secondary,
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
          initialDate: _selectedDate ?? DateTime.now(),
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
