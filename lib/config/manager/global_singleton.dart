import 'dart:io';
// import 'package:contacts_service/contacts_service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:defenders/model/auth_model/login_model.dart';
import 'package:defenders/model/banner_model/banner_model.dart';

class GlobalSingleton {
  factory GlobalSingleton() {
    return _instance;
  }

  GlobalSingleton._internal();
  static final GlobalSingleton _instance = GlobalSingleton._internal();

  static String osType = Platform.isAndroid ? 'android' : 'ios';
  static late String appVersion;
  static bool businessCompanyProfile = false;
  static Map<String, dynamic>? registerUserInfo;
  static LoginModel? loginInfo;
  static Position? currentPosition;
  static bool? fromSplash;
  // static List<Contact> contact = [];
  static double walletBalance = 0;
  static double cashbackWallet = 0;
  static String isPortfolioShoe = "0";
  static double primeWallet = 0;
  static double epinWalletBalance = 0;
  static String? profilePic;
  static int? hybridPrime;
  static int? boosterPrime;
  static int? prime;
  static int? primeB;
  static double affiliateWallet = 0;
  static String rank = 'Distributor';
  static bool isProd = false;
  static String sslCheckURL = '';
  static List<BannerList>? bannerList;
}
