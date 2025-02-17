// ignore_for_file: deprecated_member_use, use_build_context_synchronously, empty_catches

import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:defenders/config/manager/global_singleton.dart';
import 'package:defenders/config/theme/app_colors.dart';
import 'package:defenders/config/theme/app_text_style.dart';
import 'package:defenders/constants/app_const_assets.dart';
import 'package:defenders/constants/app_const_text.dart';
import 'package:defenders/utils/progress_indicator.dart';
import 'package:defenders/widget/appbars/custom_app_bar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:screenshot/screenshot.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:math' as math;

@RoutePage()
class PrimeInvoiceScreen extends StatefulWidget {
  const PrimeInvoiceScreen({super.key});

  @override
  State<PrimeInvoiceScreen> createState() => _IdCardScreenState();
}

class _IdCardScreenState extends State<PrimeInvoiceScreen> {
  ScreenshotController screenshotController = ScreenshotController();

  double widthRatio = 1, heightRatio = 1, pixelRatio = 50;
  Circle progress = Circle();
  // Circle progress = Circle();
  String getCashbackPoint() {
    if (GlobalSingleton.prime != null && (GlobalSingleton.prime == 1)) {
      return 'Prime A';
    } else if (GlobalSingleton.primeB != null && GlobalSingleton.primeB == 1) {
      return 'Prime B';
    } else if (GlobalSingleton.boosterPrime != null &&
        GlobalSingleton.boosterPrime == 1) {
      return 'Booster Prime';
    } else if (GlobalSingleton.hybridPrime != null &&
        GlobalSingleton.hybridPrime == 1) {
      return 'Hybrid Prime';
    } else {
      return '';
    }
  }

  double primeAmount() {
    if (GlobalSingleton.prime != null && (GlobalSingleton.prime == 1)) {
      return 2000; //2360;
    } else if (GlobalSingleton.primeB != null && GlobalSingleton.primeB == 1) {
      return 2000; //2360; //2000
    } else if (GlobalSingleton.boosterPrime != null &&
        GlobalSingleton.boosterPrime == 1) {
      return 1270; //  1499;//1270
    } else if (GlobalSingleton.hybridPrime != null &&
        GlobalSingleton.hybridPrime == 1) {
      return 470; //   599; //470
    } else {
      return 0;
    }
  }

  Future<void> _sharePdf() async {
    try {
      pixelRatio = math.max(heightRatio, widthRatio);

      await screenshotController
          .capture(
              pixelRatio: pixelRatio, delay: const Duration(milliseconds: 10))
          .then((image) async {
        if (image != null) {
          // final image = img
          //     .decodeImage(File('path_to_your_image.jpg').readAsBytesSync())!;

          // Create a PDF document
          final pdf = pw.Document();

          // Convert the image to PDF page
          final pdfImage = pw.MemoryImage(image);
          pdf.addPage(
            pw.Page(
              build: (pw.Context context) {
                return pw.Center(
                  child: pw.Image(pdfImage, fit: pw.BoxFit.cover),
                );
              },
            ),
          );

          // Save the PDF to device storage
          final output = await getTemporaryDirectory();
          final file = File('${output.path}/invoice.pdf');
          await file.writeAsBytes(await pdf.save());

          // Share the PDF file
          Share.shareXFiles([XFile(file.path)], text: 'Sharing PDF');
          // final directory = await getApplicationDocumentsDirectory();
          // final imagePath = await File('${directory.path}/image.jpeg').create();
          // await imagePath.writeAsBytes(image);
          // await Share.shareFiles([imagePath.path]);
        }
      });
    } catch (e) {}
  }

  _saveNetworkImage() async {
    progress.show(context);
    try {
      pixelRatio = math.max(heightRatio, widthRatio);

      await screenshotController
          .capture(
              pixelRatio: pixelRatio, delay: const Duration(milliseconds: 10))
          .then((image) async {
        if (image != null) {
          final pdf = pw.Document();

          // Convert the image to PDF page
          final pdfImage = pw.MemoryImage(image);
          pdf.addPage(
            pw.Page(
              build: (pw.Context context) {
                return pw.Center(
                  child: pw.Image(pdfImage, fit: pw.BoxFit.cover),
                );
              },
            ),
          );
          final directory = await getExternalStorageDirectory();
          final file = File("${directory!.path}/invoice.pdf");
          await file.writeAsBytes(await pdf.save());

          // final imagePath = await File('${directory.path}/image.jpeg').create();
          // await imagePath.writeAsBytes(image);
          // await ImageGallerySaver.saveImage(Uint8List.fromList(image),
          //     quality: 60, name: DateTime.now().toLocal().toString());
          Fluttertoast.showToast(msg: 'invoice Download');
        }
      });
    } catch (e) {}
    // var response = await Dio()
    //     .get(url, options: Options(responseType: ResponseType.bytes));

    progress.hide(context);
  }

