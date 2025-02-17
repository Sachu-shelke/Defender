import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:defenders/config/manager/global_singleton.dart';
import 'package:defenders/config/theme/app_colors.dart';
import 'package:defenders/config/theme/app_text_style.dart';
import 'package:defenders/constants/app_const_text.dart';
import 'package:defenders/constants/extension/date_time.dart';
import 'package:defenders/modules/passbook/passbook_widget/passbook_common_widget.dart';
import 'package:defenders/modules/redeem/redeem_model.dart';
import 'package:defenders/modules/redeem/redeem_presenter.dart';
import 'package:defenders/modules/redeem/redeem_view.dart';
import 'package:defenders/widget/appbars/custom_app_bar.dart';
import 'package:defenders/widget/snackbar/snackbars.dart';
import 'package:defenders/widget/textfields/amount_text_field.dart';
import 'package:defenders/widget/textfields/default_text_field.dart';
import 'package:defenders/widget/textfields/mobile_text_field.dart';

@RoutePage()
class RedeemScreen extends StatefulWidget {
  final bool isFromEwallet;
  const RedeemScreen({super.key, required this.isFromEwallet});

  @override
  State<RedeemScreen> createState() => _RedeemScreenState();
}

class _RedeemScreenState extends State<RedeemScreen>
    implements RedeemScreenView {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  RedeemPresenter presenter = BasicRedeemPresenter();
  late RedeemModel model;

  @override
  void initState() {
    super.initState();
    presenter.updateView = this;
    presenter.getTeamDetails(
      userId: GlobalSingleton.loginInfo!.data!.id.toString(),
      context: context,
    );
    presenter.redeemHistory(
      isFromEwallet: widget.isFromEwallet,
      userId: GlobalSingleton.loginInfo!.data!.id.toString(),
      // context: context,
    );
  }

  @override
  void refreshModel(RedeemModel redeemModel) {
    model = redeemModel;
    if (mounted) {
      setState(() {});
    }
  }

  String getRedeemAmount({
    required String totalEarningIncome,
    required String totalRedeemIncome,
  }) {
    double earningIncome = double.parse(totalEarningIncome);
    double redeemIncome = double.parse(totalRedeemIncome);
    return (earningIncome - redeemIncome).toStringAsFixed(2).toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          title: widget.isFromEwallet == true ? 'E-pin' : 'Redeem'),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          const SizedBox(
            height: 6,
          ),
          Text(
            widget.isFromEwallet == true
                ? "My E-pin point"
                : 'My Redeem Points',
            style: AppTextStyle.semiBold18,
          ),
          const SizedBox(
            height: 6,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.isFromEwallet == true
                    ? GlobalSingleton.epinWalletBalance.toString()
                    : model.teamDetailsData.totalEarning != null
                        ? getRedeemAmount(
                            totalEarningIncome:
                                model.teamDetailsData.totalEarning.toString(),
                            totalRedeemIncome: model
                                .teamDetailsData.totalWithdrawal
                                .toString())
                        : "----",
                style: AppTextStyle.semiBold24
                    .copyWith(color: AppColors.secoundColors),
              ),
              if (widget.isFromEwallet == true)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        dialogData();
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5),
                        decoration: BoxDecoration(
                            color: AppColors.appColors,
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(
                          'Id Activation',
                          style: AppTextStyle.semiBold14
                              .copyWith(color: AppColors.whiteColor),
                        ),
                      ),
                    ),
                    // const SizedBox(
                    //   height: 10,
                    // ),
                    // InkWell(
                    //   onTap: () {
                    //     appRouter.pushNamed('/send_money_screen/true');
                    //   },
                    //   child: Container(
                    //     padding: const EdgeInsets.symmetric(
                    //         horizontal: 20, vertical: 5),
                    //     decoration: BoxDecoration(
                    //         color: AppColors.secoundColors,
                    //         borderRadius: BorderRadius.circular(10)),
                    //     child: Text(
                    //       'Send Money',
                    //       style: AppTextStyle.semiBold14
                    //           .copyWith(color: AppColors.whiteColor),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              if (widget.isFromEwallet == false)
                InkWell(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(32.0),
                              ),
                            ),
                            insetPadding: const EdgeInsets.all(10),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(22),
                                      // decoration: BoxDecoration(
                                      //   color: const Color(0xffEBF4FB),
                                      //   shape: BoxShape.circle,
                                      //   border: Border.all(
                                      //       color: AppColors.greyColor),
                                      // ),
                                      decoration: BoxDecoration(
                                        color: const Color(0xffEBF4FB),
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: AppColors.greyColor
                                              .withOpacity(0.5),
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                              blurRadius: 2,
                                              offset: const Offset(1, 1),
                                              color: AppColors.greyColor
                                                  .withOpacity(0.5),
                                              spreadRadius: 1)
                                        ],
                                      ),
                                      child: Center(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              'My Redeem\nPoints',
                                              textAlign: TextAlign.center,
                                              style: AppTextStyle.semiBold14,
                                            ),
                                            Text(
                                              model.teamDetailsData
                                                          .totalEarning !=
                                                      null
                                                  ? getRedeemAmount(
                                                      totalEarningIncome: model
                                                          .teamDetailsData
                                                          .totalEarning
                                                          .toString(),
                                                      totalRedeemIncome: model
                                                          .teamDetailsData
                                                          .totalWithdrawal
                                                          .toString())
                                                  : "----",
                                              style: AppTextStyle.semiBold14
                                                  .copyWith(
                                                      color: AppColors
                                                          .secoundColors),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: AmountTextField(
                                        controller: _amountController,
                                        onChanged: (val) {
                                          model.isButtonTap = false;
                                        },
                                      ),
                                    ),
                                    const SizedBox(height: 10.0),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: DefaultTextField(
                                          controller: _noteController,
                                          color: AppColors.whiteColor,
                                          labelTextStrr: "Note"),
                                    ),
                                    const SizedBox(height: 16.0),
                                    InkWell(
                                      onTap: () {
                                        FocusScope.of(context).unfocus();
                                        if (_formKey.currentState!.validate()) {
                                          if (model.isButtonTap == false) {
                                            model.isButtonTap = true;
                                            // Navigator.pop(context);
                                            if (double.parse(getRedeemAmount(
                                                    totalEarningIncome: model
                                                        .teamDetailsData
                                                        .totalEarning
                                                        .toString(),
                                                    totalRedeemIncome: model
                                                        .teamDetailsData
                                                        .totalWithdrawal
                                                        .toString())) >=
                                                double.parse(
                                                    _amountController.text)) {
                                              presenter.redeem(
                                                  context: context,
                                                  note: _noteController.text,
                                                  userId: GlobalSingleton
                                                      .loginInfo!.data!.id
                                                      .toString(),
                                                  amount:
                                                      _amountController.text);
                                            } else {
                                              model.isButtonTap = false;
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                      SnackBars.errorSnackBar(
                                                          title:
                                                              "you don't have sufficient balance in your wallet"));
                                            }
                                          }
                                        }
                                        setState(() {});
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 40, vertical: 5),
                                        decoration: BoxDecoration(
                                            color: AppColors.appColors,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Text(
                                          'Redeem Now',
                                          style: AppTextStyle.semiBold14
                                              .copyWith(
                                                  color: AppColors.whiteColor),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 16.0),
                                  ],
                                ),
                              ),
                            ),
                          );
                        });
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    decoration: BoxDecoration(
                        color: AppColors.appColors,
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(
                      'Redeem Now',
                      style: AppTextStyle.semiBold14
                          .copyWith(color: AppColors.whiteColor),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const Divider(),
          const SizedBox(
            height: 10,
          ),
          Text(
            widget.isFromEwallet == true ? "E-pin History" : "Redeem History",
            textScaleFactor: 1.0,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          if (model.historyData.isNotEmpty &&
              widget.isFromEwallet == false) ...[
            ListView.separated(
                separatorBuilder: (context, index) {
                  if ((index + 1) % 6 == 0) {
                    return const SizedBox();
                  } else {
                    // ignore: prefer_const_constructors
                    return SizedBox(
                      height: 5,
                    );
                  }
                },
                shrinkWrap: true,
                reverse: true,
                itemCount: model.historyData.length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: const Color(0xffEBF4FB),
                        border: Border.all(
                          color: AppColors.greyColor.withOpacity(0.5),
                        ),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 2,
                              offset: const Offset(1, 1),
                              color: AppColors.greyColor.withOpacity(0.5),
                              spreadRadius: 1)
                        ],
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (model.historyData[index].redeemDate != null)
                            Text(
                              'Date ${model.historyData[index].redeemDate!}',
                            ),
                          Text(
                            'Redeem Amount ${AppConstString.rupeesSymbol} ${model.historyData[index].amount!}',
                            style: AppTextStyle.semiBold16,
                          ),
                          Row(
                            children: [
                              Text(
                                'Status :',
                                style: AppTextStyle.semiBold16,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                model.historyData[index].status == 1
                                    ? 'Success'
                                    : model.historyData[index].status == 2
                                        ? 'Failed'
                                        : model.historyData[index].status == 0
                                            ? 'Inprocess'
                                            : '',
                                style: AppTextStyle.semiBold16.copyWith(
                                    color: model.historyData[index].status == 1
                                        ? AppColors.successColor
                                        : model.historyData[index].status == 2
                                            ? AppColors.errorColor
                                            : AppColors.secoundColors),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Text(model.historyData[index].status == 1
                              ? 'Your Amount is credited Successfully'
                              : model.historyData[index].status == 0
                                  ? 'It Will be credited in next 24 hours till ${DateFormat('dd-MM-yyyy HH:mm').parse(model.historyData[index].redeemDate!).add(const Duration(days: 1)).toString().getDateTimeNew}'
                                  : ''),
                          const SizedBox(
                            height: 6,
                          ),
                        ],
                      ));
                }),
          ],
          if (model.epinHisoryModel.isNotEmpty &&
              widget.isFromEwallet == true) ...[
            ListView.separated(
                separatorBuilder: (context, index) {
                  if ((index + 1) % 6 == 0) {
                    return const SizedBox();
                  } else {
                    // ignore: prefer_const_constructors
                    return SizedBox(
                      height: 5,
                    );
                  }
                },
                shrinkWrap: true,
                reverse: true,
                itemCount: model.epinHisoryModel.length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return PassbookCommonWidget(
                    isEpinWallet: true,
                    walletData: model.epinHisoryModel[index],
                  );
                }),
          ]
        ],
      ),
    );
  }

  dialogData() {
    return showDialog(
      context: context,
      // barrierDismissible: false,
      builder: (crn) {
        return Dialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(32.0),
            ),
          ),
          child: Form(
            // key: _formKey,
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
                  const Text(
                      'Enter Mr Id and Mobile number for the acrtive Id'),
                  const SizedBox(
                    height: 10,
                  ),
                  MobileTextField(
                    _phoneController,
                  ),

                  const SizedBox(
                    height: 10,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("OR"),
                    ],
                  ),
                  DefaultTextField(
                    controller: _usernameController,
                    labelTextStrr: 'Enter MRID',
                    // vaidation: Validators.validateMrId,
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  const SizedBox(
                    height: 10,
                  ),
                  // if (model.userDetails.firstName != null)
                  //   Align(
                  //     alignment: Alignment.centerLeft,
                  //     child: Padding(
                  //       padding: const EdgeInsets.only(
                  //           left: 10, right: 10, top: 6, bottom: 10),
                  //       child: Text(
                  //         "Active Id :- ${model.userDetails.firstName} ${model.userDetails.lastName}",
                  //         style: AppTextStyle.semiBold16,
                  //       ),
                  //     ),
                  //   ),
                  const SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: InkWell(
                      onTap: () {
                        FocusScope.of(context).unfocus();

                        if (_phoneController.text.isNotEmpty ||
                            _usernameController.text.isNotEmpty) {
                          Navigator.pop(context);
                          // if (model.userDetails.firstName == null) {
                          Future.delayed(
                            const Duration(seconds: 0),
                            () {
                              presenter.sendMoneyUserDetails(
                                  //mr35477
                                  context: context,
                                  mobileNumber: _phoneController.text.isNotEmpty
                                      ? _phoneController.text
                                      : _usernameController.text);
                            },
                          );
                          // } else {
                          // context.router.push(PrimeDashboardScreenRoute(
                          //     isFromEpin: true,
                          //     userId: model.userDetails.id.toString()));
                          // }
                        }
                        setState(() {});
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 40),
                        decoration: BoxDecoration(
                          color: AppColors.appColors,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Text(
                          (model.userDetails.firstName == null)
                              ? "Verify"
                              : 'Submit',
                          textScaleFactor: 1.0,
                          style: const TextStyle(
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
          ),
        );
      },
    );
  }
}
