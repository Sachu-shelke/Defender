import 'package:flutter/material.dart';
import 'package:defenders/config/routes/router_import.gr.dart';
import 'package:defenders/config/theme/app_colors.dart';
import 'package:defenders/main.dart';

class CashbackDailog extends StatelessWidget {
  const CashbackDailog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.secoundColors,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
          side: const BorderSide(color: Colors.orange, width: 2)),
      child: Container(
        margin: const EdgeInsets.all(10),
        //decoration: CommonStyleDecoration.boxDecoration(),
        //     BoxDecoration(
        //   borderRadius: BorderRadius.circular(30.w),
        //   color: containerbg,
        // ),
        child: ListView(
          shrinkWrap: true,
          children: [
            // Lottie.asset(
            //   'assets/animation/cashback_animation.json',
            //   fit: BoxFit.cover,
            // ),
            const SizedBox(
              height: 4,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                'Congratulations!!!',
                textScaleFactor: 1.0,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.yellow[700],
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            Text(
              'You have got 50 cashback points',
              textScaleFactor: 1.0,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.yellow[700],
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 30),
            InkWell(
              onTap: () {
                appRouter.push(
                  const TermAndConditionScreenRoute(),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(14),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: AppColors.appColors,
                    borderRadius: BorderRadius.circular(20)),
                alignment: Alignment.center,
                child: const Text(
                  'OK',
                  textScaleFactor: 1.0,
                  style: TextStyle(
                      color: AppColors.whiteColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
