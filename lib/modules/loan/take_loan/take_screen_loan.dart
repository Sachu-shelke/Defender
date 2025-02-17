import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:defenders/config/theme/app_colors.dart';
import 'package:defenders/config/theme/app_text_style.dart';
import 'package:defenders/constants/app_const_assets.dart';
import 'package:defenders/widget/appbars/custom_app_bar.dart';
import 'package:defenders/widget/button/primary_button.dart';

class TakeScreenLoan extends StatefulWidget {
  const TakeScreenLoan({super.key});

  @override
  State<TakeScreenLoan> createState() => _TakeScreenLoanState();
}

class _TakeScreenLoanState extends State<TakeScreenLoan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Loan Details'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 6,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Image.asset(AppAssets.loanCoin),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Get a loan up to Rs. 5,00,000',
              textAlign: TextAlign.center,
              style: AppTextStyle.semiBold18,
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.sucessGreen.withOpacity(0.3)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.check_circle_outline,
                    color: AppColors.sucessGreen,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'You have some pending tasks. Let’s finish the payment goals.',
                          style: AppTextStyle.semiBold14,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.speed_outlined,
                    color: AppColors.sucessGreen,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Your Rank Score',
                          style: AppTextStyle.semiBold14,
                        ),
                        Text(
                          ' Maintain a score above 720',
                          style: AppTextStyle.regular14,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Card(
                margin: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 5,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Payment goals',
                        style: AppTextStyle.semiBold18,
                      ),
                      const Text('Achieve both goals for 6 continuous months'),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
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
                            Container(
                              color: AppColors.secoundColors,
                              height: 6,
                              width: MediaQuery.of(context).size.width / 1.6,
                            ),
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
                                  '2000rs Reward Achieve',
                                  style: AppTextStyle.semiBold14,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Container(
                              color: AppColors.secoundColors,
                              height: 6,
                              width: MediaQuery.of(context).size.width / 1.5,
                            ),
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
                                  '2000rs Redeem Takes',
                                  style: AppTextStyle.semiBold14,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Container(
                              color: AppColors.secoundColors,
                              height: 6,
                              width: MediaQuery.of(context).size.width / 2,
                            ),
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
                                  'Silver Rank Achievement',
                                  style: AppTextStyle.semiBold14,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Container(
                              color: AppColors.secoundColors,
                              height: 6,
                              width: MediaQuery.of(context).size.width / 2.4,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            PrimaryButton(
                onTap: () {
                  Fluttertoast.showToast(msg: 'Coming Soon');
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //       builder: (contet) => const TakeScreenLoan()),
                  // );
                },
                borderRadius: 0,
                text: 'Take Loan'),
            const SizedBox(
              height: 10,
            ),
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
          ],
        ),
      ),
      // bottomNavigationBar: Column(
      //   mainAxisSize: MainAxisSize.min,
      //   children: [],
      // ),
    );
  }
}
