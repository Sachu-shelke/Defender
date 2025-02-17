import 'dart:io';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:defenders/config/theme/app_text_style.dart';
import 'package:defenders/constants/app_const_assets.dart';
import 'package:defenders/constants/app_const_text.dart';
import 'package:defenders/utils/internet_error.dart';

class Circle {
  factory Circle() => _instance;
  Circle.internal();
  static final Circle _instance = Circle.internal();

  static bool entry = false;
  static OverlayEntry viewEntry = OverlayEntry(builder: (BuildContext context) {
    return const Loader();
  });

  InternetError internetError = InternetError();

  Future<void> show(BuildContext context) async {
    return addOverlayEntry(context);
  }

  void hide(BuildContext context) => removeOverlay();

  bool get isShow => isShowNetworkOrCircle();

  bool isShowNetworkOrCircle() {
    return internetError.isShow || entry == true;
  }

  Future<void> addOverlayEntry(BuildContext context) async {
    if (entry == true) {
      return;
    }
    entry = true;
    return addOverlay(viewEntry, context);
  }

  Future<void> addOverlay(OverlayEntry entry, BuildContext context) async {
    try {
      return Overlay.of(context).insert(entry);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<void> removeOverlay() async {
    try {
      entry = false;
      viewEntry.remove();
    } catch (e) {
      return Future.error(e);
    }
  }
}

class ProcessIndicator extends StatelessWidget {
  const ProcessIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Material(
      color: Colors.transparent,
      child: Center(
        child: Material(
          color: Colors.transparent,
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}

class Loader extends StatefulWidget {
  const Loader({super.key});

  @override
  State<Loader> createState() => _LoaderState();
}

class _LoaderState extends State<Loader> with TickerProviderStateMixin {
  int indexOF = 0;

  late final AnimationController _controller;

  List stringList = [
    "Fetching Details 😇",
    "Create Secure Conection 😃",
    " Fetching Details 🙂",
    "Your request is in progress 😍",
    "Plz wait. don't close app or back button 🙏",
    "Fetching Details 😇",
    "Almost Done 🤩",
    "Cheking Server 😊 Conectivitity",
    "Data Receiving 🙂",
    "Fetching detaits 😇",
    "Sorry Conection error. Plz try after some tine our contact our Support team ${AppConstString.supportNumber} 😔"
  ];
  Timer? timer;
  @override
  void initState() {
    super.initState();
    startTimer();
    _controller = AnimationController(vsync: this);
  }

  startTimer() {
    timer = Timer.periodic(const Duration(seconds: 2), (Timer timer) {
      indexOF++;
      if (indexOF > 9) {
        indexOF = 0;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    timer!.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid
        ? WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: Container(
              color: Colors.black.withOpacity(0.5),
              constraints: BoxConstraints.expand(
                  height: MediaQuery.of(context).size.height),
              child: Center(
                child: Material(
                  elevation: 10,
                  color: Colors.transparent,
                  child: Container(
                    // height: 70,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          AppAssets.mirrorLoader,
                          width: 100,
                        ),
                        // Lottie.asset(
                        //   'assets/animation/loader.json',
                        //   controller: _controller,
                        //   width: 100,
                        //   onLoaded: (composition) {
                        //     _controller
                        //       ..duration = composition.duration
                        //       ..forward();
                        //   },
                        // ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Text(stringList[indexOF].toString(),
                              style: AppTextStyle.semiBold14),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        : const CupertinoActivityIndicator(
            radius: 16,
          );
  }
}
