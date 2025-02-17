// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:defenders/config/routes/router_import.gr.dart';
import 'package:defenders/config/theme/app_colors.dart';
import 'package:defenders/config/theme/app_text_style.dart';
import 'package:defenders/constants/app_const_assets.dart';
import 'package:defenders/constants/app_const_text.dart';
import 'package:defenders/constants/app_sizes.dart';
import 'package:defenders/constants/extension/double_to_int.dart';
import 'package:defenders/model/auth_model/city_model.dart';
import 'package:defenders/model/auth_model/signup_model.dart';
import 'package:defenders/modules/auth/registration/registration_model.dart';
import 'package:defenders/modules/auth/registration/registration_presenter.dart';
import 'package:defenders/modules/auth/registration/registration_view.dart';
import 'package:defenders/widget/appbars/custom_app_bar.dart';
import 'package:defenders/widget/button/primary_button.dart';
import 'package:defenders/widget/list_widget/list_widget_screen.dart';
import 'package:defenders/widget/textfields/default_text_field.dart';
import 'package:defenders/widget/textfields/email_text_field.dart';
import 'package:defenders/widget/textfields/mobile_text_field.dart';
import 'package:defenders/widget/textfields/password_text_field.dart';
import 'package:defenders/widget/textfields/pincode_text_field.dart';

