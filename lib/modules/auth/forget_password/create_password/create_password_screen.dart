import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:defenders/constants/app_const_text.dart';
import 'package:defenders/constants/app_sizes.dart';
import 'package:defenders/constants/method/common_method.dart';
import 'package:defenders/modules/auth/forget_password/create_password/create_password_model.dart';
import 'package:defenders/modules/auth/forget_password/create_password/create_password_presenter.dart';
import 'package:defenders/modules/auth/forget_password/create_password/create_password_view.dart';
import 'package:defenders/widget/appbars/custom_app_bar.dart';
import 'package:defenders/widget/button/primary_button.dart';
import 'package:defenders/widget/textfields/password_text_field.dart';

@RoutePage()
class CreatePasswordScreen extends StatefulWidget {
  final String mobilerNumber;
  const CreatePasswordScreen({super.key, required this.mobilerNumber});

  @override
  State<CreatePasswordScreen> createState() => _CreatePasswordScreenState();
}

class _CreatePasswordScreenState extends State<CreatePasswordScreen>
    implements CreatePasswordView {
  final GlobalKey<FormState> _formKey = GlobalKey();
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;
  late CreatePasswordModel model;
  CreatePasswordPresenter presenter = BasicCreatePasswordPresenter();

  @override
  void initState() {
    presenter.createPasswordView = this;
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    super.initState();
  }

  @override
  void refreshModel(CreatePasswordModel loginModel) {
    if (mounted) {
      setState(() {
        model = loginModel;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Forgot Password'),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            children: [
              PasswordTextField(
                labelText: AppConstString.yourPassword.tr(),
                _passwordController,
              ),
              const SizedBox(
                height: AppSizes.size10,
              ),
              PasswordTextField(
                labelText: 'Confirm Your Password',
                _confirmPasswordController,
              ),
              const SizedBox(
                height: AppSizes.size20,
              ),
              const SizedBox(
                height: AppSizes.size20,
              ),
              PrimaryButton(
                text: 'Update',
                color: model.isButtonTap == true ? Colors.grey : null,
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    if (_passwordController.text ==
                        _confirmPasswordController.text) {
                      if (model.isButtonTap == false) {
                        model.isButtonTap = true;
                        presenter.createPassword(
                            password: _passwordController.text,
                            mobile: widget.mobilerNumber,
                            confirmPassword: _confirmPasswordController.text,
                            context: context);
                      }
                    } else {
                      CommonMethod().dialogData(
                          context: context,
                          title: 'Error',
                          errorMessage:
                              "Password and Confirm password doesn't match");
                      // ScaffoldMessenger.of(context).showSnackBar(
                      //     SnackBars.errorSnackBar(
                      //         title:
                      //             "Password and Confirm password doesn't match"));
                    }
                  }
                  setState(() {});
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
