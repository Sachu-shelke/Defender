// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:defenders/config/manager/global_singleton.dart';
import 'package:defenders/config/routes/router_import.gr.dart';
import 'package:defenders/config/theme/app_colors.dart';
import 'package:defenders/config/theme/app_text_style.dart';
import 'package:defenders/constants/app_const_text.dart';
import 'package:defenders/constants/method/common_method.dart';
import 'package:defenders/main.dart';
import 'package:defenders/modules/auth/mpin/mpin_screen_model.dart';
import 'package:defenders/modules/auth/mpin/mpin_screen_presenter.dart';
import 'package:defenders/modules/auth/mpin/mpin_screen_view.dart';
import 'package:defenders/widget/logo.dart';
import 'package:local_auth/local_auth.dart';

@RoutePage()
class PinCodeOtp extends StatefulWidget {
  final bool isSignup;
  final bool isSplash;
  final bool? isForgetOtp;
  const PinCodeOtp({
    super.key,
    required this.isSignup,
    required this.isSplash,
    this.isForgetOtp,
  });

  @override
  // ignore: library_private_types_in_public_api
  _PinCodeOtpState createState() => _PinCodeOtpState();
}

class _PinCodeOtpState extends State<PinCodeOtp>
    with SingleTickerProviderStateMixin
    implements MpinView {
  late Size _screenSize;

  bool isAuth = false;

  Timer? timer;
  int? totalTimeInSeconds;
  String userName = "";

  Animation<double>? animation;
  final LocalAuthentication auth = LocalAuthentication();
  late MpinScreenModel model;
  MpinScreenPresenter presenter = BasicMpinScreenPresenter();

  @override
  void initState() {
    super.initState();
    presenter.mpinView = this;
    model.controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    _auth();
  }

  get _getInstructionText {
    return Text(
      model.str,
      textScaleFactor: 1.0,
      style: AppTextStyle.black16,
    );
  }

  @override
  void refreshModel(MpinScreenModel mpinModel) {
    if (mounted) {
      setState(() {
        model = mpinModel;
      });
    }
  }

  // Returns "OTP" input part
  get _getInputPart {
    final Animation<double> offsetAnimation = Tween(begin: 0.0, end: 24.0)
        .chain(CurveTween(curve: Curves.elasticIn))
        .animate(model.controller!)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          model.controller!.reverse();
        }
      });
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 40,
          ),
          const Logo(
            logoSize: 70,
            isCenter: false,
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                const Icon(Icons.lock, size: 40),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    widget.isForgetOtp == true
                        ? 'Set New Mpin'
                        : AppConstString.enterMpin.tr(),
                    textScaleFactor: 1.0,
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  AppConstString.enteryourmpin.tr(),
                  textScaleFactor: 1.0,
                ),
                const SizedBox(
                  height: 10,
                ),
                AnimatedBuilder(
                    animation: offsetAnimation,
                    builder: (buildContext, child) {
                      if (offsetAnimation.value < 0.0) {
                        debugPrint('${offsetAnimation.value + 8.0}');
                      }
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 24.0),
                        padding: EdgeInsets.only(
                            left: offsetAnimation.value + 24.0,
                            right: 24.0 - offsetAnimation.value),
                        child: _getColorInputField,
                      );
                    }),
                const SizedBox(
                  height: 10,
                ),
                _getInstructionText,
                const SizedBox(
                  height: 14,
                ),
                _getOtpKeyboard
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _getColorTextField(int? digit) {
    return Container(
      width: 24.0,
      height: 24.0,
      margin: const EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.appColors,
        ),
        color: digit != null ? AppColors.appColors : AppColors.whiteColor,
      ),
    );
  }

  get _getColorInputField {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _getColorTextField(model.firstDigit),
        _getColorTextField(model.secondDigit),
        _getColorTextField(model.thirdDigit),
        _getColorTextField(model.fourthDigit),
      ],
    );
  }

  get _getOtpKeyboard {
    return Container(
        height: 360,
        color: Colors.grey[300],
        child: Column(
          children: <Widget>[
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _otpKeyboardInputButton(
                      label: "1",
                      onPressed: () {
                        _setCurrentDigit(1);
                      }),
                  _otpKeyboardInputButton(
                      label: "2",
                      onPressed: () {
                        _setCurrentDigit(2);
                      }),
                  _otpKeyboardInputButton(
                      label: "3",
                      onPressed: () {
                        _setCurrentDigit(3);
                      }),
                ],
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _otpKeyboardInputButton(
                      label: "4",
                      onPressed: () {
                        _setCurrentDigit(4);
                      }),
                  _otpKeyboardInputButton(
                      label: "5",
                      onPressed: () {
                        _setCurrentDigit(5);
                      }),
                  _otpKeyboardInputButton(
                      label: "6",
                      onPressed: () {
                        _setCurrentDigit(6);
                      }),
                ],
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _otpKeyboardInputButton(
                      label: "7",
                      onPressed: () {
                        _setCurrentDigit(7);
                      }),
                  _otpKeyboardInputButton(
                      label: "8",
                      onPressed: () {
                        _setCurrentDigit(8);
                      }),
                  _otpKeyboardInputButton(
                      label: "9",
                      onPressed: () {
                        _setCurrentDigit(9);
                      }),
                ],
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  widget.isSignup == true
                      ? const SizedBox(
                          width: 80.0,
                        )
                      : _otpKeyboardInputButton(
                          label: "Forget\nMPIN",
                          onPressed: () {
                            _setCurrentDigit(11);
                          }),
                  _otpKeyboardInputButton(
                      label: "0",
                      onPressed: () {
                        _setCurrentDigit(0);
                      }),
                  _otpKeyboardActionButton(
                      label: const Icon(
                        Icons.backspace,
                        color: AppColors.blackColor,
                      ),
                      onPressed: () {
                        setState(() {
                          if (model.fourthDigit != null) {
                            model.fourthDigit = null;
                          } else if (model.thirdDigit != null) {
                            model.thirdDigit = null;
                          } else if (model.secondDigit != null) {
                            model.secondDigit = null;
                          } else if (model.firstDigit != null) {
                            model.firstDigit = null;
                          }
                        });
                      }),
                ],
              ),
            ),
          ],
        ));
  }

  _auth() async {
    try {
      bool canCheckBiometrics = await auth.canCheckBiometrics;
      if (canCheckBiometrics) {
        try {
          bool authenticated = await auth.authenticate(
            localizedReason: 'Touch your finger on the sensor to continue',
          );
          if (authenticated) {
            CommonMethod().getUserLog(action: 'Business_login', id: 7);
            // For main Screen code

            context.router
                .push(MainHomeScreenRoute(isFromSignup: widget.isSignup));
            // context.router.pushAndPopUntil(
            //     MainRoute(isRegister: widget.isSignup),
            //     predicate: (route) => false);
          }
        } catch (e) {
          debugPrint(e.toString());
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    _screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        width: _screenSize.width,
        child: _getInputPart,
      ),
    );
  }

  // Returns "Otp keyboard input Button"
  Widget _otpKeyboardInputButton(
      {required String label, VoidCallback? onPressed}) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(40.0),
        child: Container(
          height: 50.0,
          width: 100.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            // ignore: prefer_const_literals_to_create_immutables
            boxShadow: [
              const BoxShadow(
                  blurRadius: 14,
                  offset: Offset(0, 0),
                  color: Color.fromRGBO(0, 0, 0, 0.1),
                  spreadRadius: 0)
            ],
            color: AppColors.whiteColor,
          ),
          child: Center(
            child: Text(
              label,
              textScaleFactor: 1.0,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: label == 'Forget\nMPIN' ? 13 : 22.0,
                color: AppColors.blackColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Returns "Otp keyboard action Button"
  _otpKeyboardActionButton({Widget? label, VoidCallback? onPressed}) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(40.0),
      child: Container(
        height: 50.0,
        width: 100.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: const [
            BoxShadow(
                blurRadius: 4,
                offset: Offset(0, 0),
                color: Color.fromRGBO(0, 0, 0, 0.1),
                spreadRadius: 0)
          ],
          color: AppColors.whiteColor,
        ),
        child: Center(
          child: label,
        ),
      ),
    );
  }

  // Current digit
  void _setCurrentDigit(int i) async {
    if (i == 11) {
      context.router.push(
        OtpScreenRoute(
            otpType: 'Forget MPIN',
            mobileNumber: GlobalSingleton.loginInfo!.data!.mobile.toString()),
      );
      // Update
    } else {
      model.currentDigit = i;
      if (model.firstDigit == null) {
        model.firstDigit = model.currentDigit;
      } else if (model.secondDigit == null) {
        model.secondDigit = model.currentDigit;
      } else if (model.thirdDigit == null) {
        model.thirdDigit = model.currentDigit;
      } else if (model.fourthDigit == null) {
        model.fourthDigit = model.currentDigit;
        var otp = model.firstDigit.toString() +
            model.secondDigit.toString() +
            model.thirdDigit.toString() +
            model.fourthDigit.toString();
        appRouter.push(MainHomeScreenRoute());
        // presenter.getMpinApi(
        //     mpin: otp,
        //     crn: context,
        //     action: (widget.isForgetOtp == true || widget.isSignup == true)
        //         ? 'Update'
        //         : null,
        //     userid: GlobalSingleton.loginInfo!.data!.id.toString(),
        //     isFromSignup: widget.isSignup);
      }
    }

    setState(() {});
  }
}
