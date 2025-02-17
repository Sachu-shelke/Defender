import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:defenders/config/theme/app_colors.dart';

class SignupFooter extends StatelessWidget {
  final bool checked;
  final Function(bool?) onChanged;

  const SignupFooter(
      {required this.checked, required this.onChanged, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Row(children: [
        Checkbox(
            activeColor: AppColors.appColors,
            value: checked,
            onChanged: onChanged),
        Expanded(
            child: RichText(
          text: TextSpan(
            children: [
              const TextSpan(
                text: 'By clicking signup you agree to ',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              TextSpan(
                text: 'Terms & Conditions',
                style: const TextStyle(
                    color: AppColors.secoundColors,
                    fontWeight: FontWeight.w600),
                recognizer: TapGestureRecognizer()..onTap = () {},
              ),
            ],
          ),
          textScaler: const TextScaler.linear(1.0),
        )),
      ]),
    );
  }
}

class Referfooter2 extends StatelessWidget {
  final bool? checked;
  final Function(bool?) onChanged;

  const Referfooter2(
      {required this.checked, super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Row(children: [
        Checkbox(
            activeColor: AppColors.appColors,
            value: checked,
            onChanged: onChanged),
        Expanded(
            child: RichText(
          text: const TextSpan(
            children: [
              TextSpan(
                text: 'I Dont Have a Refer Code',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ],
          ),
        )),
      ]),
    );
  }
}
