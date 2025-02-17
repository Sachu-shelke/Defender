// ignore_for_file: deprecated_member_use, use_build_context_synchronously, empty_catches

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:defenders/config/manager/global_singleton.dart';
import 'package:defenders/config/theme/app_colors.dart';
import 'package:defenders/constants/app_const_assets.dart';
import 'package:defenders/utils/progress_indicator.dart';
import 'package:defenders/utils/validator.dart';
import 'package:defenders/widget/appbars/custom_app_bar.dart';
import 'package:defenders/widget/textfields/default_text_field.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

class GraphicsShareScreen extends StatefulWidget {
  final String categoriesName;
  final String categoriesImage;
  final bool isImageUrlFull;
  const GraphicsShareScreen(
      {super.key,
      required this.isImageUrlFull,
      required this.categoriesImage,
      required this.categoriesName});

  @override
  State<GraphicsShareScreen> createState() => _GraphicsShareScreenState();
}

class _GraphicsShareScreenState extends State<GraphicsShareScreen> {
  // ScreenshotController screenshotController = ScreenshotController();
  final TextEditingController _usernameController =
      TextEditingController(text: 'Dear ');
  String? userName;

  GlobalKey previewContainer = GlobalKey();

  double widthRatio = 1, heightRatio = 1, pixelRatio = 50;
  Circle progress = Circle();

  // _imageShare() async {
  //   try {
  //     pixelRatio = math.max(heightRatio, widthRatio);

  //     await screenshotController
  //         .capture(
  //             pixelRatio: pixelRatio, delay: const Duration(milliseconds: 10))
  //         .then((image) async {
  //       if (image != null) {
  //         final directory = await getApplicationDocumentsDirectory();
  //         final imagePath = await File('${directory.path}/image.jpeg').create();
  //         await imagePath.writeAsBytes(image);
  //         await Share.shareFiles([imagePath.path]);
  //       }
  //     });
  //   } catch (e) {}
  // }

  Future<void> downloadAndCaptureSS() async {
    progress.show(context);
    try {
      final RenderRepaintBoundary boundary = previewContainer.currentContext!
          .findRenderObject()! as RenderRepaintBoundary;
      final ui.Image image = await boundary.toImage(pixelRatio: 2);
      final ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      final Uint8List pngBytes = byteData!.buffer.asUint8List();
      final directory = await getApplicationDocumentsDirectory();
      final imagePath = await File('${directory.path}/image.jpeg').create();
      await imagePath.writeAsBytes(pngBytes);
      await Share.shareXFiles([XFile(imagePath.path)]);
      // await ImageGallerySaver.saveImage(pngBytes);
      //        await Share.shareFiles([imagePath.path]);
      //   NetworkDio.showSuccess(
      //     title: AppConstString.success,
      //     context: context,
      //     sucessMessage: AppConstString.imageStored,
      //   );
    } catch (e) {}
    progress.hide(context);
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
      await ImageGallerySaver.saveImage(pngBytes);
      //        await Share.shareFiles([imagePath.path]);
      Fluttertoast.showToast(msg: 'Image Download');
      // await ImageGallerySaver.saveImage(pngBytes);
      //        await Share.shareFiles([imagePath.path]);
      //   NetworkDio.showSuccess(
      //     title: AppConstString.success,
      //     context: context,
      //     sucessMessage: AppConstString.imageStored,
      //   );
    } catch (e) {}
    progress.hide(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: widget.categoriesName),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 100),
          child: RepaintBoundary(
            // controller: screenshotController,
            key: previewContainer,
            child: Container(
              color: AppColors.whiteColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      CachedNetworkImage(
                        imageUrl: widget.isImageUrlFull == true
                            ? widget.categoriesImage
                            : "https://secure.mirror.org.in/${widget.categoriesImage}",
                        fit: BoxFit.fill,
                        errorWidget: (context, url, error) =>
                            const Center(child: Icon(Icons.error)),
                      ),
                      if (userName != null)
                        Positioned(
                          top: 0,
                          left: 0,
                          child: Text(
                            userName != null
                                ? ('$userName')
                                : ('Dear ${GlobalSingleton.loginInfo!.data!.firstName}'),
                            textScaleFactor: 1.0,
                            style: TextStyle(
                                background: Paint()..color = Colors.white,
                                fontSize: 20,
                                color: AppColors.blackColor),
                          ),
                        ),
                      Positioned(
                        bottom: -10,
                        left: 0,
                        right: 0,
                        child: Container(
                          // width: MediaQuery.of(context).size.width,
                          // decoration:
                          //      BoxDecoration(color: AppColors.appColors),

                          // margin: const EdgeInsets.symmetric(horizontal: 10),
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // const SizedBox(
                                  //   height: 10,
                                  // ),
                                  Text(
                                    "${GlobalSingleton.loginInfo!.data!.firstName} ${GlobalSingleton.loginInfo!.data!.lastName}",
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                  // Text(
                                  //   GlobalSingleton.loginInfo!.data!.email
                                  //       .toString(),
                                  //   style: const TextStyle(fontSize: 14),
                                  // ),
                                  Text(
                                    'M.${GlobalSingleton.loginInfo!.data!.mobile}',
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                  Text(
                                    GlobalSingleton.rank == 'null'
                                        ? 'Mirror Distributor'
                                        : "Mirror ${GlobalSingleton.rank} Partner",
                                    style: const TextStyle(fontSize: 14),
                                  ),
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
                                          color: Color.fromARGB(
                                              255, 132, 179, 202),
                                          spreadRadius: 1)
                                    ]),
                                alignment: Alignment.center,
                                child: ClipOval(
                                  child: SizedBox.fromSize(
                                    size: const Size.fromRadius(35),
                                    child: GlobalSingleton.profilePic != null
                                        ? Image.network(
                                            "https://secure.mirror.org.in/${GlobalSingleton.profilePic!}",
                                            width: 50,
                                            height: 50,
                                            fit: BoxFit.contain,
                                          )
                                        : Image.asset(
                                            AppAssets.appLogo,
                                            width: 50,
                                            height: 50,
                                            fit: BoxFit.contain,
                                          ),
                                    // Image.asset(
                                    //   AppAssets.appLogo,
                                    //   width: 50,
                                    //   height: 50,
                                    // ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 17,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () async {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) {
                    return Dialog(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              'Please Enter Name',
                              textScaleFactor: 1.0,
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            DefaultTextField(
                              controller: _usernameController,
                              labelTextStrr: "Name",
                              vaidation: ((p0) =>
                                  Validators.validateName(p0.toString())),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            InkWell(
                              onTap: () {
                                userName = _usernameController.text;
                                setState(() {});
                                Navigator.pop(context);
                              },
                              child: Container(
                                height: 50,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    color: const Color(0xff06D2FF),
                                    borderRadius: BorderRadius.circular(30)),
                                child: const Center(
                                  child: Text(
                                    'Save',
                                    textScaleFactor: 1.0,
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: AppColors.whiteColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              child: Container(
                height: 50,
                color: const Color(0xff06D2FF),
                child: const Center(
                  child: Text(
                    'Personalize',
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
                downloadAndCaptureSS();
                // _imageShare();

                // CommonMethod().getUserLog(action: 'Marketing_Grafix', id: 6);
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
