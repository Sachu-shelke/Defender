import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:defenders/config/routes/router_import.gr.dart';
import 'package:defenders/config/theme/app_colors.dart';
import 'package:defenders/config/theme/app_text_style.dart';
import 'package:defenders/constants/app_const_text.dart';
import 'package:defenders/constants/app_sizes.dart';
import 'package:defenders/modules/auth/forget_password/forget_password.dart';
import 'package:defenders/modules/auth/login/login_presenter.dart';
import 'package:defenders/modules/auth/login/login_screen_model.dart';
import 'package:defenders/modules/auth/login/login_view.dart';
import 'package:defenders/utils/validator.dart';
import 'package:defenders/widget/button/primary_button.dart';
import 'package:defenders/widget/logo.dart';
import 'package:defenders/widget/textfields/default_text_field.dart';
import 'package:defenders/widget/textfields/password_text_field.dart';

@RoutePage()
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> implements LoginView {
  late TextEditingController _passwordController;
  late TextEditingController _usernameController;
  final GlobalKey<FormState> _formKey = GlobalKey();
  late LoginScreenModel model;
  LoginPresenter presenter = BasicLoginPresenter();
  // late Stream<TcSdkCallback>? _stream;
  // late String? codeVerifier;

  @override
  void initState() {
    super.initState();
    presenter.loginView = this;
    getPermission();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
    // _stream = TcSdk.streamCallbackData;
  }

  getPermission() async {
    // Map<Permission, PermissionStatus> statuses = await [
    //   Permission.photos,
    //   Permission.phone,
    //   Permission.camera,
    //   Permission.location,
    //   // Permission.sms,
    //   Permission.notification,
    // ].request();
  }

  @override
  void refreshModel(LoginScreenModel loginModel) {
    if (mounted) {
      setState(() {
        model = loginModel;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.width);
    return Scaffold(
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.only(left: 25, right: 25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Logo(),
                  const SizedBox(
                    height: AppSizes.size20,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text('Login',
                        textScaleFactor: 1.0,
                        style: AppTextStyle.semiBold20.copyWith(
                          color: AppColors.blackColor,
                        )),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  DefaultTextField(
                    controller: _usernameController,
                    labelTextStrr: AppConstString.mobileNo.tr(),
                    vaidation: Validators.validateMrId,
                  ),
                  PasswordTextField(
                    labelText: AppConstString.yourPassword.tr(),
                    _passwordController,
                  ),
                  const SizedBox(
                    height: AppSizes.size20,
                  ),
                  PrimaryButton(
                    text: AppConstString.login.tr(),
                    color: model.isButtonTap == true ? Colors.grey : null,
                    onTap: () {
                      if (model.isButtonTap == false) {
                        if (_formKey.currentState!.validate()) {
                          model.isButtonTap = true;
                          presenter.login(context: context, loginMo: {
                            "username": _usernameController.text,
                            "password": _passwordController.text,
                            "app_key": "com.mirrorinfo",
                          });
                        }
                      }

                      setState(() {});
                    },
                  ),
                  // const SizedBox(
                  //   height: AppSizes.size20,
                  // ),
                  // MaterialButton(
                  //   onPressed: () {
                  //     TcSdk.initializeSDK(
                  //         sdkOption: TcSdkOptions.OPTION_VERIFY_ALL_USERS);
                  //     TcSdk.isOAuthFlowUsable.then((isOAuthFlowUsable) {
                  //       if (isOAuthFlowUsable) {
                  //         TcSdk.setOAuthState("12345643234543");
                  //         TcSdk.setOAuthScopes(
                  //             ['profile', 'phone', 'openid', 'offline_access']);
                  //         TcSdk.generateRandomCodeVerifier.then((codeVerifier) {
                  //           TcSdk.generateCodeChallenge(codeVerifier)
                  //               .then((codeChallenge) {
                  //             if (codeChallenge != null) {
                  //               this.codeVerifier = codeVerifier;
                  //               TcSdk.setCodeChallenge(codeChallenge);
                  //               TcSdk.getAuthorizationCode;
                  //             } else {
                  //               final snackBar = const SnackBar(
                  //                   content: Text("Device not supported"));
                  //               ScaffoldMessenger.of(context)
                  //                   .showSnackBar(snackBar);
                  //               print("***Code challenge NULL***");
                  //             }
                  //           });
                  //         });
                  //       } else {
                  //         final snackBar =
                  //             const SnackBar(content: Text("Not Usable"));
                  //         ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  //         print("***Not usable***");
                  //       }
                  //     });
                  //   },
                  //   child: const Text(
                  //     "Initialize SDK & Get Authorization Code",
                  //     style: TextStyle(color: Colors.white),
                  //   ),
                  //   color: Colors.blue,
                  // ),
                  // const Divider(
                  //   color: Colors.transparent,
                  //   height: 20.0,
                  // ),
                  // StreamBuilder<TcSdkCallback>(
                  //     stream: _stream,
                  //     builder: (context, snapshot) {
                  //       if (snapshot.hasData) {
                  //         switch (snapshot.data!.result) {
                  //           case TcSdkCallbackResult.success:
                  //             return MaterialButton(
                  //                 color: Colors.green,
                  //                 child: const Text(
                  //                   "Go to OAuth Result",
                  //                   style: TextStyle(color: Colors.white),
                  //                 ),
                  //                 onPressed: () {
                  //                   Navigator.push(
                  //                       context,
                  //                       MaterialPageRoute(
                  //                         builder: (context) =>
                  //                             OAuthResultScreen(),
                  //                         settings: RouteSettings(
                  //                           arguments: AccessTokenHelper(
                  //                               snapshot.data!.tcOAuthData!,
                  //                               codeVerifier!),
                  //                         ),
                  //                       ));
                  //                 });
                  //           case TcSdkCallbackResult.failure:
                  //             return Text(
                  //                 "${snapshot.data!.error!.code} : ${snapshot.data!.error!.message}");
                  //           case TcSdkCallbackResult.verification:
                  //             return Column(
                  //               children: [
                  //                 Text("Verification Required : "
                  //                     "${snapshot.data!.error != null ? snapshot.data!.error!.code : ""}"),
                  //                 MaterialButton(
                  //                   color: Colors.green,
                  //                   onPressed: () {
                  //                     Navigator.push(
                  //                         context,
                  //                         MaterialPageRoute(
                  //                             builder: (context) =>
                  //                                 NonTcVerification()));
                  //                   },
                  //                   child: const Text(
                  //                     "Do manual verification",
                  //                     style: TextStyle(color: Colors.white),
                  //                   ),
                  //                 )
                  //               ],
                  //             );
                  //           default:
                  //             return const Text("Invalid result");
                  //         }
                  //       } else {
                  //         return const Text("");
                  //       }
                  //     }),
                  const SizedBox(
                    height: AppSizes.size20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          // Fluttertoast.showToast(msg: 'Coming Soon');
                          showDialog(
                            context: context,
                            builder: (_) => const Dialog(
                                child: ForgetPasswordScreen(
                              isActiveId: true,
                            )),
                          );
                        },
                        child: Text(
                          'Unblock Me',
                          style: AppTextStyle.regular14.copyWith(),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (_) => const Dialog(
                                child: ForgetPasswordScreen(
                              isActiveId: false,
                            )),
                          );
                        },
                        child: Text(
                          AppConstString.forgetPassword.tr(),
                          style: AppTextStyle.regular14.copyWith(),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: AppSizes.size20,
                  ),
                  const Text('------------OR --------------'),
                  const SizedBox(
                    height: AppSizes.size20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account ?",
                        textScaleFactor: 1.0,
                        style: AppTextStyle.semiBold16,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          context.router.push(const RegistrationScreenRoute());
                        },
                        child: Text(AppConstString.signup.tr(),
                            textScaleFactor: 1.0,
                            style: AppTextStyle.semiBold16
                                .copyWith(color: AppColors.secoundColors)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
// is_portfolio
