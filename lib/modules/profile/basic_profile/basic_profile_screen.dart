import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:defenders/config/manager/global_singleton.dart';
import 'package:defenders/config/theme/app_colors.dart';
import 'package:defenders/config/theme/app_text_style.dart';
import 'package:defenders/constants/app_const_assets.dart';
import 'package:defenders/constants/app_sizes.dart';
import 'package:defenders/constants/common_style.dart';
import 'package:defenders/model/auth_model/city_model.dart';
import 'package:defenders/model/profile/profile_model.dart';
import 'package:defenders/modules/profile/basic_profile/basic_profile_model.dart';
import 'package:defenders/modules/profile/basic_profile/basic_profile_presenter.dart';
import 'package:defenders/modules/profile/basic_profile/basic_profile_view.dart';
import 'package:defenders/widget/appbars/custom_app_bar.dart';
import 'package:defenders/widget/button/primary_button.dart';
import 'package:defenders/widget/list_widget/list_widget_screen.dart';
import 'package:defenders/widget/textfields/default_text_field.dart';
import 'package:defenders/widget/textfields/pincode_text_field.dart';

class BasicProfileScreen extends StatefulWidget {
  final ProfileData data;
  const BasicProfileScreen({super.key, required this.data});

  @override
  State<BasicProfileScreen> createState() => _BasicProfileScreenState();
}