  double primeAmountGst() {
    if (GlobalSingleton.prime != null && (GlobalSingleton.prime == 1)) {
      return 360;
    } else if (GlobalSingleton.primeB != null && GlobalSingleton.primeB == 1) {
      return 360;
    } else if (GlobalSingleton.boosterPrime != null &&
        GlobalSingleton.boosterPrime == 1) {
      return 229; //  1499;//1270
    } else if (GlobalSingleton.hybridPrime != null &&
        GlobalSingleton.hybridPrime == 1) {
      return 129; //   599; //470
    } else {
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Invoice',
        actions: [
          IconButton(
              onPressed: () {
                _sharePdf();
              },
              icon: const Icon(Icons.share))
        ],
      ),
      body: Screenshot(
        controller: screenshotController,
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(AppAssets.invoiceBg), fit: BoxFit.cover),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Mirror InfoTech Pvt Ltd',
                          textScaleFactor: 1.0,
                          style: AppTextStyle.semiBold18
                              .copyWith(color: AppColors.appColors)),
                      const Text(
                        'C-1 Office no - 8, Bramha Eastate, \nIBM Road, Kondhawa Pune 411048',
                        textScaleFactor: 1.0,
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      const Text('GST No. 27AAPCM5735Q1ZI')
                    ],
                  ),
                  Container(
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
                    alignment: Alignment.topCenter,
                    child: ClipOval(
                      child: SizedBox.fromSize(
                        size: const Size.fromRadius(30),
                        child: Image.asset(
                          AppAssets.appLogo,
                          width: 50,
                          height: 50,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              const Text(
                'Bill To :',
                textScaleFactor: 1.0,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                "${GlobalSingleton.loginInfo!.data!.firstName} ${GlobalSingleton.loginInfo!.data!.lastName}",
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                "${GlobalSingleton.loginInfo!.data!.mobile}",
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: DataTable(
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.greyColor),
                    ),
                    headingRowColor: MaterialStateColor.resolveWith(
                        (states) => AppColors.appColors),
                    dataRowColor: MaterialStateColor.resolveWith(
                        (states) => const Color(0x00000000)),
                    columns: [
                      DataColumn(
                        label: Text(
                          'Qty',
                          style: AppTextStyle.semiBold16
                              .copyWith(color: AppColors.whiteColor),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Text(
                            'Description',
                            style: AppTextStyle.semiBold16
                                .copyWith(color: AppColors.whiteColor),
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Text(
                            'Amount',
                            style: AppTextStyle.semiBold16
                                .copyWith(color: AppColors.whiteColor),
                          ),
                        ),
                      ),
                    ],
                    rows: [
                      DataRow(cells: [
                        DataCell(Text(
                          '1',
                          textAlign: TextAlign.center,
                          style: AppTextStyle.semiBold16,
                        )),
                        DataCell(Center(
                          child: Text(
                            getCashbackPoint(),
                            style: AppTextStyle.semiBold16,
                          ),
                        )),
                        DataCell(Center(
                          child: Text(
                            "${AppConstString.rupeesSymbol}${primeAmount()}",
                            textAlign: TextAlign.center,
                            style: AppTextStyle.semiBold16,
                          ),
                        )),
                      ]),
                      DataRow(cells: [
                        DataCell(Text(
                          '2',
                          textAlign: TextAlign.center,
                          style: AppTextStyle.semiBold16,
                        )),
                        DataCell(Center(
                          child: Text(
                            "GST",
                            style: AppTextStyle.semiBold16,
                          ),
                        )),
                        DataCell(Center(
                          child: Text(
                            "${AppConstString.rupeesSymbol}${primeAmountGst()}",
                            textAlign: TextAlign.center,
                            style: AppTextStyle.semiBold16,
                          ),
                        )),
                      ])
                    ]),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Invoice Total:',
                    style: AppTextStyle.semiBold16
                        .copyWith(color: AppColors.blackColor),
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                  Text(
                    "${AppConstString.rupeesSymbol}${primeAmount() + primeAmountGst()}",
                    style: AppTextStyle.semiBold16
                        .copyWith(color: AppColors.appColors),
                  ),
                ],
              ),
              const SizedBox(
                height: 100,
              ),
              // Text(
              //   'Terms & Conditions',
              //   style:
              //       AppTextStyle.semiBold16.copyWith(color: AppColors.appColors),
              // ),
              // const SizedBox(
              //   height: 10,
              // ),
              // const Text(
              //     'Please make checks payable to:  Mirrorinfo Tech Pvt. Ltd'),
              // const SizedBox(
              //   height: 50,
              // ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                _saveNetworkImage();
              },
              child: Container(
                height: 50,
                color: AppColors.secoundColors,
                child: const Center(
                  child: Text(
                    'Download',
                    textScaleFactor: 1.0,
                    style: TextStyle(
                      fontSize: 18,
                      color: AppColors.whiteColor,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                // _imageShare();
                _sharePdf();
              },
              child: Container(
                height: 50,
                color: const Color(0xff06D2FF),
                child: const Center(
                  child: Text(
                    'Share',
                    textScaleFactor: 1.0,
                    style: TextStyle(
                      fontSize: 18,
                      color: AppColors.whiteColor,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
