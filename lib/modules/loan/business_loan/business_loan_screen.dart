import 'package:flutter/material.dart';
import 'package:defenders/config/theme/app_colors.dart';
import 'package:defenders/config/theme/app_text_style.dart';
import 'package:defenders/constants/app_const_assets.dart';
import 'package:defenders/modules/loan/take_loan/take_screen_loan.dart';
import 'package:defenders/widget/appbars/custom_app_bar.dart';
import 'package:defenders/widget/button/primary_button.dart';

class BusinessLoanScreen extends StatefulWidget {
  const BusinessLoanScreen({super.key});

  @override
  State<BusinessLoanScreen> createState() => _BusinessLoanScreenState();
}

class _BusinessLoanScreenState extends State<BusinessLoanScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Business Loan'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 6,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Image.asset(AppAssets.loanCoin),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Introducing Mirror Loans for your business!',
                textAlign: TextAlign.center,
                style: AppTextStyle.semiBold18,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'How to become eligible for loans',
                textAlign: TextAlign.center,
                style: AppTextStyle.regular16,
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.sucessGreen.withOpacity(0.3)),
                      child: const Icon(
                        Icons.check_circle_outline,
                        color: AppColors.sucessGreen,
                      )),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Task completion'),
                        Text(
                          'Completing all the pending tasks helps you to become eligible',
                          style: AppTextStyle.semiBold14,
                        )
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.sucessGreen.withOpacity(0.3)),
                      child: const Icon(
                        Icons.alarm,
                        color: AppColors.sucessGreen,
                      )),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Mandatory goals'),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const Icon(Icons.info_outline),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            '1 month continuity',
                            style: AppTextStyle.semiBold14,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Row(
                        children: [
                          const Icon(Icons.info_outline),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            '2000rs Reward Achieve',
                            style: AppTextStyle.semiBold14,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Row(
                        children: [
                          const Icon(Icons.info_outline),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            '2000rs Redeem Takes',
                            style: AppTextStyle.semiBold14,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Row(
                        children: [
                          const Icon(Icons.info_outline),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Silver Rank Achievement',
                            style: AppTextStyle.semiBold14,
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Divider(
            thickness: 2,
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Note:',
                  style: AppTextStyle.semiBold16
                      .copyWith(color: AppColors.secoundColors),
                ),
                const SizedBox(
                  width: 6,
                ),
                const Expanded(
                  child: Text(
                      'The final decision to approve a loan is a at the discretion of the lending partner.'),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          PrimaryButton(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (contet) => const TakeScreenLoan()),
                );
              },
              borderRadius: 0,
              text: 'PROCEED')
        ],
      ),
    );
  }
}
