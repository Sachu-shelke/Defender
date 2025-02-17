import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:defenders/app/mirror_hub_app.dart';
import 'package:defenders/config/manager/global_singleton.dart';
import 'package:defenders/config/manager/storage_manager.dart';
import 'package:defenders/config/routes/router_import.dart';
import 'package:defenders/config/theme/app_colors.dart';
import 'package:defenders/config/theme/app_text_style.dart';
import 'package:defenders/constants/app_const_assets.dart';
import 'package:defenders/constants/app_const_text.dart';
import 'package:defenders/constants/app_sizes.dart';
import 'package:defenders/constants/environments.dart';
import 'package:defenders/utils/api_path.dart';
import 'package:defenders/utils/network/network_dio.dart';
import 'package:defenders/widget/app_background_widget.dart';
import 'package:defenders/widget/textfields/status_bar.dart';
import 'package:permission_handler/permission_handler.dart';

import 'constants/enum.dart';
// import 'package:flutter_overlay_window/flutter_overlay_window.dart';

final appRouter = AppRouter();

Future<void> main() async {
  // Ensure the environment is configured
  final environment = MirrorHubEnvironment(
      EnvironmentType.development); // or production as needed.
  await mainMirrorHub(environment);
}

Future<void> requestPermissions() async {
  await [
    Permission.camera,
    Permission.microphone,
    Permission.storage,
    Permission.location,
    Permission.contacts,
    Permission.phone,
  ].request();
}

Future<void> mainMirrorHub(MirrorHubEnvironment environment) async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  await StorageManager.initializeSharedPreferences();
  await EasyLocalization.ensureInitialized();

  EasyLocalization.logger.enableBuildModes = [];

  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  GlobalSingleton.appVersion =
      environment.setupEnvironmentVariables().appVersion;
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: AppColors.appColors,
      statusBarIconBrightness: Brightness.light,
    ),
  );
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  GlobalSingleton.isProd = environment.setupEnvironmentVariables().isProd;
  ApiPath.setupAppBaseUrls(environment.setupEnvironmentVariables());

  await NetworkDio.setDynamicHeader(
    authorizationToken:
        environment.setupEnvironmentVariables().authorizationToken,
  );

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('hi', 'IN'),
        Locale('mr', 'IN'),
        Locale('ta', 'IN'),
        Locale('te', 'IN'),
        Locale('gu', 'IN'),
      ],
      path: 'assets/translations',
      fallbackLocale: const Locale('en', 'US'),
      child: const MirrorHubApp(),
    ),
  );
}

@pragma("vm:entry-point")
void overlayMain() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TrueCallerOverlay(),
    ),
  );
}

class MyHttpOverrides extends HttpOverrides {
  final MirrorHubEnvironment environment;
  MyHttpOverrides({required this.environment});
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..getUrl(Uri.parse(environment.setupEnvironmentVariables().baseUrl))
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class TrueCallerOverlay extends StatefulWidget {
  const TrueCallerOverlay({super.key});

  @override
  State<TrueCallerOverlay> createState() => _TrueCallerOverlayState();
}

class _TrueCallerOverlayState extends State<TrueCallerOverlay> {
  bool isGold = true;

  @override
  void initState() {
    super.initState();
    // FlutterOverlayWindow.overlayListener.listen((event) {
    //   log("$event");
    //   setState(() {
    //     isGold = !isGold;
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appColors,
        leading: IconButton(
            onPressed: () async {
              // await FlutterOverlayWindow.closeOverlay();
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            AppBackGroundWidget(
              padding: EdgeInsets.zero,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 30),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          image: const DecorationImage(
                              image: AssetImage(AppAssets.mirrorBg)),
                          border: Border.all(
                            color: AppColors.secoundColors,
                          ),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 2,
                                offset: const Offset(1, 1),
                                color: const Color.fromRGBO(255, 174, 16, 1)
                                    .withOpacity(0.9),
                                spreadRadius: 1)
                          ],
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 40,
                            ),
                            Text(
                              'Congratulation...',
                              style: AppTextStyle.semiBold26
                                  .copyWith(color: AppColors.secoundColors),
                            ),
                            const SizedBox(
                              height: AppSizes.size10,
                            ),
                            Container(
                              // decoration: const BoxDecoration(
                              //   image: DecorationImage(
                              //       image: AssetImage(AppAssets.scratchCard)),
                              // ),
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Center(
                                child: Text(
                                  'Rs.${100}',
                                  style: AppTextStyle.bold26
                                      .copyWith(color: AppColors.blackColor),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: AppSizes.size6,
                            ),
                            Text(
                              'Received From Maruti Vairagal',
                              textAlign: TextAlign.center,
                              style: AppTextStyle.semiBold18,
                            ),
                            const SizedBox(
                              height: AppSizes.size10,
                            ),
                            Text(
                              'Level 1',
                              textAlign: TextAlign.center,
                              style: AppTextStyle.bold16
                                  .copyWith(color: AppColors.textGreyColor),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  'OP : 100',
                                  textAlign: TextAlign.center,
                                  style: AppTextStyle.bold16
                                      .copyWith(color: AppColors.textGreyColor),
                                ),
                                Text(
                                  'OP : 100',
                                  textAlign: TextAlign.center,
                                  style: AppTextStyle.bold16
                                      .copyWith(color: AppColors.textGreyColor),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: AppSizes.size16,
                            ),
                            InkWell(
                              onTap: () async {
                                // await FlutterOverlayWindow.closeOverlay();
                              },
                              child: Container(
                                width: 200,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: AppColors.secoundColors),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                child: Center(
                                  child: Text(
                                    'View Details',
                                    style: AppTextStyle.semiBold16.copyWith(
                                      color: AppColors.whiteColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: AppSizes.size10,
                            ),
                            Text(
                              AppConstString.rechargeSuccessTitle,
                              textAlign: TextAlign.center,
                              style: AppTextStyle.semiBold14,
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        left: 0,
                        right: 0,
                        top: -75,
                        child: Container(
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
                              child: Image.asset(
                                AppAssets.appLogo,
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Positioned(
                      //     bottom: -20,
                      //     right: MediaQuery.of(context).size.width / 4,
                      //     child: InkWell(
                      //       onTap: () async {
                      //         await FlutterOverlayWindow.closeOverlay();
                      //       },
                      //       child: Container(
                      //         width: 200,
                      //         decoration: BoxDecoration(
                      //             borderRadius: BorderRadius.circular(10),
                      //             color: AppColors.successColor),
                      //         padding: const EdgeInsets.symmetric(
                      //             vertical: 10, horizontal: 20),
                      //         child: Center(
                      //           child: Text(
                      //             'View Details',
                      //             style: AppTextStyle.black16.copyWith(
                      //               color: AppColors.whiteColor,
                      //             ),
                      //           ),
                      //         ),
                      //       ),
                      //     ))
                    ],
                  ),
                ],
              ),
            ),
            // Positioned(
            //   top: 50,
            //   right: 15,
            //   child: InkWell(
            //     onTap: () async {
            //       try {
            //         await FlutterOverlayWindow.closeOverlay();
            //       } catch (e) {
            //         if (kDebugMode) {
            //           print(e.toString());
            //         }
            //       }
            //     },
            //     child: Material(
            //       elevation: 10,
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(999.0),
            //       ),
            //       child: Container(
            //         height: 50,
            //         width: 50,
            //         decoration: const BoxDecoration(
            //             shape: BoxShape.circle, color: AppColors.appColors),
            //         child: const Center(
            //           child: Icon(
            //             Icons.close,
            //             color: Colors.white,
            //           ),
            //         ),
            //       ),
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
