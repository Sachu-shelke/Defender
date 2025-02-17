// ignore_for_file: empty_catches

import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:defenders/config/manager/global_singleton.dart';
import 'package:defenders/config/theme/app_colors.dart';
import 'package:defenders/constants/app_const_text.dart';
import 'package:defenders/constants/method/common_method.dart';
import 'package:defenders/modules/feedback/feedback_complaine/feedback_presenter.dart';
import 'package:defenders/modules/feedback/feedback_complaine/feedback_screen_model.dart';
import 'package:defenders/widget/appbars/custom_app_bar.dart';
import 'package:defenders/widget/button/primary_button.dart';
import 'package:defenders/widget/textfields/default_text_field.dart';

@RoutePage()
class AddFeedbackScreen extends StatefulWidget {
  final FeebackScreenModel model;
  final FeedbackPresenter presenter;
  const AddFeedbackScreen(
      {super.key, required this.model, required this.presenter});

  @override
  State<AddFeedbackScreen> createState() => _AddFeedbackScreenState();
}

class _AddFeedbackScreenState extends State<AddFeedbackScreen> {
  final ImagePicker _picker = ImagePicker();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  _onSelectImage() async {
    try {
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        setState(() {
          widget.model.selectedFile = image.path;
        });
      } else {
        return;
      }
    } catch (e) {}
  }

  _onSubmitRequest() {
    if (_formKey.currentState!.validate()) {
      if (widget.model.selectedFile != null) {
        widget.presenter.addFeedback(
            userID: GlobalSingleton.loginInfo!.data!.id.toString(),
            context: context);
      } else {
        CommonMethod().dialogData(
            context: context,
            title: 'Error',
            errorMessage: 'Upload Deposit Proof');
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBars.errorSnackBar(title: "Upload Deposit Proof"),
        // );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: const CustomAppBar(
          title: "Problem Feedback",
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 4),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Upload Screenshort',
                    textScaleFactor: 1.0,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: _onSelectImage,
                    child: Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: AppColors.appColors)),
                      padding: const EdgeInsets.all(5),
                      child: (widget.model.selectedFile == null)
                          ? const Center(
                              child: Icon(
                                Icons.add,
                                size: 80,
                                color: AppColors.appColors,
                              ),
                            )
                          : Image.file(
                              File(widget.model.selectedFile!),
                              width: 150,
                              height: 150,
                              fit: BoxFit.fill,
                            ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  DefaultTextField(
                    controller: widget.model.controller,
                    labelTextStrr: "Describe Your problem in your Own language",
                    color: AppColors.whiteColor,
                    isPadding: false,
                    prefixicon: const SizedBox(),
                    maxLines: 5,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Note : If you face any problem while performing the services of ${AppConstString.appName}, you can upload the Screenshort of the problem here. The support team will take action on your issue & let you know soon In Next 24 working hours.',
                    textScaleFactor: 1.0,
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: SizedBox(
          height: 50,
          child: Align(
            alignment: Alignment.center,
            child: PrimaryButton(
              borderRadius: 0,
              text: 'Send Feedback',
              onTap: _onSubmitRequest,
            ),
          ),
        ),
      ),
    );
  }
}
