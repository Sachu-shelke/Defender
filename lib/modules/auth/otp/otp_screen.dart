import 'dart:async';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:defenders/config/theme/app_colors.dart';
import 'package:defenders/constants/app_const_assets.dart';
import 'package:defenders/constants/app_const_text.dart';
import 'package:defenders/constants/app_sizes.dart';
import 'package:defenders/constants/method/common_method.dart';
import 'package:defenders/model/auth_model/signup_model.dart';
import 'package:defenders/modules/auth/otp/otp_mode.dart';
import 'package:defenders/modules/auth/otp/otp_presenter.dart';
import 'package:defenders/modules/auth/otp/otp_view.dart';
import 'package:defenders/modules/auth/otp/otp_widget/otp_top_text.dart';
import 'package:defenders/modules/auth/registration/registration_presenter.dart';
import 'package:defenders/modules/send_money/send_money_mobile_number/send_money_presenter.dart';
import 'package:defenders/widget/button/primary_button.dart';
import 'package:pinput/pinput.dart';

@RoutePage()
class OtpScreen extends StatefulWidget {
  final String otpType;
  final String mobileNumber;
  final SignupModel? signupModel;
  final RegistrationPresenter? presenter;
  final SendMoneyPresenter? sendMoneypresenter;
  final String? sendMoneyAmount;
  final String? sendMoneyMobileNumber;
  final String? sendMoneyUserId;
  final String? sendMoneyMessage;
  final String? sendMoneyWalletType;
  const OtpScreen(
      {super.key,
      required this.otpType,
      this.signupModel,
      this.presenter,
      this.sendMoneypresenter,
      this.sendMoneyAmount,
      this.sendMoneyMobileNumber,
      this.sendMoneyUserId,
      this.sendMoneyWalletType,
      this.sendMoneyMessage,
      required this.mobileNumber});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> implements OtpView {
  final pinController = TextEditingController();
  late Timer _timer;
  int _start = 60;
  late OtpModel model;
  OtpPresenter presenter = BasicOtpPresenter();

  @override
  void initState() {
    presenter.otpView = this;
    super.initState();
    _onResend();
  }

  @override
  void refreshModel(OtpModel otpMode) {
    if (mounted) {
      setState(() {
        model = otpMode;
      });
    }
  }

  _onResend() async {
    presenter.getOtp(
        context: context,
        categories: widget.otpType,
        mobileNumber: widget.mobileNumber.toString());
    setState(() {
      _start = 60;
      startTimer();
    });
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // verificationLogo
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 50,
              ),
              // const Logo(),
              Align(
                alignment: Alignment.center,
                child: Image.asset(
                  AppAssets.smsOtp,
                  height: 200,
                  width: 200,
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  AppConstString.otpVerfication.tr(),
                  textScaleFactor: 1.0,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              OtpText(
                textColor: const Color(0xff3F3D3D),
                mobileNumber: widget.mobileNumber,
                isEditButton: false,
              ),
              const SizedBox(
                height: AppSizes.size20,
              ),
              Pinput(
                pinAnimationType: PinAnimationType.slide,
                showCursor: true,
                controller: pinController,
                cursor: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: 56,
                      height: 3,
                      decoration: BoxDecoration(
                        color: AppColors.appColors,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ],
                ),
                preFilledWidget: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: 56,
                      height: 3,
                      decoration: BoxDecoration(
                        color: AppColors.appColors.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ],
                ),
                onCompleted: (pin) {
                  debugPrint('onCompleted: $pin');
                },
                onChanged: (value) {
                  debugPrint('onChanged: $value');
                },
                closeKeyboardWhenCompleted: true,
                submittedPinTheme: PinTheme(
                  width: 56,
                  height: 56,
                  textStyle: const TextStyle(
                      fontSize: 20,
                      color: Color.fromRGBO(30, 60, 87, 1),
                      fontWeight: FontWeight.w600),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: AppColors.appColors.withOpacity(0.2)),
                ),
                followingPinTheme: PinTheme(
                  width: 56,
                  height: 56,
                  textStyle: const TextStyle(
                      fontSize: 20,
                      color: Color.fromRGBO(30, 60, 87, 1),
                      fontWeight: FontWeight.w600),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.appColors),
                      color: AppColors.whiteColor.withOpacity(0.2)),
                ),
                disabledPinTheme: PinTheme(
                  width: 56,
                  height: 56,
                  textStyle: const TextStyle(
                      fontSize: 20,
                      color: Color.fromRGBO(30, 60, 87, 1),
                      fontWeight: FontWeight.w600),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.appColors),
                      color: AppColors.whiteColor.withOpacity(0.2)),
                ),
                focusedPinTheme: PinTheme(
                  width: 56,
                  height: 56,
                  textStyle: const TextStyle(
                      fontSize: 20,
                      color: Color.fromRGBO(30, 60, 87, 1),
                      fontWeight: FontWeight.w600),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.appColors),
                      color: AppColors.whiteColor.withOpacity(0.2)),
                ),
                defaultPinTheme: const PinTheme(
                  width: 56,
                  height: 56,
                  textStyle: TextStyle(
                      fontSize: 20,
                      color: Color.fromRGBO(30, 60, 87, 1),
                      fontWeight: FontWeight.w600),
                  decoration: BoxDecoration(),
                ),
                length: 6,
                // listenForMultipleSmsOnAndroid: true,
                // androidSmsAutofillMethod:
                //     AndroidSmsAutofillMethod.smsUserConsentApi,
              ),

              const SizedBox(
                height: 20,
              ),
              PrimaryButton(
                  borderRadius: 15,
                  text: AppConstString.verifyOtp.tr(),
                  color: model.isButtonTap == true ? Colors.grey : null,
                  onTap: () {
                    if (model.isButtonTap == false) {
                      if (pinController.text.length > 5) {
                        model.isButtonTap = true;
                        presenter.verifyOtp(
                            context: context,
                            categories: widget.otpType,
                            mobileNumber: widget.mobileNumber,
                            signUpPresenter: widget.presenter,
                            signupModel: widget.signupModel,
                            otp: pinController.text,
                            sendMoneyAmount: widget.sendMoneyAmount,
                            sendMoneyMessage: widget.sendMoneyMessage,
                            sendMoneyMobileNumber: widget.sendMoneyMobileNumber,
                            sendMoneyUserId: widget.sendMoneyUserId,
                            sendMoneyWalletType: widget.sendMoneyWalletType,
                            sendMoneypresenter: widget.sendMoneypresenter);
                      } else {
                        CommonMethod().dialogData(
                            context: context,
                            title: 'Error',
                            errorMessage: 'Enter Valid OTP');
                        // ScaffoldMessenger.of(context).showSnackBar(
                        //   SnackBars.errorSnackBar(title: 'Enter Valid OTP'),
                        // );
                      }
                    }
                    setState(() {});
                  }),

              const SizedBox(
                height: 30,
              ),
              footer()
            ],
          ),
        ),
      ),
    );
  }

  Widget footer() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          AppConstString.didntReciveCode.tr(),
          textScaleFactor: 1.0,
          style: const TextStyle(
              fontSize: 16,
              color: Color(0xff727374),
              fontWeight: FontWeight.w700),
        ),
        const SizedBox(
          height: 10,
        ),
        _start != 0
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppConstString.resendCodeIn.tr(),
                    textScaleFactor: 1.0,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: AppColors.blackColor,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    _start.toString(),
                    textScaleFactor: 1.0,
                    style: const TextStyle(
                        color: AppColors.secoundColors,
                        fontWeight: FontWeight.bold,
                        fontSize: 19),
                  ),
                ],
              )
            : GestureDetector(
                onTap: () {
                  pinController.clear();
                  _onResend();
                },
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.only(
                      bottom: 1,
                    ),
                    // decoration: const BoxDecoration(
                    //   border: Border(
                    //     bottom: BorderSide(
                    //       color: primaryColor,
                    //       width: 1.5,
                    //     ),
                    //   ),
                    // ),
                    child: Text(
                      AppConstString.resendCode.tr(),
                      textScaleFactor: 1.0,
                      style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 17.5,
                          color: AppColors.blackColor),
                    ),
                  ),
                ))
      ],
    );
  }

  @override
  void dispose() {
    // autofillsms.unregisterListener();
    _timer.cancel();
    super.dispose();
  }
}
