import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:defenders/config/theme/app_colors.dart';
import 'package:defenders/constants/app_const_assets.dart';

class DefaultTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String labelTextStrr;
  final Function? onChanged;
  final bool isEnabled;
  final Color? color;
  final Function()? onTap;
  final bool isPadding;
  final String? errorText;
  final TextInputType type;
  final bool readOnly;
  final Widget? suffix;
  final int? maxLines;
  final Widget? prefixicon;
  final Widget? suffixIcon;
  final String? Function(String?)? vaidation;
  final List<TextInputFormatter>? inputFormatters;
  final TextCapitalization? textCapitalization;
  final bool isValidation;
  const DefaultTextField(
      {required this.controller,
      required this.labelTextStrr,
      this.type = TextInputType.text,
      this.onChanged,
      this.prefixicon,
      this.color,
      this.maxLines,
      this.suffixIcon,
      this.isPadding = true,
      this.isEnabled = true,
      super.key,
      this.onTap,
      this.readOnly = false,
      this.errorText,
      this.suffix,
      this.inputFormatters,
      this.vaidation,
      this.textCapitalization,
      this.isValidation = true});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextFormField(
        onTap: onTap,
        readOnly: readOnly,
        maxLines: maxLines,
        keyboardType: type,
        controller: controller,
        enabled: isEnabled,
        autovalidateMode: isValidation
            ? AutovalidateMode.disabled
            : AutovalidateMode.onUserInteraction,
        inputFormatters: inputFormatters ?? [],
        textCapitalization: textCapitalization ?? TextCapitalization.none,
        validator: isValidation
            ? vaidation ??
                (text) {
                  if (text!.isEmpty) {
                    return "Please enter a valid $labelTextStrr";
                  }
                  return null;
                }
            : null,
        style: const TextStyle(
          // color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        onFieldSubmitted: (v) {
          FocusScope.of(context).nextFocus();
        },
        onChanged: onChanged as void Function(String)?,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: prefixicon ?? Image.asset(AppAssets.userLogo),
          suffixIcon: suffixIcon,
          labelText: labelTextStrr,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide:
                  const BorderSide(color: AppColors.appColors, width: 0.8)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              width: 0.8,
              style: BorderStyle.none,
            ),
          ),
          filled: true,
          fillColor: color ?? AppColors.containerbg,
          // const Color.fromRGBO(240, 248, 252, 100),
          suffix: suffix,
          contentPadding: const EdgeInsets.all(10),
        ),
      ),
    );
  }
}
