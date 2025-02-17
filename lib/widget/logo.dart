import 'package:flutter/material.dart';
import 'package:defenders/config/theme/app_colors.dart';
import 'package:defenders/constants/app_const_assets.dart';

class Logo extends StatelessWidget {
  final double logoSize;
  final bool isCenter;
  final String? imageUrl;
  final double? hight;
  const Logo(
      {super.key,
      this.imageUrl,
      this.hight,
      this.logoSize = 200,
      this.isCenter = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: AppColors.appColors,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
                offset: Offset(6, 6),
                blurRadius: 15.0,
                color: Color.fromARGB(255, 132, 179, 202),
                spreadRadius: 1)
          ]),
      alignment: isCenter ? Alignment.center : Alignment.topCenter,
      child: ClipOval(
        child: SizedBox.fromSize(
          size: Size.fromRadius(hight ?? 60),
          child: imageUrl != null
              ? Image.network(
                  "https://secure.mirror.org.in/${imageUrl!}",
                  width: logoSize,
                  height: logoSize,
                  fit: BoxFit.contain,
                )
              : Image.asset(
                  AppAssets.appLogo,
                  width: logoSize,
                  height: logoSize,
                  fit: BoxFit.contain,
                ),
        ),
      ),
    );
  }
}
