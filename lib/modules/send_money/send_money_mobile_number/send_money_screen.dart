// ignore_for_file: use_build_context_synchronously

import 'package:auto_route/auto_route.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:defenders/config/manager/global_singleton.dart';
import 'package:defenders/config/routes/router_import.gr.dart';
import 'package:defenders/config/theme/app_colors.dart';
import 'package:defenders/config/theme/app_text_style.dart';
import 'package:defenders/constants/app_const_text.dart';
import 'package:defenders/constants/app_sizes.dart';
import 'package:defenders/constants/extension/date_time.dart';
import 'package:defenders/constants/method/common_method.dart';
import 'package:defenders/model/auth_model/login_model.dart';
import 'package:defenders/modules/home/home_screen.dart';
import 'package:defenders/modules/send_money/send_money_mobile_number/send_money_model.dart';
import 'package:defenders/modules/send_money/send_money_mobile_number/send_money_presenter.dart';
import 'package:defenders/modules/send_money/send_money_mobile_number/send_money_view.dart';
import 'package:defenders/widget/appbars/custom_app_bar.dart';
import 'package:defenders/widget/button/primary_button.dart';
import 'package:defenders/widget/dailogbox/permission_dialog.dart';
import 'package:defenders/widget/numbers_to_word.dart';
import 'package:defenders/widget/textfields/amount_text_field.dart';
import 'package:defenders/widget/textfields/default_text_field.dart';
import 'package:defenders/widget/textfields/mobile_text_field.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_flutter/qr_flutter.dart';

@RoutePage()
class SendMoneyScreen extends StatefulWidget {
  final String? mobileNumber;
  final String? isFromEpin;
  const SendMoneyScreen(
      {super.key,
      @PathParam('isFromEpin') required this.isFromEpin,
      this.mobileNumber});

  @override
  State<SendMoneyScreen> createState() => _SendMoneyScreenState();
}