class _BasicProfileScreenState extends State<BasicProfileScreen>
    implements BasicProfileView {
  String isGender = 'Male';
  String? birthDateInString;
  DateTime? birthDate;
  BasicProfilePresenter presenter = BasicBasicProfilePresenter();
  late BasicProfileModel model;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  DateTime? joiningDate;
  DateTime? authorixationDate;
  final List<String> _dropdownValues = [
    "Male",
    "Female",
  ];

  @override
  void initState() {
    super.initState();
    presenter.updateView = this;
    model.firstName.text = '${widget.data.firstName}';
    model.lastName.text = '${widget.data.lastName}';
    model.email.text = widget.data.email!;
    if (widget.data.district != null) {
      model.dist.text = widget.data.district!;
    }

    model.state.text = widget.data.circle!;
    if (widget.data.dob != null) {
      model.dob.text = widget.data.dob!;
    }
  }

  @override
  void refreshModel(BasicProfileModel mainHomeModel) {
    model = mainHomeModel;
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _pickImages() async {
    XFile? pickedImages = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    // if (pickedImages != null) {
    //   model.selectedImages = pickedImages;
    // }

    if (pickedImages != null) {
      if (isImageFile(pickedImages.path)) {
        model.selectedImages = pickedImages;
      } else {
        dialogData();
      }
    }
    setState(() {});
  }

  bool isImageFile(String filePath) {
    final validExtensions = ['.jpg', '.jpeg'];

    // Get the file extension
    final String extension = filePath.toLowerCase().split('.').last;

    // Check if the extension is in the list of valid extensions
    return validExtensions.contains(".$extension");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'My Profile'),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: CommonStyleDecoration.serviceBoxDecoration(),
              child: Column(
                children: [
                  if (model.selectedImages == null)
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: AppColors.appColors),
                              shape: BoxShape.circle),
                          child: InkWell(
                            onTap: _pickImages,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(999),
                              child: GlobalSingleton.profilePic != null
                                  ? Image.network(
                                      'https://secure.mirror.org.in/${GlobalSingleton.profilePic}',
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.asset(
                                      AppAssets.appLogo,
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.contain,
                                    ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 5,
                          right: -10,
                          child: InkWell(
                            onTap: _pickImages,
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.appColors),
                              child: const Icon(
                                Icons.edit,
                                color: AppColors.whiteColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  if (model.selectedImages != null)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(999),
                      child: Image.file(
                        File(
                          model.selectedImages!.path,
                        ),
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                  const SizedBox(
                    height: AppSizes.size10,
                  ),
                  Text(
                    '${GlobalSingleton.loginInfo!.data!.firstName!} ${GlobalSingleton.loginInfo!.data!.lastName!}',
                    style: AppTextStyle.semiBold18,
                  ),
                  // const Text('Team Leader'),
                  // const SizedBox(
                  //   height: AppSizes.size10,
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.call),
                      const SizedBox(
                        width: 6,
                      ),
                      Text(GlobalSingleton.loginInfo!.data!.mobile.toString()),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.email),
                      const SizedBox(
                        width: 6,
                      ),
                      Text(GlobalSingleton.loginInfo!.data!.email.toString()),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            const Divider(
              color: AppColors.blackColor,
            ),
            const SizedBox(
              height: 10,
            ),
            // SizedBox(
            //   height: 130,
            //   child: ListView(
            //     scrollDirection: Axis.horizontal,
            //     children: [
            //       Card(
            //         child: Container(
            //           padding: const EdgeInsets.all(20),
            //           margin: const EdgeInsets.symmetric(horizontal: 10),
            //           child: Column(
            //             children: [
            //               Image.asset(
            //                 AppAssets.visting,
            //                 height: 50,
            //                 width: 50,
            //               ),
            //               const SizedBox(
            //                 height: 6,
            //               ),
            //               const Text('Visiting Card')
            //             ],
            //           ),
            //         ),
            //       ),
            //       // Card(
            //       //   child: Container(
            //       //     padding: const EdgeInsets.all(20),
            //       //     margin: const EdgeInsets.symmetric(horizontal: 10),
            //       //     child: Column(
            //       //       children: [
            //       //         Image.asset(
            //       //           AppAssets.idcard,
            //       //           height: 50,
            //       //           width: 50,
            //       //         ),
            //       //         const SizedBox(
            //       //           height: 6,
            //       //         ),
            //       //         const Text('ID Card')
            //       //       ],
            //       //     ),
            //       //   ),
            //       // ),
            //       // Card(
            //       //   child: Container(
            //       //     padding: const EdgeInsets.all(20),
            //       //     margin: const EdgeInsets.symmetric(horizontal: 10),
            //       //     child: Column(
            //       //       children: [
            //       //         Image.asset(
            //       //           AppAssets.aggremt,
            //       //           height: 50,
            //       //           width: 50,
            //       //         ),
            //       //         const SizedBox(
            //       //           height: 6,
            //       //         ),
            //       //         const Text('Agreement & Offer Letter')
            //       //       ],
            //       //     ),
            //       //   ),
            //       // ),
            //     ],
            //   ),
            // ),
            const SizedBox(
              height: 10,
            ),
            // GestureDetector(
            //   onTap: () async {
            //     final datePick = await showDatePicker(
            //       context: context,
            //       initialDate: DateTime(2013),
            //       firstDate: DateTime(1950),
            //       lastDate: DateTime(2013),
            //     );
            //     if (datePick != null && datePick != joiningDate) {
            //       setState(() {
            //         joiningDate = datePick;
            //         model.joiningDate.text =
            //             "${joiningDate!.year}-${joiningDate!.month}-${joiningDate!.day}";
            //       });
            //     }
            //   },
            //   child: Container(
            //     height: 50,
            //     padding: const EdgeInsets.symmetric(horizontal: 15),
            //     decoration: BoxDecoration(
            //       border: Border.all(color: AppColors.blackColor),
            //       borderRadius: BorderRadius.circular(15),
            //     ),
            //     child: Row(
            //       children: [
            //         Text(
            //           model.joiningDate.text.isNotEmpty
            //               ? model.joiningDate.text
            //               : 'Select your Joining date',
            //           textScaleFactor: 1.0,
            //           style: TextStyle(
            //             color: Colors.grey.shade800,
            //             fontSize: 16,
            //           ),
            //         ),
            //         const Spacer(),
            //         const Icon(
            //           Icons.calendar_month_outlined,
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            // const SizedBox(
            //   height: AppSizes.size10,
            // ),
            // GestureDetector(
            //   onTap: () async {
            //     final datePick = await showDatePicker(
            //       context: context,
            //       initialDate: DateTime(2013),
            //       firstDate: DateTime(1950),
            //       lastDate: DateTime(2013),
            //     );
            //     if (datePick != null && datePick != authorixationDate) {
            //       setState(
            //         () {
            //           authorixationDate = datePick;
            //           model.authorizationDate.text =
            //               "${authorixationDate!.year}-${authorixationDate!.month}-${authorixationDate!.day}";
            //         },
            //       );
            //     }
            //   },
            //   child: Container(
            //     height: 50,
            //     padding: const EdgeInsets.symmetric(horizontal: 15),
            //     decoration: BoxDecoration(
            //       border: Border.all(color: AppColors.blackColor),
            //       borderRadius: BorderRadius.circular(15),
            //     ),
            //     child: Row(
            //       children: [
            //         Text(
            //           model.authorizationDate.text.isNotEmpty
            //               ? model.authorizationDate.text
            //               : 'Select your Authorixation date',
            //           textScaleFactor: 1.0,
            //           style: TextStyle(
            //             color: Colors.grey.shade800,
            //             fontSize: 16,
            //           ),
            //         ),
            //         const Spacer(),
            //         const Icon(
            //           Icons.calendar_month_outlined,
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            const SizedBox(
              height: AppSizes.size10,
            ),
            DefaultTextField(
              controller: model.firstName,
              color: AppColors.whiteColor,
              prefixicon: const SizedBox(),
              labelTextStrr: 'Full Name',
            ),
            DefaultTextField(
              controller: model.lastName,
              color: AppColors.whiteColor,
              prefixicon: const SizedBox(),
              labelTextStrr: 'Last Name',
            ),
            // DefaultTextField(
            //   controller: model.email,
            //   color: AppColors.whiteColor,
            //   prefixicon: const SizedBox(),
            //   readOnly: true,
            //   labelTextStrr: 'Email ID',
            // ),
            // DefaultTextField(
            //   controller: model.state,
            //   color: AppColors.whiteColor,
            //   prefixicon: const SizedBox(),
            //   labelTextStrr: 'State',
            // ),
            // DefaultTextField(
            //   controller: model.dist,
            //   color: AppColors.whiteColor,
            //   prefixicon: const SizedBox(),
            //   labelTextStrr: 'Dist',
            // ),
            PincodeTextField(
              controller: model.pincodeController,
              fillColor: AppColors.whiteColor,
              onTextChanged: (p0) {
                if (p0.length == 6) {
                  FocusScope.of(context).unfocus();
                  presenter.getPinCode(
                      pinCode: model.pincodeController.text, context: context);
                }
              },
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 55,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: AppColors.blackColor),
                        color: AppColors.whiteColor),
                    child: Center(
                      child: Text(
                        model.stateController.text.isNotEmpty
                            ? model.stateController.text
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
                        model.cityController.text = selectedCity.name!;
                        setState(() {});
                      }
                    },
                    child: Container(
                      height: 55,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: AppColors.blackColor),
                          color: AppColors.whiteColor),
                      child: Center(
                        child: Text(
                          model.cityController.text.isNotEmpty
                              ? model.cityController.text
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
              height: AppSizes.size6,
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
                height: 50,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.blackColor),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
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
              height: AppSizes.size16,
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
                    filled: true,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      borderSide: BorderSide(width: 1.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
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
            PrimaryButton(
              text: 'Update',
              onTap: () {
                // if (_formKey.currentState!.validate()) {
                presenter.addProfile(context: context);
                // }
              },
            ),
            const SizedBox(
              height: 15,
            ),
          ],
        ),
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
                Image.asset(AppAssets.appLogo),
                const SizedBox(
                  height: AppSizes.size10,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Dear User you have upload Invalid file type. Please select a JPEG or JPG File.",
                  textScaleFactor: 1.0,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.center,
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 40),
                      decoration: BoxDecoration(
                        color: AppColors.appColors,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: const Text(
                        'Understood',
                        textScaleFactor: 1.0,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
