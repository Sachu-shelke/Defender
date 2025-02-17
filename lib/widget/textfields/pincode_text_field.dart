import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:defenders/config/theme/app_colors.dart';
import 'package:defenders/utils/validator.dart';

class PincodeTextField extends StatefulWidget {
  final String? pincode;
  final String? cityId;
  final bool isInital;
  final TextEditingController? controller;
  final void Function(String)? onTextChanged;
  final Color? fillColor;
  const PincodeTextField({
    super.key,
    this.pincode = '',
    this.cityId,
    this.fillColor,
    this.isInital = false,
    this.controller,
    this.onTextChanged,
  });

  @override
  // ignore: library_private_types_in_public_api
  _PincodeTextFieldState createState() => _PincodeTextFieldState();
}

class _PincodeTextFieldState extends State<PincodeTextField> {
  TextEditingController? _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        widget.controller ?? TextEditingController(text: widget.pincode);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextFormField(
        controller: _controller,
        keyboardType: TextInputType.phone,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(6),
        ],
        onChanged: widget.onTextChanged,
        validator: Validators.validatePinCode,
        decoration: InputDecoration(
          labelText: 'Pincode',
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
          prefixIcon: const Icon(
            Icons.pin_drop,
            color: Colors.black,
          ),
          filled: true,
          fillColor: widget.fillColor ?? AppColors.containerbg,
          contentPadding: const EdgeInsets.all(16),
        ),
      ),
    );
  }
}
