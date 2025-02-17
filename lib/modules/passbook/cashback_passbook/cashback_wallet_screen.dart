import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:defenders/config/manager/global_singleton.dart';
import 'package:defenders/config/theme/app_colors.dart';
import 'package:defenders/config/theme/app_text_style.dart';
import 'package:defenders/constants/app_const_assets.dart';
import 'package:defenders/constants/app_const_text.dart';
import 'package:defenders/constants/app_sizes.dart';
import 'package:defenders/constants/common_style.dart';
import 'package:defenders/constants/extension/date_time.dart';
import 'package:defenders/modules/passbook/cashback_passbook/cashback_passbook_model.dart';
import 'package:defenders/modules/passbook/cashback_passbook/cashback_passbook_presenter.dart';
import 'package:defenders/modules/passbook/cashback_passbook/cashback_passbook_view.dart';

@RoutePage()
class CashbackPassbookScreen extends StatefulWidget {
  const CashbackPassbookScreen({super.key});

  @override
  State<CashbackPassbookScreen> createState() => _CashbackPassbookScreenState();
}

class _CashbackPassbookScreenState extends State<CashbackPassbookScreen>
    implements CashbackPassbokkView {
  late CashbackPassbookModel model;

  CashbackPassbookPresenter presenter = BasicCashbackPassbookPresenter();
  final ScrollController _scrollController = ScrollController();
  int page = 1;

  @override
  void refreshModel(CashbackPassbookModel mainHomeModel) {
    model = mainHomeModel;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    presenter.updateView = this;
    _scrollController.addListener(_scrollListener);
    presenter.getPassbook(
        context: context,
        userID: GlobalSingleton.loginInfo!.data!.id.toString(),
        page: page);
  }

  _scrollListener() {
    if ((_scrollController.position.maxScrollExtent / 2) ==
        ((_scrollController.position.pixels / 2))) {
      // if (model.lastPageIndex > page) {
      setState(() {
        page++;
      });
      presenter.getPassbook(
          page: page,
          // context: context,
          userID: GlobalSingleton.loginInfo!.data!.id.toString());
      // }
    }
  }

  Future<void> _refreshIndicator() async {
    presenter.getPassbook(
        context: context,
        page: page,
        userID: GlobalSingleton.loginInfo!.data!.id.toString());
  }

  String getRechargeAmount(
      {required String mainAmount, required String cashbackAMount}) {
    final amt = ((double.parse(mainAmount.toString()) -
            double.parse(cashbackAMount.toString()))
        .toStringAsFixed(2));

    return amt.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (model.walletData != null && model.walletData!.isNotEmpty)
          Align(
            alignment: Alignment.bottomCenter,
            child: Text(
              model.walletData!.length > 8
                  ? model.lastPageIndex >= page
                      ? 'Data is loading...'
                      : 'Data is Finish'
                  : "",
              style: AppTextStyle.semiBold16,
            ),
          ),
        if (model.walletData != null && model.walletData!.isNotEmpty)
          RefreshIndicator(
            onRefresh: _refreshIndicator,
            child: ListView.builder(
                itemCount: model.walletData!.length,
                controller: _scrollController,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.all(6.0),
                    margin:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: CommonStyleDecoration.serviceBoxDecoration(),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Order No #${model.walletData![index].referenceNo}',
                                style: AppTextStyle.semiBold14,
                              ),
                              Text(
                                DateFormat("dd-MM-yyyy hh:mm")
                                    .parse(model.walletData![index].createdOn!)
                                    .toString()
                                    .getDateTime,
                                style: AppTextStyle.semiBold12
                                    .copyWith(color: AppColors.greyColor),
                              )
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
                          children: [
                            Image.asset(
                              AppAssets.appLogo,
                              height: 40,
                              width: 40,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          '${model.walletData![index].subType} Cashback',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: AppTextStyle.semiBold18,
                                        ),
                                      ),
                                      Text(
                                        '${AppConstString.rupeesSymbol}${model.walletData![index].type == "Credit" ? model.walletData![index].credit : model.walletData![index].debit}',
                                        style: AppTextStyle.semiBold18.copyWith(
                                            fontWeight: FontWeight.w400,
                                            color: model.walletData![index].type
                                                        .toString() ==
                                                    "Credit"
                                                ? AppColors.successColor
                                                : AppColors.errorColor),
                                      ),
                                    ],
                                  ),
                                  if (model.walletData![index].subType
                                          .toString() ==
                                      'Prime Purchase') ...[
                                    const SizedBox(
                                      height: 6,
                                    ),
                                    Text(
                                      'Cashback Point: ${AppConstString.rupeesSymbol}${model.walletData![index].cashbackPoint}',
                                      style: AppTextStyle.regular16.copyWith(
                                        color: AppColors.blackColor,
                                      ),
                                    ),
                                    Text(
                                      'Bonus Point: ${AppConstString.rupeesSymbol}${model.walletData![index].bonusPoint}',
                                      style: AppTextStyle.regular16.copyWith(
                                        color: AppColors.blackColor,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 6,
                                    ),
                                  ],
                                  if (model.walletData![index].tranFor
                                          .toString() ==
                                      'Receive Money') ...[
                                    const SizedBox(
                                      height: 6,
                                    ),
                                    Text(
                                      'Receive Money From ${model.walletData![index].fromUserFirstName} | ${model.walletData![index].fromUserMobile}',
                                      style: AppTextStyle.regular16.copyWith(
                                        color: AppColors.blackColor,
                                      ),
                                    ),
                                  ],
                                  // const SizedBox(
                                  //   height: 6,
                                  // ),
                                  if (model.walletData![index].tranFor
                                          .toString() ==
                                      'Recharge') ...[
                                    // const SizedBox(
                                    //   height: 6,
                                    // ),
                                    // Text(
                                    //   'Number: ${model.walletData![index].consumerNumber} | ${model.walletData![index].operator} |',
                                    //   style: AppTextStyle.regular16.copyWith(
                                    //     color: AppColors.greyColor,
                                    //   ),
                                    // ),
                                    Text(
                                      'Recharge Amount: ${model.walletData![index].mainAmount}',
                                      style: AppTextStyle.regular16.copyWith(
                                        color: AppColors.blackColor,
                                      ),
                                    ),
                                    // if (model.walletData![index].traxId != null)
                                    //   Text(
                                    //     'Trax Id: ${model.walletData![index].traxId}',
                                    //     style: AppTextStyle.regular16.copyWith(
                                    //       color: AppColors.greyColor,
                                    //     ),
                                    //   ),
                                  ],
                                  Row(
                                    children: [
                                      Text(
                                        model.walletData![index].type
                                            .toString(),
                                        style: AppTextStyle.semiBold16.copyWith(
                                            fontWeight: FontWeight.w400,
                                            color: model.walletData![index].type
                                                        .toString() ==
                                                    "Credit"
                                                ? AppColors.successColor
                                                : AppColors.errorColor),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Text(
                                          'OB : ${AppConstString.rupeesSymbol}${model.walletData![index].openingBalance}',
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style:
                                              AppTextStyle.semiBold14.copyWith(
                                            color: AppColors.greyColor,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          'CB : ${AppConstString.rupeesSymbol}${model.walletData![index].closingBalance}',
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style:
                                              AppTextStyle.semiBold14.copyWith(
                                            color: AppColors.greyColor,
                                          ),
                                        ),
                                      ),
                                      // Text(
                                      //   'OB ${model.walletData[index].openingBalance} CB ${model.walletData[index].closingBalance}',
                                      //   style: AppTextStyle.semiBold14.copyWith(
                                      //     color: AppColors.greyColor,
                                      //   ),
                                      // ),
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  );
                }),
          ),
        if (model.walletData != null && model.walletData!.isEmpty)
          Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Image.asset(AppAssets.noDataFound),
            ),
            const SizedBox(
              height: AppSizes.size20,
            ),
            Text(
              'No Transcation Found',
              style: AppTextStyle.semiBold18,
            )
          ])
      ],
    );
  }
}
