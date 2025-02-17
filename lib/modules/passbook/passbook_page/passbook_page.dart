import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:defenders/config/theme/app_colors.dart';
import 'package:defenders/config/theme/app_text_style.dart';
import 'package:defenders/modules/income_passbook/income_passbook_screen.dart';
import 'package:defenders/modules/passbook/cashback_passbook/cashback_wallet_screen.dart';
import 'package:defenders/modules/passbook/prime_passbook/prime_passbook_screen.dart';
import 'package:defenders/modules/passbook/wallet_passbook/wallet_passbook_screen.dart';

@RoutePage()
class PassbookPage extends StatefulWidget {
  const PassbookPage({super.key});

  @override
  State<PassbookPage> createState() => _PassbookPageState();
}

class _PassbookPageState extends State<PassbookPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: AppColors.containerbg,
        appBar: AppBar(
          backgroundColor: AppColors.appColors,
          iconTheme: const IconThemeData(color: AppColors.whiteColor),
          bottom: TabBar(
            isScrollable: true,
            labelStyle: AppTextStyle.semiBold16,
            tabs: [
              Tab(
                text: 'Wallet'.toUpperCase(),
              ),
              Tab(
                text: 'Cashback'.toUpperCase(),
              ),
              Tab(
                text: 'Prime'.toUpperCase(),
              ),
              Tab(
                text: 'Reward'.toUpperCase(),
              ),
            ],
          ),
          centerTitle: true,
          title: Text(
            'Passbook',
            style:
                AppTextStyle.semiBold18.copyWith(color: AppColors.whiteColor),
          ),
        ),
        body: const TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: [
              WalletPassbookScreen(),
              CashbackPassbookScreen(),
              PrimePassbookScreen(),
              IncomePassbookScreen(
                isFromDrawer: false,
              ),
            ]),
      ),
    );
  }
}
