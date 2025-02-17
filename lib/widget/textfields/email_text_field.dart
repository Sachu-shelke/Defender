import 'package:flutter/material.dart';
import 'package:defenders/config/theme/app_colors.dart';
import 'package:defenders/utils/validator.dart';

class EmailTextField extends StatelessWidget {
  final TextEditingController? controller;
  final bool isEditable;
  final String lableStr;
  final Widget? suffixWidget;
  final Widget? prefixWidget;
  final Function(String)? onChanged;
  const EmailTextField(
      {required this.controller,
      super.key,
      this.isEditable = false,
      this.lableStr = 'Email ID',
      this.suffixWidget,
      this.prefixWidget,
      this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14.0),
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.emailAddress,
        readOnly: isEditable,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: Validators.validateEmail,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        onFieldSubmitted: (v) {
          FocusScope.of(context).nextFocus();
        },
        onChanged: onChanged,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          labelText: lableStr,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide:
                  const BorderSide(color: AppColors.appColors, width: 0.8)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
              width: 0.8,
              style: BorderStyle.none,
            ),
          ),
          prefixIcon: prefixWidget,
          suffix: suffixWidget,
          filled: true,
          fillColor: AppColors.containerbg,
        ),
      ),
    );
  }
}
