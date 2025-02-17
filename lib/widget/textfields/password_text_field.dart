import 'package:flutter/material.dart';
import 'package:defenders/config/theme/app_colors.dart';

class PasswordTextField extends StatefulWidget {
  final TextEditingController? _controller;
  final Function(String? val)? validator;
  final String labelText;
  final bool isErrorColorFlip;
  final bool isBorder;
  final Function(String)? onChanged;
  final Color? fillColor;
  const PasswordTextField(this._controller,
      {this.validator,
      //  = Validators.validatePassword,
      this.labelText = "Enter your Password",
      this.isBorder = false,
      this.fillColor,
      this.onChanged,
      this.isErrorColorFlip = false,
      super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PasswordTextFieldState createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _isPasswordhide = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14.0),
      child: TextFormField(
        obscureText: _isPasswordhide,
        onChanged: widget.onChanged,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        controller: widget._controller,
        textInputAction: TextInputAction.done,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: widget.validator == null
            ? (text) {
                if (text!.isEmpty) {
                  return "Please enter a valid password";
                }
                return null;
              }
            : (value) => widget.validator!(value),
        decoration: InputDecoration(
          prefixIcon: const Icon(
            Icons.lock_outline_rounded,
            size: 20,
            color: AppColors.blackColor,
          ),
          labelText: widget.labelText,
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                _isPasswordhide = !_isPasswordhide;
              });
            },
            icon: Icon(
              _isPasswordhide ? Icons.visibility_off : Icons.visibility,
              size: 24,
              color: AppColors.darkgreyColor,
            ),
          ),
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
          fillColor: widget.fillColor ?? AppColors.containerbg,
        ),
      ),
    );
  }
}
