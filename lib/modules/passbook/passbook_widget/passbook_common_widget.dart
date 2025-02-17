import 'package:flutter/material.dart';
import 'package:defenders/model/passbook_model/wallet_passbook_model.dart';
import 'package:intl/intl.dart';
import 'package:defenders/config/theme/app_colors.dart';
import 'package:defenders/config/theme/app_text_style.dart';
import 'package:defenders/constants/app_const_assets.dart';
import 'package:defenders/constants/app_const_text.dart';
import 'package:defenders/constants/common_style.dart';
import 'package:defenders/constants/extension/date_time.dart';
import 'package:defenders/utils/api_path.dart';

class PassbookCommonWidget extends StatefulWidget {
  final WalletPassbookDataModelData walletData;
  final bool? isEpinWallet;
  const PassbookCommonWidget(
      {super.key, this.isEpinWallet, required this.walletData});

  @override
  State<PassbookCommonWidget> createState() => _PassbookCommonWidgetState();
}

class _PassbookCommonWidgetState extends State<PassbookCommonWidget> {
  String getRechargeAmount(
      {required String mainAmount, required String cashbackAMount}) {
    final amt = ((double.parse(mainAmount.toString()) -
            double.parse(cashbackAMount.toString()))
        .toStringAsFixed(2));

    return amt.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6.0),
      margin: widget.isEpinWallet == true
          ? EdgeInsets.zero
          : const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: CommonStyleDecoration.serviceBoxDecoration(),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Order No #${widget.isEpinWallet == true ? widget.walletData.transactionId : widget.walletData.referenceNo}',
                  style: AppTextStyle.semiBold14,
                ),
                Text(
                  widget.isEpinWallet == true
                      ? widget.walletData.createdOn!
                      : DateFormat("dd-MM-yyyy hh:mm")
                          .parse(widget.walletData.createdOn!)
                          .toString()
                          .getDateTime,
                  style: AppTextStyle.semiBold12
                      .copyWith(color: AppColors.greyColor),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Divider(
              color: AppColors.greyColor,
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              widget.walletData.operatorImage != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(999),
                      child: Image.network(
                        ApiPath.bucketUrl + widget.walletData.operatorImage!,
                        height: 40,
                        width: 40,
                      ),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(999),
                      child: Image.asset(
                        AppAssets.appLogo,
                        height: 40,
                        width: 40,
                      ),
                    ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                (widget.walletData.rechargeType.toString() ==
                                            'DTH'
                                        ? "DTH "
                                        : "") +
                                    widget.walletData.tranFor.toString() +
                                    (widget.walletData.planName != null
                                        ? (' ${widget.walletData.planName}')
                                        : ''),
                                style: AppTextStyle.semiBold18,
                              ),
                              if (widget.walletData.tranFor.toString() ==
                                  'Recharge') ...[
                                Text(
                                  'Number: ${widget.walletData.consumerNumber} | ${widget.walletData.operator} |',
                                  style: AppTextStyle.regular16.copyWith(
                                    color: AppColors.blackColor,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Amount: ${widget.walletData.mainAmount}',
                                      style: AppTextStyle.regular16.copyWith(
                                        color: AppColors.blackColor,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    if (widget.walletData.rechargeStatus !=
                                        null)
                                      Text(
                                        widget.walletData.rechargeStatus
                                            .toString(),
                                        style: AppTextStyle.semiBold14.copyWith(
                                            fontWeight: FontWeight.w400,
                                            color: widget.walletData
                                                        .rechargeStatus
                                                        .toString() ==
                                                    "SUCCESS"
                                                ? AppColors.successColor
                                                : widget.walletData
                                                            .rechargeStatus
                                                            .toString() ==
                                                        "PROCESS"
                                                    ? Colors.orange.shade600
                                                    : AppColors.errorColor),
                                      ),
                                  ],
                                ),
                                if (widget.walletData.traxId != null)
                                  Text(
                                    'Trax Id: ${widget.walletData.traxId}',
                                    style: AppTextStyle.regular16.copyWith(
                                      color: AppColors.blackColor,
                                    ),
                                  ),
                              ],
                              if (widget.walletData.subType.toString() ==
                                  'Send Money') ...[
                                // const SizedBox(
                                //   height: 6,
                                // ),
                                Text(
                                  'Send Money To ${widget.walletData.toUserFirstName} ${widget.walletData.toUserLastName} | ${widget.walletData.toUserMobile}',
                                  style: AppTextStyle.regular16.copyWith(
                                    color: AppColors.blackColor,
                                  ),
                                ),
                              ],
                              if (widget.walletData.subType.toString() ==
                                  'Receive Money') ...[
                                // const SizedBox(
                                //   height: 6,
                                // ),
                                Text(
                                  'Receive Money From ${widget.walletData.fromUserFirstName} | ${widget.walletData.fromUserMobile}',
                                  style: AppTextStyle.regular16.copyWith(
                                    color: AppColors.blackColor,
                                  ),
                                ),
                              ],
                              if (widget.walletData.tranFor.toString() ==
                                  'Add Money') ...[
                                Text(
                                  '${widget.walletData.subType}',
                                  style: AppTextStyle.regular16.copyWith(
                                    color: AppColors.blackColor,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Column(
                          children: [
                            Text(
                              '${AppConstString.rupeesSymbol}${widget.walletData.type == "Credit" ? widget.walletData.credit : widget.walletData.debit}',
                              style: AppTextStyle.semiBold18.copyWith(
                                  fontWeight: FontWeight.w400,
                                  color: widget.walletData.type.toString() ==
                                          "Credit"
                                      ? AppColors.successColor
                                      : AppColors.errorColor),
                            ),
                          ],
                        ),
                      ],
                    ),
                    // const SizedBox(
                    //   height: 4,
                    // ),
                    Row(
                      children: [
                        Text(
                          widget.walletData.type.toString(),
                          style: AppTextStyle.semiBold16.copyWith(
                              fontWeight: FontWeight.w400,
                              color:
                                  widget.walletData.type.toString() == "Credit"
                                      ? AppColors.successColor
                                      : AppColors.errorColor),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Text(
                            'OB : ${AppConstString.rupeesSymbol}${widget.walletData.openingBalance}',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: AppTextStyle.semiBold14.copyWith(
                              color: AppColors.greyColor,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'CB : ${AppConstString.rupeesSymbol}${widget.walletData.closingBalance}',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: AppTextStyle.semiBold14.copyWith(
                              color: AppColors.greyColor,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
                width: 10,
              ),
            ],
          )
        ],
      ),
    );
  }
}
