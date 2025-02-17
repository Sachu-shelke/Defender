import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:defenders/config/manager/global_singleton.dart';
import 'package:defenders/config/theme/app_colors.dart';
import 'package:defenders/config/theme/app_text_style.dart';
import 'package:defenders/constants/method/common_method.dart';
import 'package:defenders/model/auth_model/signup_model.dart';
import 'package:defenders/utils/api_path.dart';
import 'package:defenders/utils/encrypted_api_path.dart';
import 'package:defenders/utils/network/network_dio.dart';
import 'package:defenders/widget/appbars/custom_app_bar.dart';
import 'package:defenders/widget/button/primary_button.dart';

@RoutePage()
class SignupProfileScreen extends StatefulWidget {
  // final SignupModel signmodel;
  // final RegistrationPresenter presenter;
  const SignupProfileScreen({
    super.key,
  });

  @override
  State<SignupProfileScreen> createState() => _SignupProfileScreenState();
}

class _SignupProfileScreenState extends State<SignupProfileScreen> {
  final List<String> _dropdownValues = [
    "Male",
    "Female",
  ];
  final GlobalKey<FormState> _formKey = GlobalKey();
  String isGender = 'Male';
  String? birthDateInString;
  String? anniversaryInString;
  DateTime? birthDate;
  DateTime? anniversary;
  SignupModel? signupModel;

  _onSignup() async {
    if (_formKey.currentState!.validate()) {
      if (birthDateInString != null) {
        @override
        Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
          url: ApiPath.apiEndPoint + EncryptedApiPath.updateProfile,
          context: context,
          isEncryptionUse: true,
          data: FormData.fromMap(
            {
              'user_id': GlobalSingleton.loginInfo!.data!.id.toString(),

              // if (model.selectedCity != null) 'district': model.selectedCity!.name,
              // if (model.selectedState != null) 'circle': model.selectedState!.name,
              // if (model.selectedState != null) "state_id": model.selectedState!.id,
              // if (model.selectedCity != null) "city_id": model.selectedCity!.id,
              'dob': birthDateInString,
              'gender': isGender,
            },
          ),
        );
        if (response != null && response['status'] == 200) {
          Navigator.pop(context);
          // GlobalSingleton.loginInfo!.data!.firstName = model.firstName.text;
          // GlobalSingleton.loginInfo!.data!.lastName = model.lastName.text;
          // GlobalSingleton.loginInfo!.data!.circle = model.state.text;
          // GlobalSingleton.loginInfo!.data!.dob = model.dob.text;
          // StorageManager.setStringValue(
          //   key: 'data',
          //   value: encrypt(
          //     text: jsonEncode(GlobalSingleton.loginInfo),
          //   ),
          // );
          // ScaffoldMessenger.of(context).showSnackBar(
          //     SnackBars.successSnackBar(
          //         title: 'Profile Update successfully'));
          // context.router.push(MainHomeScreenRoute(isFromSignup: false));
        }
      } else {
        CommonMethod().dialogData(
            context: context,
            title: 'Error',
            errorMessage: "Please select your birthdate");
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBars.errorSnackBar(title: 'Please select your birthdate'),
        // );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: const CustomAppBar(
          leading: SizedBox(),
          title: 'Update Profile',
          elevation: 0,
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 15,
                ),
                Text(
                  'Gender',
                  style: AppTextStyle.regular14,
                ),
                DropdownButtonHideUnderline(
                  child: DropdownButtonFormField<String>(
                    isDense: false,
                    items: _dropdownValues
                        .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              textScaleFactor: 1.0,
                              style: const TextStyle(fontSize: 16),
                            ),
                          );
                        })
                        .toSet()
                        .toList(),
                    onChanged: (value) {
                      isGender = value!;
                      setState(() {});
                    },
                    decoration: const InputDecoration(
                        fillColor: AppColors.whiteColor,
                        // fillColor: Appc,
                        filled: true,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide: BorderSide(width: 1.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide: BorderSide(width: 1.0),
                        )),
                    hint: Text(
                      'Select your Gender',
                      textScaleFactor: 1.0,
                      style: TextStyle(color: Colors.grey.shade800),
                    ),
                    isExpanded: true,
                    validator: (value) =>
                        value == null ? 'This field required' : null,
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      size: 30,
                    ),
                    iconSize: 24,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  'Birth Date',
                  style: AppTextStyle.regular14,
                ),
                GestureDetector(
                  // child: const Icon(Icons.calendar_today),
                  onTap: () async {
                    final datePick = await showDatePicker(
                      context: context,
                      initialDate: DateTime(2013),
                      firstDate: DateTime(1950),
                      lastDate: DateTime(2013),
                    );
                    if (datePick != null && datePick != birthDate) {
                      setState(() {
                        birthDate = datePick;
                        birthDateInString =
                            "${birthDate!.year}-${birthDate!.month}-${birthDate!.day}";
                        // "${birthDate!.day}-${birthDate!.month}-${birthDate!.year}";
                        // 08/14/2019
                      });
                    }
                  },
                  child: Container(
                    height: 60,
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.greyColor),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        // Padding(
                        //   padding: const EdgeInsets.all(15),
                        //   child: const Icon(
                        //     Icons.calendar_month_outlined,
                        //   ),
                        // ),
                        Text(
                          birthDateInString != null
                              ? birthDateInString!
                              : 'Select your birth date',
                          textScaleFactor: 1.0,
                          style: TextStyle(
                            color: Colors.grey.shade800,
                            fontSize: 16,
                          ),
                        ),
                        const Spacer(),
                        const Icon(
                          Icons.calendar_month_outlined,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  'Anniversary Date',
                  style: AppTextStyle.regular14,
                ),
                GestureDetector(
                  // child: const Icon(Icons.calendar_today),
                  onTap: () async {
                    final datePick = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1950),
                      lastDate: DateTime.now(),
                    );
                    if (datePick != null && datePick != anniversary) {
                      setState(() {
                        anniversary = datePick;
                        anniversaryInString =
                            "${anniversary!.year}-${anniversary!.month}-${anniversary!.day}";
                        // "${anniversary!.day}-${anniversary!.month}-${anniversary!.year}"; // 08/14/2019
                      });
                    }
                  },
                  child: Container(
                    height: 60,
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.greyColor),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Padding(
                        //   padding: const EdgeInsets.all(15),
                        //   child: const Icon(
                        //     Icons.calendar_month_outlined,
                        //   ),
                        // ),
                        Text(
                          anniversaryInString != null
                              ? anniversaryInString!
                              : 'Select your anniversary',
                          textScaleFactor: 1.0,
                          style: TextStyle(
                            color: Colors.grey.shade800,
                            fontSize: 16,
                          ),
                        ),
                        const Spacer(),
                        const Icon(
                          Icons.calendar_month_outlined,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Spacer(),
                PrimaryButton(
                  text: 'Update',
                  onTap: _onSignup,
                )
              ],
            ),
          ),
        ),
        //
      ),
    );
  }
}
