import 'package:flutter/animation.dart';

class MpinScreenModel {
  AnimationController? controller;
  int? currentDigit;
  int? firstDigit;
  int? secondDigit;
  int? thirdDigit;
  int? fourthDigit;
  bool didReadNotifications;
  int unReadNotificationsCount ;
   String str ;
  int pinCodeTry;
  MpinScreenModel({
    this.controller,
    this.currentDigit,
    this.firstDigit,
    this.secondDigit,
    this.fourthDigit,
    this.thirdDigit,
  required this.didReadNotifications,
  required this.unReadNotificationsCount,
  required this.str,
  required this.pinCodeTry,

  });
}
