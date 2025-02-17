// ignore_for_file: deprecated_member_use, empty_catches

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:defenders/config/theme/app_colors.dart';
import 'package:defenders/constants/app_const_text.dart';
import 'package:defenders/constants/common_style.dart';
import 'package:defenders/model/redeem/redeem_history_model.dart';
import 'package:defenders/utils/progress_indicator.dart';
import 'package:defenders/widget/appbars/custom_app_bar.dart';
import 'package:defenders/widget/logo.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:math' as math;

class RedeemDetailsScreen extends StatefulWidget {
  final RedeemHistorData data;
  const RedeemDetailsScreen({
    super.key,
    required this.data,
  });

  @override
  State<RedeemDetailsScreen> createState() => _RedeemDetailsScreenState();
}

class _RedeemDetailsScreenState extends State<RedeemDetailsScreen> {
  _getPercentage(String amount, String percentage) {
    double amountDouble = double.parse(amount);
    double percentageDouble = double.parse(percentage);
    double result = amountDouble * percentageDouble / 100;
    return result.toStringAsFixed(2);
  }

  _getTotalAmount(
    String amount,
  ) {
    double amountDouble = double.parse(amount);
    double result = amountDouble - double.parse(_getPercentage(amount, "10"));
    return result.toStringAsFixed(2);
  }

  double widthRatio = 1, heightRatio = 1, pixelRatio = 50;
  Circle progress = Circle();
  ScreenshotController screenshotController = ScreenshotController();

  _imageShare() async {
    try {
      pixelRatio = math.max(heightRatio, widthRatio);

      await screenshotController
          .capture(
              pixelRatio: pixelRatio, delay: const Duration(milliseconds: 10))
          .then((image) async {
        if (image != null) {
          final directory = await getApplicationDocumentsDirectory();
          final imagePath = await File('${directory.path}/image.jpeg').create();
          await imagePath.writeAsBytes(image);
          await Share.shareXFiles([XFile(imagePath.path)]);
        }
      });
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Redeem Slip"),
      body: Stack(
        children: [
          Screenshot(
            controller: screenshotController,
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(20),
                decoration: CommonStyleDecoration.serviceBoxDecoration(),
                child: Column(
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    const Logo(
                      logoSize: 100,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      "SLIP NO - ${widget.data.id}",
                      textScaleFactor: 1.0,
                      style: const TextStyle(
                          fontSize: 17, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Mirror info Tech Pvt. Ltd.",
                      textScaleFactor: 1.0,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.orange),
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    Row(
                      children: [
                        const Expanded(
                          flex: 2,
                          child: Text(
                            "Redeem Date :",
                            textScaleFactor: 1.0,
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w600),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            widget.data.redeemDate!,
                            textScaleFactor: 1.0,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                    // const Divider(),
                    // SizedBox(
                    //   height: 5,
                    // ),
                    // Row(
                    //   children: [
                    //     Expanded(
                    //       flex: 2,
                    //       child: Text(
                    //         "Time  :",
                    //         textScaleFactor: 1.0,
                    //         style: TextStyle(
                    //             fontSize: 16, fontWeight: FontWeight.w600),
                    //       ),
                    //     ),
                    //     Expanded(
                    //       flex: 1,
                    //       child: Text(
                    //         widget.data.ridCdt!.getTimeFormat,
                    //         textScaleFactor: 1.0,
                    //         style: TextStyle(
                    //             fontSize: 16p, fontWeight: FontWeight.w600),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Divider(),
                    Row(
                      children: [
                        const Expanded(
                          flex: 2,
                          child: Text(
                            "Withdraw Amount :",
                            textScaleFactor: 1.0,
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w700,
                                color: Colors.green),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            "${AppConstString.rupeesSymbol} ${widget.data.amount}",
                            textScaleFactor: 1.0,
                            style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w800,
                                color: Colors.green),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Divider(),
                    Row(
                      children: [
                        const Expanded(
                          flex: 2,
                          child: Text(
                            "TDS :",
                            textScaleFactor: 1.0,
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                                color: Colors.red),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            "- ${AppConstString.rupeesSymbol} ${_getPercentage(widget.data.amount.toString(), "5")}",
                            textScaleFactor: 1.0,
                            style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                                color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Divider(),
                    Row(
                      children: [
                        const Expanded(
                          flex: 2,
                          child: Text(
                            "Processing Fee :",
                            textScaleFactor: 1.0,
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                                color: Colors.red),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            "- ${AppConstString.rupeesSymbol} ${_getPercentage(widget.data.amount.toString(), "5")}",
                            textScaleFactor: 1.0,
                            style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                                color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Divider(),
                    Row(
                      children: [
                        const Expanded(
                          flex: 2,
                          child: Text(
                            "Net credit in Bank :",
                            textScaleFactor: 1.0,
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w600),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            "${AppConstString.rupeesSymbol} ${_getTotalAmount(widget.data.amount.toString())}",
                            textScaleFactor: 1.0,
                            style: const TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w900),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Divider(),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
              bottom: 100,
              left: 0,
              right: 0,
              child: InkWell(
                onTap: () {
                  _imageShare();
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: AppColors.secoundColors),
                  child: const Icon(
                    Icons.share,
                    color: AppColors.whiteColor,
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
