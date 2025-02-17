import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:defenders/config/routes/router_import.gr.dart';
import 'package:defenders/config/theme/app_colors.dart';
import 'package:defenders/constants/app_const_text.dart';
import 'package:defenders/widget/button/primary_button.dart';
import 'package:defenders/widget/textfields/mobile_text_field.dart';

@RoutePage()
class ForgetPasswordScreen extends StatefulWidget {
  final bool isActiveId;
  const ForgetPasswordScreen({super.key, required this.isActiveId});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  late TextEditingController _controller;
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      height: 246,
      decoration: const BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.all(Radius.circular(16))),
      width: double.infinity,
      child: Form(
        key: _key,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text(
              AppConstString.forgetPasswordDialogtitle.tr(),
              textScaleFactor: 1.0,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 13),
            ),
            MobileTextField(_controller),
            PrimaryButton(
              text: AppConstString.submit.tr(),
              onTap: () {
                if (_key.currentState!.validate()) {
                  Navigator.pop(context);
                  context.router.push(OtpScreenRoute(
                      otpType: widget.isActiveId == true
                          ? 'Active Id'
                          : 'Forgot Password',
                      mobileNumber: _controller.text));
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