class _SendMoneyScreenState extends State<SendMoneyScreen>
    implements SendMoneyView {
  SendMoneyPresenter presenter = BasicSendMoneyPresenter();
  late SendMoneyScreenModel model;
  late TextEditingController _mobileController;
  late TextEditingController _amountController;
  late TextEditingController _mesageController;
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _mobileController = TextEditingController();
    _amountController = TextEditingController();
    _mesageController = TextEditingController();
    if (widget.mobileNumber != null) {
      _mobileController.text = widget.mobileNumber!;
      presenter.sendMoneyUserDetails(
          mobileNumber: _mobileController.text.toString(), context: context);
      setState(() {});
    }

// mobileNumber
    presenter.updateView = this;
    presenter.recentSendMoney(
        userID: GlobalSingleton.loginInfo!.data!.id.toString(),
        isFromEpin: widget.isFromEpin);
    // getUserContactList();
  }

  @override
  void refreshModel(SendMoneyScreenModel sendMoneyModel) {
    model = sendMoneyModel;
    if (mounted) {
      setState(() {});
    }
  }

  // getUserContactList() async {
  //   await UserContact().getLatestContact(() {
  //     setState(() {});
  //   }, null, 0);
  //   setState(() {});
  // }

  void _handleInvalidPermissions(PermissionStatus permissionStatus) {
    if (permissionStatus == PermissionStatus.denied) {
      const snackBar = SnackBar(
          content: Text(
        'Access to contact data denied',
        textScaleFactor: 1.0,
      ));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else if (permissionStatus == PermissionStatus.permanentlyDenied) {
      showPermission(context: context, title: 'Contact');
    }
  }

  Future<PermissionStatus> _getContactPermission() async {
    PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.permanentlyDenied) {
      PermissionStatus permissionStatus = await Permission.contacts.request();
      return permissionStatus;
    } else {
      return permission;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: CustomAppBar(title: AppConstString.sendMoney.tr()),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: QrImageView(
                    data: GlobalSingleton.loginInfo!.data!.mobile.toString(),
                    version: 5,
                    size: 250,
                    gapless: false,
                    errorStateBuilder: (cxt, err) {
                      return const Center(
                        child: Text(
                          'Uh oh! Something went wrong...',
                          textAlign: TextAlign.center,
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: AppSizes.size10,
                ),
                MobileTextFieldrecharge(
                  _mobileController,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  color: AppColors.whiteColor,
                  onChanged: (p0) {
                    if (p0.length == 10) {
                      presenter.sendMoneyUserDetails(
                          mobileNumber: p0.toString(), context: context);
                    } else {
                      model.userDetails = LoginData();
                    }

                    setState(() {});
                  },
                  suffixWidget: GestureDetector(
                    onTap: () async {
                      FocusScope.of(context).unfocus();
                      PermissionStatus permissionStatus =
                          await _getContactPermission();

                      if (permissionStatus == PermissionStatus.granted) {
                        final Contact? contact =
                            await ContactsService.openDeviceContactPicker();
                        if (contact != null) {
                          _mobileController.text = contact.phones!.last.value!
                              .replaceAll(" ", "")
                              .replaceFirst("+91", "");
                        } else {
                          _handleInvalidPermissions(permissionStatus);
                        }
                      } else {
                        _handleInvalidPermissions(permissionStatus);
                      }
                      if (_mobileController.text.length == 10) {
                        presenter.sendMoneyUserDetails(
                            mobileNumber: _mobileController.text.toString(),
                            context: context);
                      } else {
                        model.userDetails = LoginData();
                      }

                      setState(() {});
                    },
                    child: const Icon(
                      Icons.contacts,
                      size: 20,
                      color: AppColors.appColors,
                    ),
                  ),
                ),
                if (model.userDetails.firstName != null)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, top: 6, bottom: 10),
                      child: Text(
                        "Send Money to  ${model.userDetails.firstName} ${model.userDetails.lastName}",
                        style: AppTextStyle.semiBold16,
                      ),
                    ),
                  ),
                const SizedBox(
                  height: AppSizes.size10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: AmountTextField(
                    controller: _amountController,
                    validator: (String? str) {
                      if (str!.isEmpty) {
                        return 'Amount field is Required';
                      } else if (str.startsWith('0')) {
                        return 'Please enter valid amount';
                      } else if (int.parse(str) < 100) {
                        return 'Minimum amount is Rs. 100';
                      } else if (int.parse(str) > 10001) {
                        return 'Max amount is 10000';
                      }
                      return null;
                    },
                    onChanged: (p0) {
                      setState(() {});
                    },
                  ),
                ),
                if (_amountController.text.isNotEmpty) ...[
                  (double.parse(_amountController.text) < 10001)
                      ? Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 5),
                          child: Text(
                            "Rupees ${NumberToWord().convert(Locale.en_ind, int.parse(_amountController.text))} Only",
                            textAlign: TextAlign.center,
                            style: AppTextStyle.regular14
                                .copyWith(color: AppColors.textGreyColor),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 5),
                          child: Text(
                            'You Can only send Rs.10 thousand at a time. Please enter a lower amount',
                            textAlign: TextAlign.center,
                            style: AppTextStyle.regular14
                                .copyWith(color: AppColors.textColorRed),
                          ),
                        ),
                ],

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: DefaultTextField(
                    controller: _mesageController,
                    // isValidation: true,
                    color: AppColors.whiteColor,
                    // vaidation: (p0) => null,
                    labelTextStrr: 'Add Message',
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: AnimatedPrimaryButton(
                    isOntapValid: true,
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        if (model.userDetails.id != null) {
                          // presenter.sendMoney(
                          //     context: context,
                          //     amount: _amountController.text,
                          //     message: _mesageController.text,
                          //     mobileNumber: _mobileController.text,
                          //     userId: model.userDetails.id.toString());
                          context.router.push(
                            OtpScreenRoute(
                              otpType: 'Send Money',
                              mobileNumber: GlobalSingleton
                                  .loginInfo!.data!.mobile
                                  .toString(),
                              sendMoneyWalletType: "Main",
                              sendMoneyAmount: _amountController.text,
                              sendMoneyMessage: _mesageController.text,
                              sendMoneyMobileNumber: _mobileController.text,
                              sendMoneyUserId: model.userDetails.id.toString(),
                              sendMoneypresenter: presenter,
                            ),
                          );
                        } else {
                          presenter.sendMoneyUserDetails(
                              mobileNumber: _mobileController.text.toString(),
                              context: context);
                          CommonMethod().dialogData(
                              context: context,
                              title: 'Error',
                              errorMessage:
                                  'Enter valid mobile number OR Mobile number is not register in Mayway Bussiness ');
                          // ScaffoldMessenger.of(context).showSnackBar(
                          //     SnackBars.errorSnackBar(
                          //         title:
                          //             'Enter valid mobile number OR Mobile number is not register in Mirror Hub'));
                        }
                      }
                    },
                    text:
                        'Pay Securely ${AppConstString.rupeesSymbol + _amountController.text} ',
                  ),
                ),
                const SizedBox(
                  height: AppSizes.size10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: RechargeContainer(
                    title: AppConstString.recents.tr(),
                    margin: EdgeInsets.zero,
                    child: SizedBox(
                      height: model.recentSendMoneyList.length * 90,
                      child: ListView.builder(
                          itemCount: model.recentSendMoneyList.length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                InkWell(
                                  onTap: () {
                                    presenter.sendMoneyUserDetails(
                                        mobileNumber: model
                                            .recentSendMoneyList[index].mobile
                                            .toString(),
                                        context: context);
                                    _mobileController.text = model
                                        .recentSendMoneyList[index].mobile
                                        .toString();
                                    _amountController.text = model
                                        .recentSendMoneyList[index].amount
                                        .toString();
                                    setState(() {});
                                  },
                                  child: ListTile(
                                    leading: Container(
                                      height: 50,
                                      width: 50,
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppColors.appColors),
                                      child: CircleAvatar(
                                          child: Text(CommonMethod().initials(
                                              firstName: model
                                                  .recentSendMoneyList[index]
                                                  .firstName,
                                              lastName: model
                                                  .recentSendMoneyList[index]
                                                  .lastName))),
                                    ),
                                    title: Text(
                                      '${model.recentSendMoneyList[index].firstName} ${model.recentSendMoneyList[index].lastName}',
                                      style: AppTextStyle.regular16,
                                    ),
                                    subtitle: Text(
                                        '${AppConstString.rupeesSymbol} ${model.recentSendMoneyList[index].amount} - sent Securely'),
                                    trailing: Text(
                                        DateFormat("E, dd MMMM yyyy HH:mm:ss")
                                            .parse(model
                                                .recentSendMoneyList[index]
                                                .createdOn!)
                                            .toString()
                                            .getSuccessDateFormat),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  child: Divider(
                                    color: AppColors.darkgreyColor,
                                  ),
                                ),
                              ],
                            );
                          }),
                    ),
                  ),
                ),
                const SizedBox(
                  height: AppSizes.size10,
                ),
                // if (GlobalSingleton.contact != null)
                //   RechargeContainer(
                //     title: AppConstString.contacts.tr(),
                //     margin: EdgeInsets.zero,
                //     child: SizedBox(
                //       height: GlobalSingleton.contact!.length * 85,
                //       child: ListView.builder(
                //           itemCount: GlobalSingleton.contact!.length,
                //           physics: const NeverScrollableScrollPhysics(),
                //           itemBuilder: (context, index) {
                //             return Column(
                //               mainAxisSize: MainAxisSize.min,
                //               children: [
                //                 ListTile(
                //                   onTap: () {
                //                     presenter.sendMoneyUserDetails(
                //                         mobileNumber: GlobalSingleton
                //                             .contact![index].phones!.last.value
                //                             .toString()
                //                             .replaceAll(" ", "")
                //                             .replaceFirst("+91", ""),
                //                         context: context);
                //                   },
                //                   leading: SizedBox(
                //                     height: 50,
                //                     width: 50,
                //                     child:
                //                         (GlobalSingleton.contact![index].avatar !=
                //                                     null &&
                //                                 GlobalSingleton.contact![index]
                //                                     .avatar!.isNotEmpty)
                //                             ? CircleAvatar(
                //                                 backgroundImage: MemoryImage(
                //                                     GlobalSingleton
                //                                         .contact![index].avatar!))
                //                             :
                //                             //SizedBox(),
                //                             CircleAvatar(
                //                                 child: Text(GlobalSingleton
                //                                     .contact![index]
                //                                     .initials())),
                //                   ),
                //                   title: Text(
                //                     (GlobalSingleton
                //                                 .contact![index].displayName !=
                //                             null)
                //                         ? GlobalSingleton
                //                             .contact![index].displayName
                //                             .toString()
                //                         : "No Name",
                //                     style: AppTextStyle.regular16,
                //                   ),
                //                   subtitle:
                //                       (GlobalSingleton.contact![index].phones !=
                //                                   null &&
                //                               GlobalSingleton.contact![index]
                //                                   .phones!.isNotEmpty &&
                //                               GlobalSingleton.contact![index]
                //                                       .phones!.first.value !=
                //                                   null)
                //                           ? Text(
                //                               GlobalSingleton.contact![index]
                //                                   .phones!.last.value
                //                                   .toString(),
                //                             )
                //                           : const Text(''),
                //                 ),
                //                 const Padding(
                //                   padding: EdgeInsets.symmetric(horizontal: 20),
                //                   child: Divider(
                //                     color: AppColors.darkgreyColor,
                //                   ),
                //                 ),
                //               ],
                //             );
                //           }),
                //     ),
                //   ),
              ],
            ),
          ),
        ),
      ),
      // floatingActionButton: _mobileController.text.length == 10
      //     ? Column(
      //         mainAxisSize: MainAxisSize.min,
      //         children: [
      //           FloatingActionButton(
      //             backgroundColor: AppColors.appColors,
      //             onPressed: () {
      //               context.router.push(SendMoneyPaymentScreenRoute(
      //                   mobileNumber: _mobileController.text));
      //             },
      //             child: const Icon(
      //               Icons.add,
      //               color: AppColors.whiteColor,
      //             ),
      //           ),
      //           const SizedBox(
      //             height: AppSizes.size6,
      //           ),
      //           Text(
      //             'Send Money',
      //             style: AppTextStyle.bold16,
      //           ),
      //         ],
      //       )
      //     : null,
    );
  }

  @override
  void dispose() {
    _mobileController.dispose();
    super.dispose();
  }
}
