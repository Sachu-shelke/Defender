import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:defenders/config/theme/app_colors.dart';
import 'package:defenders/constants/app_const_text.dart';
import 'package:defenders/utils/validator.dart';

class AmountTextField extends StatelessWidget {
  final bool isTrailing;
  final String? trailingString;
  final bool isEnable;
  final Function()? onTrailing;
  final String labelStr;
  final String prefixText;
  final String? helperText;
  final String? Function(String?) validator;
  final TextEditingController? controller;
  final Widget? suffixIcon;
  final void Function(String)? onChanged;
  const AmountTextField(
      {this.isTrailing = false,
      this.trailingString,
      required this.controller,
      this.onTrailing,
      this.onChanged,
      this.isEnable = true,
      this.labelStr = "Amount",
      this.helperText,
      this.suffixIcon,
      super.key,
      this.prefixText = AppConstString.rupeesSymbol,
      this.validator = Validators.validateAmount});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.phone,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      inputFormatters: [
        // FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(6)
      ],
      controller: controller,
      validator: validator,
      enabled: isEnable,
      onChanged: onChanged,
      style: const TextStyle(
          fontSize: 16, fontWeight: FontWeight.w500, letterSpacing: .10),
      decoration: InputDecoration(
        labelText: labelStr,
        prefixText: '$prefixText ',
        prefixStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        labelStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide:
                const BorderSide(color: AppColors.appColors, width: 0.8)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            width: 0.8,
            style: BorderStyle.none,
          ),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.all(16),
        helperText: helperText,
        helperStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        suffixIcon: suffixIcon,
        suffix: (isTrailing && trailingString != null)
            ? InkWell(
                onTap: onTrailing,
                child: Text(
                  trailingString ?? '',
                  textScaleFactor: 1.0,
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.orange),
                ),
              )
            : null,
      ),
    );
  }
}
