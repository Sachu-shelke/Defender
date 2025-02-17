import 'package:flutter/material.dart';
import 'package:defenders/config/theme/app_colors.dart';
import 'package:defenders/constants/extension/date_time.dart';
import 'package:defenders/widget/style/text_field_style.dart';

class DateTextField extends StatefulWidget {
  final String? Function(String?)? vaidation;
  final TextEditingController controller;
  final String title;
  const DateTextField(
      {super.key,
      required this.controller,
      required this.title,
      this.vaidation});

  @override
  State<DateTextField> createState() => _DateTextFieldState();
}

class _DateTextFieldState extends State<DateTextField> {
  DateTime selectedDate = DateTime.now();
  _onSelectDate() async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1995, 8),
        lastDate: DateTime.now());
    if (picked != null) {
      setState(() {
        widget.controller.text = picked.getDateFormat;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            controller: widget.controller,
            onTap: _onSelectDate,
            readOnly: true,
            validator: (text) {
              if (text!.isEmpty) {
                return "Please enter a valid Date/ Year";
              }
              return null;
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.containerbg,
              labelText: widget.title,
              prefixIcon: const Icon(
                Icons.calendar_today,
                size: 20,
              ),
              border: const OutlineInputBorder(
                // borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                  width: 0.8,
                  style: BorderStyle.none,
                ),
              ),
              focusedBorder: TextFieldStyle.focusBorder(),
            ),
          ),
        ],
      ),
    );
  }
}