@RoutePage()
class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen>
    implements RegistrationView {
  final GlobalKey<FormState> _formKey = GlobalKey();

  Timer? _debounce;
  late RegistrationModel model;
  RegistrationPresenter presenter = BasicRegistrationPresenter();

  @override
  void initState() {
    super.initState();
    presenter.registrationView = this;
    // presenter.getState(countryId: '101');
  }

  // _onSearchChanged(String query) {
  //   if (_debounce?.isActive ?? false) _debounce?.cancel();
  //   _debounce = Timer(const Duration(seconds: 3), () {
  //     presenter.getRefferBy(context: context, mlmId: query);
  //   });
  // }

  _onSearchChanged(String query) {
    model.refferalDetaisl = null;
    if (query.isNotEmpty && query.length > 9) {
      if (_debounce?.isActive ?? false) _debounce?.cancel();
      _debounce = Timer(const Duration(seconds: 2), () {
        presenter.getRefferBy(context: context, mlmId: query);
      });
    }
    if (query.isEmpty || query.length < 9) {
      model.refferalDetaisl = null;
    }
    setState(() {});
  }

  @override
  void refreshModel(RegistrationModel registrationModel) {
    if (mounted) {
      setState(() {
        model = registrationModel;
      });
    }
  }

  onSIgnup() {
    if (_formKey.currentState!.validate()) {
      if (model.refferalDetaisl != null || model.dontHaveReffere == true) {
        context.router.push(OtpScreenRoute(
            otpType: 'REGISTER',
            presenter: presenter,
            mobileNumber: model.phoneController!.text,
            signupModel: SignupModel(
              circle: model.cityController!.text,
              countryId: '111',
              division: model.stateController!.text,
              dob: '2013-01-01',
              email: model.emailController!.text,
              district: model.stateController!.text,
              firstName: model.firstnameController!.text.toTitleCase(),
              lastName: model.lastnameController!.text.toTitleCase(),
              aniversartDate: '2013-01-01',
              refrredBy: model.dontHaveReffere == true
                  ? '65535'
                  : model.refferalDetaisl!.id.toString(),
              mobile: model.phoneController!.text,
              password: model.passwordController!.text,
              pincode: model.pincodeController!.text,
              postOfficeName: 'Mirror',
              region: model.stateController!.text,
              username: model.emailController!.text,
            )));
        // context.router.push(TermAndConditionScreenRoute(
        //     presenter: presenter,
        //     signupModel: SignupModel(
        //       circle: model.cityController!.text,
        //       countryId: '111',
        //       division: model.stateController!.text,
        //       dob: '2023-01-09',
        //       email: model.emailController!.text,
        //       district: model.stateController!.text,
        //       firstName: model.firstnameController!.text.toTitleCase(),
        //       lastName: model.lastnameController!.text.toTitleCase(),
        //       aniversartDate: '2023-01-09',
        //       refrredBy: model.dontHaveReffere == true
        //           ? '65535'
        //           : model.refferalDetaisl!.id.toString(),
        //       mobile: model.phoneController!.text,
        //       password: model.passwordController!.text,
        //       pincode: model.pincodeController!.text,
        //       postOfficeName: 'Mirror',
        //       region: model.stateController!.text,
        //       username: model.emailController!.text,
        //     )));
      } else {
        dialogData();
        // ScaffoldMessenger.of(context).showSnackBar(
        //     SnackBars.errorSnackBar(
        //         title: 'Enter Valid Refernce Id'));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'New Signup',
        elevation: 0,
      ),
      body: Stack(
        children: [
          Form(
            key: _formKey,
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.appColors,
                    AppColors.secoundColors,
                  ],
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                margin: const EdgeInsets.symmetric(vertical: 10),
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    Focus(
                      onFocusChange: (hasFocus) {},
                      child: DefaultTextField(
                        controller: model.referCodeController,
                        labelTextStrr: 'Referral Code',
                        isValidation: false,
                        onChanged: _onSearchChanged,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(10),
                          FilteringTextInputFormatter.allow(
                              RegExp("[a-zA-Z0-9]")),
                        ],
                        suffix: InkWell(
                          onTap: () {
                            model.refferalDetaisl = null;
                            if (model.referCodeController!.text.isNotEmpty) {
                              presenter.getRefferBy(
                                  context: context,
                                  mlmId: model.referCodeController!.text);
                            }
                            setState(() {});
                          },
                          child: const Text(
                            "Verify",
                            textScaleFactor: 1.0,
                            style: TextStyle(color: AppColors.appColors),
                          ),
                        ),
                      ),
                    ),
                    if (model.refferalDetaisl != null &&
                        model.refferalDetaisl!.name != null)
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(model.refferalDetaisl!.name.toString(),
                            textScaleFactor: 1.0,
                            style: AppTextStyle.semiBold16
                                .copyWith(color: AppColors.sucessGreen)),
                      ),
                    DefaultTextField(
                      controller: model.firstnameController,
                      labelTextStrr: 'First Name',
                      maxLines: 1,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(15),
                        FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
                      ],
                    ),
                    DefaultTextField(
                      controller: model.lastnameController,
                      labelTextStrr: 'Last Name',
                      maxLines: 1,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(15),
                        FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
                      ],
                    ),
                    EmailTextField(
                      controller: model.emailController,
                      prefixWidget: const Icon(Icons.email),
                    ),
                    PasswordTextField(
                      model.passwordController,
                      // validator: Validators.validatePassword,
                      fillColor: AppColors.containerbg,
                    ),
                    MobileTextField(
                      model.phoneController,
                    ),

                    // Row(children: [
                    //   Checkbox(
                    //       activeColor: AppColors.appColors,
                    //       value: model.dontHaveReffere,
                    //       onChanged: (val) {
                    //         if (model.refferalDetaisl != null) {
                    //         } else {
                    //           setState(() {
                    //             model.refferalDetaisl = null;
                    //             model.dontHaveReffere = val!;
                    //           });
                    //         }
                    //       }),
                    //   Text(
                    //     'I Dont Have a Refer Code',
                    //     style: AppTextStyle.semiBold14.copyWith(
                    //         color: model.refferalDetaisl != null
                    //             ? AppColors.textGreyColor
                    //             : AppColors.blackColor),
                    //   )
                    // ]),
                    PincodeTextField(
                      controller: model.pincodeController,
                      onTextChanged: (p0) {
                        if (p0.length == 6) {
                          FocusScope.of(context).unfocus();
                          presenter.getPinCode(
                              pinCode: model.pincodeController!.text,
                              context: context);
                        }
                      },
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 60,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(color: AppColors.blackColor),
                                color: AppColors.containerbg),
                            child: Center(
                              child: Text(
                                model.stateController!.text.isNotEmpty
                                    ? model.stateController!.text
                                    : 'Select State',
                                style: AppTextStyle.regular16
                                    .copyWith(color: AppColors.blackColor),
                              ),
                            ),
                          ),

                          // DefaultTextField(
                          //   controller: model.stateController,
                          //   readOnly: true,
                          //   onTap: () async {
                          //     // final States selectedState = await Navigator.push(
                          //     //   context,
                          //     //   MaterialPageRoute(
                          //     //     builder: (context) => ListScreen(
                          //     //       list: model.stateModel,
                          //     //       title: 'Select State',
                          //     //     ),
                          //     //   ),
                          //     // ) as States;
                          //     // if (selectedState.id != null) {
                          //     //   model.selectedState = selectedState;
                          //     //   presenter.getCity(
                          //     //       context: context,
                          //     //       stateId: selectedState.id.toString());
                          //     //   model.stateController!.text = selectedState.name!;

                          //     //   setState(() {});
                          //     // }
                          //   },
                          //   errorText: 'Please select state',
                          //   labelTextStrr: 'Select State',
                          // ),
                        ),
                        const SizedBox(
                          width: AppSizes.size10,
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () async {
                              final Cities selectedCity = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ListScreen(
                                    list: model.cityModel,
                                    title: 'Select City',
                                  ),
                                ),
                              ) as Cities;
                              if (selectedCity.id != null) {
                                model.selectedCity = selectedCity;
                                model.cityController!.text = selectedCity.name!;
                                setState(() {});
                              }
                            },
                            child: Container(
                              height: 60,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border:
                                      Border.all(color: AppColors.blackColor),
                                  color: AppColors.containerbg),
                              child: Center(
                                child: Text(
                                  model.cityController!.text.isNotEmpty
                                      ? model.cityController!.text
                                      : 'Select city',
                                  style: AppTextStyle.regular16
                                      .copyWith(color: AppColors.blackColor),
                                ),
                              ),
                            ),
                          ),

                          // DefaultTextField(
                          //   controller: model.cityController,
                          //   readOnly: true,
                          //   onTap: () async {
                          //     print('object');
                          //     final Cities selectedCity = await Navigator.push(
                          //       context,
                          //       MaterialPageRoute(
                          //         builder: (context) => ListScreen(
                          //           list: model.cityModel,
                          //           title: 'Select City',
                          //         ),
                          //       ),
                          //     ) as Cities;
                          //     if (selectedCity.id != null) {
                          //       model.selectedCity = selectedCity;
                          //       model.cityController!.text = selectedCity.name!;
                          //       setState(() {});
                          //     }
                          //   },
                          //   errorText: 'Please select city',
                          //   labelTextStrr: 'Select city',
                          // ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    PrimaryButton(
                      text: AppConstString.register.tr(),
                      onTap: onSIgnup,
                    )
                  ],
                ),
              ),
            ),
          ),
          // if(model.isCityLoader == true)
        ],
      ),
    );
  }

  dialogData() {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(32.0),
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.white,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(AppAssets.rechargePopup),
                const SizedBox(
                  height: AppSizes.size10,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "You don't have enter any referral code, Do you want to proceed?",
                  textScaleFactor: 1.0,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 15),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.appColors),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: const Text(
                          'Back',
                          textScaleFactor: 1.0,
                          style: TextStyle(
                              color: AppColors.appColors,
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        // Navigator.pop(context);
                        model.dontHaveReffere = true;
                        Navigator.pop(context);
                        onSIgnup();
                        setState(() {});
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 65),
                        decoration: BoxDecoration(
                          color: AppColors.appColors,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: const Text(
                          'Proceed',
                          textScaleFactor: 1.0,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    model.firstnameController!.dispose();
    model.lastnameController!.dispose();

    model.emailController!.dispose();
    model.passwordController!.dispose();
    model.phoneController!.dispose();
    model.referCodeController!.dispose();
    _debounce?.cancel();
    // _pincodeController.dispose();
  }
}
