import 'package:flutter/material.dart';
import 'package:defenders/config/theme/app_colors.dart';

class UserCountContainer extends StatelessWidget {
  final String text;
  final Color color;
  final Gradient usercountgradient;
  final String image;
  final bool isSelectedTab;
  final void Function()? onTap;
  const UserCountContainer(
      {super.key,
      required this.text,
      required this.color,
      required this.isSelectedTab,
      required this.usercountgradient,
      required this.onTap,
      required this.image});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 150,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color: isSelectedTab == true
                  ? AppColors.sucessGreen
                  : AppColors.borderGreyColor,
              width: 2),
          // border: Border.all(color: AppColors.borderGreyColor),
          color: AppColors.whiteColor,
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0.0, 1.0),
              blurRadius: 1.0,
            ),
          ],
        ),
        // decoration: BoxDecoration(
        //     border: Border.all(
        //         color: isSelectedTab == true
        //             ? AppColors.sucessGreen
        //             : Colors.transparent,
        //         width: 2),
        //     gradient: usercountgradient,
        //     // color: color,
        //     borderRadius: BorderRadius.circular(10)

        // ),
        child: Center(
          child: Column(
            children: [
              Image.asset(
                'assets/images/royaltyicon/$image',
                height: 65,
              ),
              const SizedBox(
                height: 6,
              ),
              Text(
                text,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
