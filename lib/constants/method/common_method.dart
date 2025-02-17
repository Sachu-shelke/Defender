// ignore_for_file: deprecated_member_use, no_leading_underscores_for_local_identifiers

import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as dev;
import 'package:encrypt/encrypt.dart' as encrypters;
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:defenders/config/manager/global_singleton.dart';
import 'package:defenders/config/routes/router_import.gr.dart';
import 'package:defenders/config/theme/app_colors.dart';
import 'package:defenders/config/theme/app_text_style.dart';
import 'package:defenders/constants/app_const_assets.dart';
import 'package:defenders/constants/app_const_text.dart';
import 'package:defenders/main.dart';
import 'package:defenders/utils/api_path.dart';
import 'package:defenders/utils/encrypted_api_path.dart';
import 'package:defenders/utils/network/network_dio.dart';
import 'package:defenders/widget/button/primary_button.dart';
import 'package:defenders/widget/textfields/default_text_field.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:translator/translator.dart';
import 'package:url_launcher/url_launcher.dart';

class CommonMethod {
  static CarouselOptions carouselOptions(
      {bool? enableInfiniteScroll,
      bool? autoPlay,
      double? aspectRatio,
      double? viewportFraction,
      double size = 160,
      Function(int, CarouselPageChangedReason)? onChanged}) {
    return CarouselOptions(
      height: size,
      aspectRatio: aspectRatio ?? (16 / 9),
      viewportFraction: viewportFraction ?? 1,
      initialPage: 0,
      enableInfiniteScroll: enableInfiniteScroll ?? true,
      reverse: false,
      autoPlay: autoPlay ?? true,
      autoPlayInterval: const Duration(seconds: 4),
      autoPlayAnimationDuration: const Duration(seconds: 2),
      autoPlayCurve: Curves.fastOutSlowIn,
      enlargeCenterPage: true,
      scrollDirection: Axis.horizontal,
      onPageChanged: onChanged ?? (t, reason) {},
    );
  }

  static Widget customExpansionTile({
    required String title1,
    required List<Widget> children,
  }) {
    return Theme(
      data: ThemeData(useMaterial3: true, dividerColor: Colors.transparent),
      child: ExpansionTile(
        tilePadding: EdgeInsets.zero,
        childrenPadding: EdgeInsets.zero,
        title: Text(
          title1,
          style: const TextStyle(color: Colors.black),
        ),
        children: children,
      ),
    );
  }

