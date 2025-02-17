// ignore_for_file: deprecated_member_use, use_build_context_synchronously, empty_catches

import 'dart:io';
import 'dart:typed_data';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:defenders/config/manager/global_singleton.dart';
import 'package:defenders/config/theme/app_colors.dart';
import 'package:defenders/config/theme/app_text_style.dart';
import 'package:defenders/constants/app_const_assets.dart';
import 'package:defenders/constants/extension/date_time.dart';
import 'package:defenders/modules/documents/id_purchase/id_address_screen.dart';
import 'package:defenders/utils/progress_indicator.dart';
import 'package:defenders/widget/appbars/custom_app_bar.dart';
// import 'package:screenshot/screenshot.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:ui' as ui;

@RoutePage()
class IdCardScreen extends StatefulWidget {
  const IdCardScreen({super.key});

  @override
  State<IdCardScreen> createState() => _IdCardScreenState();
}

class _IdCardScreenState extends State<IdCardScreen> {
  // ScreenshotController screenshotController = ScreenshotController();

  GlobalKey previewContainer = GlobalKey();
  double widthRatio = 1, heightRatio = 1, pixelRatio = 50;
  Circle progress = Circle();

  Future<void> _sharePdf() async {
    progress.show(context);
    try {
      final RenderRepaintBoundary boundary = previewContainer.currentContext!
          .findRenderObject()! as RenderRepaintBoundary;
      final ui.Image image = await boundary.toImage(pixelRatio: 2);
      final ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      final Uint8List pngBytes = byteData!.buffer.asUint8List();
      // final directory = await getApplicationDocumentsDirectory();
      // final imagePath = await File('${directory.path}/image.jpeg').create();
      // await imagePath.writeAsBytes(pngBytes);

      final pdf = pw.Document();

      // Convert the image to PDF page
      final pdfImage = pw.MemoryImage(pngBytes);
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
      final file = File('${output.path}/id_Card.pdf');
      await file.writeAsBytes(await pdf.save());

      Share.shareXFiles([XFile(file.path)], text: 'Sharing PDF');

      progress.hide(context);
    } catch (e) {}
  }

  _saveNetworkImage() async {
    progress.show(context);
    try {
      final RenderRepaintBoundary boundary = previewContainer.currentContext!
          .findRenderObject()! as RenderRepaintBoundary;
      final ui.Image image = await boundary.toImage(pixelRatio: 2);
      final ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      final Uint8List pngBytes = byteData!.buffer.asUint8List();
      final pdf = pw.Document();

      // Convert the image to PDF page
      final pdfImage = pw.MemoryImage(pngBytes);
      pdf.addPage(
        pw.Page(
          build: (pw.Context context) {
            return pw.Center(
              child: pw.Image(pdfImage, fit: pw.BoxFit.cover),
            );
          },
        ),
      );
      // final directory = await getExternalStorageDirectory();
      final file = File("/storage/emulated/0/Download/id.pdf");
      await file.writeAsBytes(await pdf.save());
      Fluttertoast.showToast(msg: 'id.pdf Download');
    } catch (e) {}

    progress.hide(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: CustomAppBar(
        title: 'ID Card',
        actions: [
          IconButton(
              onPressed: () {
                _sharePdf();
              },
              icon: const Icon(Icons.share))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          child: Column(
            children: [
              RepaintBoundary(
                // controller: screenshotController,
                key: previewContainer,
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    image: DecorationImage(
                        image: AssetImage(AppAssets.idFirst), fit: BoxFit.fill),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
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
                              size: const Size.fromRadius(60),
                              child: GlobalSingleton.profilePic != null
                                  ? Image.network(
                                      'https://secure.mirror.org.in/${GlobalSingleton.profilePic}',
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.asset(
                                      AppAssets.appLogo,
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.contain,
                                    )
                              // Image.asset(
                              //   AppAssets.appLogo,
                              //   width: 50,
                              //   height: 50,
                              // ),
                              ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        '${GlobalSingleton.loginInfo!.data!.firstName} ${GlobalSingleton.loginInfo!.data!.lastName}',
                        style: AppTextStyle.semiBold16,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      customRow(
                          title: 'ID Card',
                          value: GlobalSingleton.loginInfo!.data!.mlmId
                              .toString()),
                      customRow(
                        title: 'Rank',
                        value: GlobalSingleton.rank == 'null'
                            ? 'Distributor'
                            : "${GlobalSingleton.rank} Partner",
                      ),
                      customRow(
                          title: 'DOB',
                          value: GlobalSingleton.loginInfo!.data!.dob != null
                              ? GlobalSingleton.loginInfo!.data!.dob.toString()
                              : 'DOB Not added'),
                      customRow(
                          title: 'Joing Data',
                          value: GlobalSingleton
                                      .loginInfo!.data!.registrationDate !=
                                  null
                              ? DateFormat("dd-MM-yyyy")
                                  .parse(GlobalSingleton
                                      .loginInfo!.data!.registrationDate
                                      .toString())
                                  .toString()
                                  .getSuccessDateFormat
                              : '01-01-2024'),
                      customRow(
                          title: 'Phone No',
                          value: GlobalSingleton.loginInfo!.data!.mobile
                              .toString()),
                      customRow(
                          title: 'Email',
                          value: GlobalSingleton.loginInfo!.data!.email
                              .toString()),
                      customRow(title: 'Web', value: "www.mirrorinfo.in"),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  image: DecorationImage(
                      image: AssetImage(AppAssets.idBack), fit: BoxFit.fill),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 70),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Terms & Conditions',
                      style: AppTextStyle.semiBold18,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text('1. card use for mirror Business purpose only.'),
                    const Text(
                        '2. if found lost card plz send on this address. Mirrorinfo tech pvt ltd. 314, bramha Magestic, NIBM Road, kondhwa pune Maharashtra 411048'),
                    const Text(
                        '3 .for unauthorised activity Mirrorinfo tech is not liable'),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
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
          Expanded(
            child: InkWell(
              onTap: () {
                // _saveNetworkImage();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const IdAddressScreem(),
                  ),
                );
              },
              child: Container(
                height: 50,
                color: AppColors.secoundColors,
                child: const Center(
                  child: Text(
                    'Request',
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

  Widget customRow({
    required String title,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: AppTextStyle.regular16,
          ),
          Text(
            ' : ',
            style: AppTextStyle.semiBold16,
          ),
          Expanded(
            child: Text(
              value,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style:
                  AppTextStyle.regular16.copyWith(color: AppColors.blackColor),
            ),
          ),
        ],
      ),
    );
  }
}
