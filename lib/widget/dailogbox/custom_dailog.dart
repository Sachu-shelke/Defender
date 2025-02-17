// ignore_for_file: use_key_in_widget_constructors, unused_import

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:defenders/config/theme/app_colors.dart';
import 'package:defenders/config/theme/app_text_style.dart';
import 'package:defenders/constants/app_sizes.dart';
import 'package:permission_handler/permission_handler.dart';

class CustomDailog extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final bool isIcon;
  final bool isCloseButton;
  final Function()? onPress;
  final String buttonText;
  final double? height;
  final Function()? onCloseButton;
  final String iconType;

  const CustomDailog(
      {required this.title,
      required this.subtitle,
      this.onPress,
      required this.buttonText,
      this.isIcon = true,
      this.isCloseButton = false,
      this.height,
      this.iconType = 'pending',
      this.onCloseButton});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Stack(
        children: <Widget>[
          Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: AppColors.whiteColor,
              ),
              margin: const EdgeInsets.only(top: 13.0, right: 8.0),
              height: height,
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const SizedBox(
                          height: AppSizes.size10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              buttonText != 'Take Prime' ? title! : 'Oops!',
                              textScaleFactor: 1.0,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: .4),
                            ),
                            const SizedBox(
                              width: AppSizes.size10,
                            ),
                            // isIcon
                            //     ? Padding(
                            //         padding: const EdgeInsets.all(8.0),
                            //         child: Row(
                            //           mainAxisAlignment:
                            //               MainAxisAlignment.center,
                            //           children: [
                            //             FaIcon(
                            //               iconType == 'pending'
                            //                   ? FontAwesomeIcons.infoCircle
                            //                   : FontAwesomeIcons
                            //                       .solidCheckCircle,
                            //               size: 30.sp,
                            //               color: iconType == 'pending'
                            //                   ? Colors.yellow
                            //                   : Colors.green,
                            //             ),
                            //           ],
                            //         ),
                            //       )
                            //     : Container(),
                          ],
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                subtitle!,
                                textScaleFactor: 1.0,
                                textAlign: TextAlign.center,
                                style: const TextStyle(fontSize: 20),
                              ),
                            ),
                            const SizedBox(
                              width: 6,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: onPress,
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      width: double.infinity,
                      decoration: const BoxDecoration(
                          color: AppColors.appColors,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15),
                          )),
                      alignment: Alignment.center,
                      child: Text(
                        buttonText,
                        textScaleFactor: 1.0,
                        style: const TextStyle(
                            color: AppColors.whiteColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  )
                ],
              )),
          Positioned(
            right: 0.0,
            child: isCloseButton
                ? GestureDetector(
                    onTap: onCloseButton ??
                        () {
                          Navigator.of(context).pop();
                        },
                    child: const Align(
                      alignment: Alignment.topRight,
                      child: CircleAvatar(
                        radius: 14.0,
                        backgroundColor: AppColors.appColors,
                        child: Icon(Icons.close, color: AppColors.whiteColor),
                      ),
                    ),
                  )
                : Container(),
          )
        ],
      ),
    );
  }
}

class PermissionDialog extends StatelessWidget {
  final String errorMsg;
  const PermissionDialog({required this.errorMsg});
  @override
  Widget build(BuildContext context) {
    return Dialog(
      // insetPadding: const EdgeInsets.symmetric(horizontal: 15),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(32.0)
            // bottomLeft: Radius.circular(32),
            // bottomRight: Radius.circular(32)
            ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.white,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('assets/Untitled design (3).png'),
            const SizedBox(
              height: AppSizes.size10,
            ),
            Text(
              "Attention Please!",
              style: AppTextStyle.bold16,
            ),
            const SizedBox(
              height: AppSizes.size10,
            ),
            Text(errorMsg),
            const SizedBox(
              height: AppSizes.size10,
            ),
            Align(
              alignment: Alignment.center,
              child: InkWell(
                onTap: () async {
                  Navigator.pop(context);
                  await openAppSettings();
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  decoration: BoxDecoration(
                    color: AppColors.secoundColors,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: const Text(
                    'Give Permission',
                    textScaleFactor: 1.0,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: AppSizes.size10,
            ),
          ],
        ),
      ),
    );
  }
}