  static referLink(
      {required String referCode, String? msg, required String name}) {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: ApiPath.dynamicLink,
      link: Uri.https('invite friend', 'refer', {"refercode": referCode}),
      androidParameters: androidParameters(),
      iosParameters: iosParameters(),
    );
    _shareInviteLink(parameters, msg, referCode, name);
  }

  static _shareInviteLink(DynamicLinkParameters parameters, String? msg,
      String username, String name) async {
    // final _homeController = Get.find<HomeController>();

    Uri url;
    final ShortDynamicLink shortLink =
        await FirebaseDynamicLinks.instance.buildShortLink(parameters);
    url = shortLink.shortUrl;
    final String _linkMessage = url.toString();
    final String _message = msg != null
        ? """Dear Mirror Partner,

I hope this message finds you well! I'm excited to invite you to a special Zoom meeting hosted by Mirrorinfo Tech Pvt Ltd. This is a fantastic opportunity to connect, collaborate, and learn about the innovative Mirror projects we're working on.

Join us to explore new horizons, share insights, and get inspired by the possibilities that lie ahead. Your presence and participation will make a big difference, and we can't wait to have you with us.

*Meeting Details:*
Date: $msg,
Meeting Link: $_linkMessage

Let’s make this meeting a memorable and productive one. Together, we can achieve great things!

Looking forward to seeing you there!

Best regards,
${GlobalSingleton.loginInfo!.data!.firstName} ${GlobalSingleton.loginInfo!.data!.lastName}
Mirrorinfo Tech Pvt Ltd
www.mirrorinfo.in
www.mirrorhub.in"""
        : """ Hi, I just invited you to use the ${AppConstString.appName} app!

Step1: Use my link to download the app
Step2: Register using your mobile number and purchase Prime Membership
Step3: Start making 24x7 instant recharges, bill payments, shopping, merchant payments, etc., and earn Assured Cashback on every transaction

Mirror is 100% safe and secure.
Download the app now. $_linkMessage

Name - ${GlobalSingleton.loginInfo!.data!.firstName} ${GlobalSingleton.loginInfo!.data!.lastName}
Number - ${GlobalSingleton.loginInfo!.data!.mobile}
""";

    final bytes = await rootBundle.load(AppAssets.appLogo);
    final list = bytes.buffer.asUint8List();

    final tempDir = await getTemporaryDirectory();
    final file = await File('${tempDir.path}/invite_earn3.png').create();
    file.writeAsBytesSync(list);

    await Share.shareXFiles([XFile(file.path)], text: _message);
  }

  static AndroidParameters androidParameters() {
    return const AndroidParameters(
      packageName: 'com.mirrorinfo.business',
    );
  }

  static IOSParameters iosParameters() {
    return const IOSParameters(
      bundleId: 'com.mirrorinfo.business',
      appStoreId: '1596096696',
    );
  }

  static Future<void> whatsapp({required String mobileNumber}) async {
    String phoneNumber = '+91$mobileNumber';
    var whatsappUrl = "whatsapp://send?phone=$phoneNumber";

    bool isLaunch = await launch(whatsappUrl);
    if (!isLaunch) {
      Fluttertoast.showToast(msg: "You don't have whatsapp");
    }
  }

  static Future<void> call({required String number}) async {
    await launch("tel://$number");
  }

  static String encryptText(
      {required String secondKey, required Map<String, dynamic> data}) {
    // final _homeController = Get.find<HomeController>();
    const String key1 = "toekn";
    final String key2 = secondKey;
    late String plainText;
    plainText = "$key1||$key2||";
    data.forEach((key, value) {
      plainText = "${plainText + value}||";
    });

    dev.log("\n\nPlan Text : $plainText\n\n");

    final key = encrypters.Key.fromUtf8(AppConstString.secretKey);
    final encrypter = encrypters.Encrypter(
      encrypters.AES(key, mode: encrypters.AESMode.ecb),
    );
    final iv = encrypters.IV.fromLength(16);
    final ecnryptText = encrypter.encrypt(plainText, iv: iv);
    return ecnryptText.base64;
  }

  String initials({String? firstName, String? lastName}) {
    return ((firstName != null ? firstName[0] : "") +
            (lastName != null ? lastName[0] : ""))
        .toUpperCase();
  }

  // static String encrypt({required String text}) {
  //   final key = encrypters.Key.fromUtf8(AppConstString.secretKey);
  //   final encrypter = encrypters.Encrypter(
  //     encrypters.AES(key, mode: encrypters.AESMode.ecb),
  //   );
  //   final iv = encrypters.IV.fromLength(16);
  //   final ecnryptText = encrypter.encrypt(text, iv: iv);
  //   return ecnryptText.base64;
  // }

  // static String decryptMethod({required String text}) {
  //   final key = encrypters.Key.fromUtf8(AppConstString.secretKey);
  //   final encrypter = encrypters.Encrypter(
  //     encrypters.AES(key, mode: encrypters.AESMode.ecb),
  //   );
  //   final iv = encrypters.IV.fromLength(16);

  //   final ecnryptText = encrypter
  //       .decrypt(encrypters.Key.fromBase64('yE9tgqNxWcYDTSPNM+EGQw=='), iv: iv);
  //   return ecnryptText;
  // }

  // static String asciiToHex(String asciiStr) {
  //   List<int> chars = asciiStr.codeUnits;
  //   StringBuffer hex = StringBuffer();
  //   for (int ch in chars) {
  //     hex.write(ch.toRadixString(16).padLeft(2, '0'));
  //   }
  //   return hex.toString();
  // }

  // static String encryptURL({required String urlName}) {
  //   dev.log("URL NAME : $urlName");
  //   return asciiToHex(encrypt(text: urlName));
  // }

  Future<void> getUserLog({
    required String action,
    required int id,
  }) async {
    Map<String, dynamic>? response = await NetworkDio.getDioHttpMethod(
      url:
          '${ApiPath.apiEndPoint}${EncryptedApiPath.userLogAction}?user_id=${GlobalSingleton.loginInfo!.data!.id}&request_type=$action&task_id=$id',
    );

    if (response != null && response['status'] == 200) {}
  }

  static String reciprocalencrypt({required String text}) {
    const substitutionMap = {
      'A': 'Z',
      'B': 'Y',
      'C': 'X',
      'D': 'W',
      'E': 'V',
      'F': 'U',
      'G': 'T',
      'H': 'S',
      'I': 'R',
      'J': 'Q',
      'K': 'P',
      'L': 'O',
      'M': 'N',
      'N': 'M',
      'O': 'L',
      'P': 'K',
      'Q': 'J',
      'R': 'I',
      'S': 'H',
      'T': 'G',
      'U': 'F',
      'V': 'E',
      'W': 'D',
      'X': 'C',
      'Y': 'B',
      'Z': 'A',
      'a': 'z',
      'b': 'y',
      'c': 'x',
      'd': 'w',
      'e': 'v',
      'f': 'u',
      'g': 't',
      'h': 's',
      'i': 'r',
      'j': 'q',
      'k': 'p',
      'l': 'o',
      'm': 'n',
      'n': 'm',
      'o': 'l',
      'p': 'k',
      'q': 'j',
      'r': 'i',
      's': 'h',
      't': 'g',
      'u': 'f',
      'v': 'e',
      'w': 'd',
      'x': 'c',
      'y': 'b',
      'z': 'a',
      '1': '9',
      '2': '8',
      '3': '7',
      '4': '6',
      '5': '5',
      '6': '4',
      '7': '3',
      '8': '2',
      '9': '1',
      '0': '0'
    };
    // String plaintext = 'Hello 123';
    String encrypted = '';
    for (int i = 0; i < text.length; i++) {
      String plaintextChar = text.split('').toList()[i];
      String keyChar = substitutionMap[plaintextChar] ?? plaintextChar;
      encrypted += keyChar;
    }
    return encrypted;
    // print(base64.encode(utf8.encode(encrypted)));

    // print(utf8.decode(base64.decode('U3Zvb2wgOTg3')));
  }

  int selectedLang = 0;

  List lanList = [
    {
      'name': 'English',
    },
    {
      'name': 'Hindi',
    },
    {
      'name': 'Gujrati',
    },
    {
      'name': 'Marathi',
    },
  ];

  Future<String> getTrans({
    required String text,
    required String lanCode,
  }) async {
    final translator = GoogleTranslator();
    var translation = await translator.translate(text, to: lanCode);

    return translation.text;
  }

  dialogData({
    required BuildContext context,
    required String title,
    required String errorMessage,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return StatefulBuilder(builder: (context, setstate) {
          return Dialog(
            insetPadding: const EdgeInsets.symmetric(horizontal: 15),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: AppTextStyle.semiBold20.copyWith(
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: const BoxDecoration(color: Color(0xffF1F1F1)),
                    child: SingleChildScrollView(
                      child: Row(
                        children: List.generate(
                            4,
                            (index) => Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      child: InkWell(
                                        onTap: () {
                                          selectedLang = index;
                                          setstate(() {});
                                        },
                                        child: Column(
                                          children: [
                                            Text(
                                              lanList[index]['name'],
                                              style: AppTextStyle.semiBold14,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    if (selectedLang == index)
                                      Container(
                                        height: 2,
                                        width: 80,
                                        color: AppColors.secoundColors,
                                      )
                                  ],
                                )),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  selectedLang == 0
                      ? Text(errorMessage)
                      : FutureBuilder<String>(
                          future: getTrans(
                              text: errorMessage,
                              lanCode: selectedLang == 1
                                  ? 'hi'
                                  : selectedLang == 2
                                      ? 'gu'
                                      : 'mr'),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child: Image.asset(
                                  AppAssets.mirrorLoader,
                                  width: 100,
                                ),
                              );
                            } else {
                              return Text('${snapshot.data}');
                            }
                          },
                        ),
                  // Text(
                  //   selectedLang == 0
                  //       ? errorMessage
                  //       : getTrans(
                  //               text: errorMessage,
                  //               lanCode: selectedLang == 1
                  //                   ? 'hi'
                  //                   : selectedLang == 2
                  //                       ? 'gu'
                  //                       : 'mr')
                  //           .toString(),
                  //   // selectedLang == 0 ? "" : errorMessage,
                  //   // 'Mirror respects your privacy. Therefore we do not collect or store your contact history. this feature only helps to remind for your leads.',
                  //   textAlign: TextAlign.left,
                  //   style: AppTextStyle.regular16,
                  // ),
                  const SizedBox(
                    height: 25,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 40),
                        decoration: BoxDecoration(
                          color: AppColors.appColors,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: const Text(
                          'OK',
                          textScaleFactor: 1.0,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
      },
    );
  }
}

class CustomModalBottomSheet {
  static void show(
      {required BuildContext context, required String serviceName}) {
    String? productFile;
    int? selectedRatingStar;
    TextEditingController reviewController = TextEditingController();
    final ImagePicker picker = ImagePicker();
    bool isButtonTaped = false;
    Future<String> _onSelectImage() async {
      try {
        XFile? image = await picker.pickImage(source: ImageSource.gallery);

        if (image != null) {
          return image.path.toString();
        } else {
          return '';
        }
      } catch (e) {
        return '';
      }
    }

    Future<void> addUserRating({required BuildContext context}) async {
      Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
          url: ApiPath.apiEndPoint + ApiPath.userRating,
          isEncryptionUse: true,
          data: FormData.fromMap({
            'image': productFile,
            'user_id': GlobalSingleton.loginInfo!.data!.id.toString(),
            'service': serviceName,
            'rate': (selectedRatingStar! + 1),
            'review': reviewController.text,
            'app_id': '2'
          }),
          context: context);
      isButtonTaped = false;
      if (response != null && response['status'] == 200) {
        appRouter.pushAndPopUntil(
          MainHomeScreenRoute(),
          predicate: (route) => false,
        );
        Fluttertoast.showToast(msg: ' Rating added successfully');
        // appRouter.pushAndPopUntil(const RedeemSucessScreenRoute(),
        //     predicate: (route) => false);
      }
      // view.refreshModel(model);
    }

    showModalBottomSheet(
        context: context,
        isDismissible: false,
        isScrollControlled: true,
        backgroundColor: AppColors.backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        builder: (context) {
          return StatefulBuilder(
            builder: (context, StateSetter setState) {
              return Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                "Dear ${GlobalSingleton.loginInfo!.data!.firstName}, \nGive your rating to improve Mirror service",
                                style: AppTextStyle.semiBold16,
                              ),
                            ),
                            InkWell(
                                onTap: () {
                                  appRouter.pushAndPopUntil(
                                    MainHomeScreenRoute(),
                                    predicate: (route) => false,
                                  );
                                },
                                child: Text(
                                  'Skip',
                                  style: AppTextStyle.semiBold16,
                                ))
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                              5,
                              (index) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: InkWell(
                                      onTap: () {
                                        selectedRatingStar = index;
                                        setState(() {});
                                      },
                                      child: (selectedRatingStar != null &&
                                              selectedRatingStar! >= index)
                                          ? Image.asset(
                                              AppAssets.ratingStart,
                                              height: 30,
                                              width: 30,
                                            )
                                          : Image.asset(
                                              AppAssets.removeStar,
                                              height: 30,
                                              width: 30,
                                            ),
                                    ),
                                  )),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Enter your feedback",
                          style: AppTextStyle.semiBold16,
                        ),
                        DefaultTextField(
                          controller: reviewController,
                          maxLines: 3,
                          color: Colors.white,
                          isValidation: true,
                          vaidation: (text) {
                            if (text!.isEmpty) {
                              return null;
                            }
                            return null;
                          },
                          labelTextStrr: 'feedback',
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            MaterialButton(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 14),
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                    color: AppColors.appColors),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              onPressed: () {
                                _onSelectImage().then((value) {
                                  if (value != '') {
                                    productFile = value;
                                  }
                                  setState(() {});
                                });
                              },
                              child: const Text(
                                'Choose File',
                                textScaleFactor: 1.0,
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.appColors,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            if (productFile == null)
                              const Text(
                                'No File Selected',
                                textScaleFactor: 1.0,
                                style: TextStyle(fontWeight: FontWeight.w500),
                              )
                            else
                              Image.file(
                                File(productFile!),
                                width: 50,
                                height: 40,
                                fit: BoxFit.fill,
                              )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        PrimaryButton(
                          text: "Post",
                          color: isButtonTaped == true ? Colors.grey : null,
                          onTap: () {
                            if (isButtonTaped == false) {
                              FocusScope.of(context).unfocus();
                              if (selectedRatingStar != null) {
                                isButtonTaped = true;
                                // Navigator.pop(context);
                                addUserRating(context: context);
                              } else {
                                Fluttertoast.showToast(
                                    msg: 'Please give your rating');
                              }
                            }

                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        });
  }
}


// package com.mirrorinfo.business

// import io.flutter.embedding.android.FlutterActivity
// import io.flutter.embedding.android.FlutterActivityLaunchConfigs
// import io.flutter.embedding.android.FlutterFragmentActivity
// import io.flutter.embedding.engine.FlutterEngine
// import io.flutter.plugins.GeneratedPluginRegistrant

// class MainActivity : FlutterFragmentActivity() {
//     override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
//         GeneratedPluginRegistrant.registerWith(flutterEngine)
//     }

//     override fun getBackgroundMode(): FlutterActivityLaunchConfigs.BackgroundMode {
//         return FlutterActivityLaunchConfigs.BackgroundMode.transparent
//     }
// }