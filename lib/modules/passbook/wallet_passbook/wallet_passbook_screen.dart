import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:defenders/config/manager/global_singleton.dart';
import 'package:defenders/config/theme/app_text_style.dart';
import 'package:defenders/constants/app_const_assets.dart';
import 'package:defenders/constants/app_sizes.dart';
import 'package:defenders/modules/passbook/passbook_widget/passbook_common_widget.dart';
import 'package:defenders/modules/passbook/wallet_passbook/wallet_passbook_model.dart';
import 'package:defenders/modules/passbook/wallet_passbook/wallet_passbook_presenter.dart';
import 'package:defenders/modules/passbook/wallet_passbook/wallet_passbook_view.dart';
import 'package:defenders/utils/google_ads.dart';

@RoutePage()
class WalletPassbookScreen extends StatefulWidget {
  const WalletPassbookScreen({
    super.key,
  });

  @override
  State<WalletPassbookScreen> createState() => _WalletPassbookScreenState();
}

class _WalletPassbookScreenState extends State<WalletPassbookScreen>
    implements WalletPassbokkView {
  late WalletPassbookModel model;

  WalletPassbookPresenter presenter = BasicWalletPassbookPresenter();
  final ScrollController _scrollController = ScrollController();
  int page = 1;

  @override
  void refreshModel(WalletPassbookModel mainHomeModel) {
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
        page: page,
        userID: GlobalSingleton.loginInfo!.data!.id.toString());

    getAdsData();
  }

  bool? isShowAds;
  getAdsData() async {
    // isShowAds = await CommonMethod().userAds(action: 'Wallet_passbook_Screen');
    setState(() {});
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
    // print(model.lastPageIndex > page);
    // print(2 >= 2);
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
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: PopupMenuButton(
                icon: Image.asset(
                  AppAssets.setting,
                  height: 20,
                  width: 20,
                ),
                onSelected: (value) {
                  if (value.toString() == "All") {
                    presenter.getPassbook(
                        context: context,
                        page: 1,
                        userID: GlobalSingleton.loginInfo!.data!.id.toString());
                  } else {
                    presenter.getPassbook(
                        context: context,
                        filter: value.toString(),
                        page: 1,
                        userID: GlobalSingleton.loginInfo!.data!.id.toString());
                  }
                },
                itemBuilder: (BuildContext context) {
                  return const [
                    PopupMenuItem(
                      value: 'All',
                      child: Text("All"),
                    ),
                    PopupMenuItem(
                      value: 'Mobile',
                      child: Text("Recharge"),
                    ),
                    PopupMenuItem(
                      value: 'DTH',
                      child: Text("DTH"),
                    ),
                    PopupMenuItem(
                      value: 'Bbps',
                      child: Text("Bbps"),
                    ),
                    PopupMenuItem(
                      value: 'Add money',
                      child: Text("Add money"),
                    ),
                    PopupMenuItem(
                      value: 'Send money',
                      child: Text("Send money"),
                    ),
                    PopupMenuItem(
                      value: 'Recived Money',
                      child: Text("Recived Money"),
                    ),
                  ];
                },
              ),
            ),
            if (model.walletData != null && model.walletData!.isNotEmpty)
              Expanded(
                child: RefreshIndicator(
                  onRefresh: _refreshIndicator,
                  child: ListView.separated(
                      itemCount: model.walletData!.length,
                      controller: _scrollController,
                      separatorBuilder: (context, index) {
                        if ((index + 1) % 3 == 0 && (index < 10)) {
                          return (isShowAds == true)
                              ? const GoogleAdsScreen()
                              : const SizedBox();
                        } else {
                          return const SizedBox();
                        }
                      },
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            PassbookCommonWidget(
                              walletData: model.walletData![index],
                            ),
                          ],
                        );
                      }),
                ),
              ),
          ],
        ),
        if (model.walletData != null && model.walletData!.isEmpty)
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
            ],
          ),
      ],
    );
  }
}
