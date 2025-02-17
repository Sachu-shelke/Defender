// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';

// // class BannerExampleState extends State<BannerExample> {
// //   BannerAd? _bannerAd;
// //   bool _isLoaded = false;

// //   // TODO: replace this test ad unit with your own ad unit.
// //   final adUnitId = Platform.isAndroid
// //     ? 'ca-app-pub-3940256099942544/6300978111'
// //     : 'ca-app-pub-3940256099942544/2934735716';

// //   /// Loads a banner ad.
// //   void loadAd() {
// //     _bannerAd = BannerAd(
// //       adUnitId: adUnitId,
// //       request: const AdRequest(),
// //       size: AdSize.banner,
// //       listener: BannerAdListener(
// //         // Called when an ad is successfully received.
// //         onAdLoaded: (ad) {
// //           debugPrint('$ad loaded.');
// //           setState(() {
// //             _isLoaded = true;
// //           });
// //         },
// //         // Called when an ad request failed.
// //         onAdFailedToLoad: (ad, err) {
// //           debugPrint('BannerAd failed to load: $error');
// //           // Dispose the ad here to free resources.
// //           ad.dispose();
// //         },
// //       ),
// //     )..load();
// //   }
// // }

// class BannerAds extends StatefulWidget {
//   const BannerAds({super.key});

//   @override
//   State<BannerAds> createState() => _BannerAdsState();
// }

// class _BannerAdsState extends State<BannerAds> {
//   BannerAd? _bannerAd;
//   bool _isLoaded = false;

//   final adUnitId = Platform.isAndroid
//       ? 'ca-app-pub-3940256099942544/6300978111'
//       : 'ca-app-pub-3940256099942544/2934735716';

//   /// Loads a banner ad.
//   void loadAd() {
//     _bannerAd = BannerAd(
//       adUnitId: adUnitId,
//       request: const AdRequest(),
//       size: AdSize.banner,
//       listener: BannerAdListener(
//         // Called when an ad is successfully received.
//         onAdLoaded: (ad) {
//           debugPrint('$ad loaded.');
//           setState(() {
//             _isLoaded = true;
//           });
//         },
//         // Called when an ad request failed.
//         onAdFailedToLoad: (ad, err) {
//           debugPrint('BannerAd failed to load: $err');
//           // Dispose the ad here to free resources.
//           ad.dispose();
//         },
//       ),
//     )..load();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return const Column();
//   }
// }

import 'package:flutter/material.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:defenders/utils/api_path.dart';

class GoogleAdsScreen extends StatefulWidget {
  const GoogleAdsScreen({super.key});

  @override
  State<GoogleAdsScreen> createState() => _GoogleAdsScreenState();
}

class _GoogleAdsScreenState extends State<GoogleAdsScreen> {
  late BannerAd _bannerAdd;
  bool _isLoaded = false;
  @override
  void initState() {
    super.initState();
    _initBannerad();
  }

  _initBannerad() {
    _bannerAdd = BannerAd(
      size: AdSize.banner,
      adUnitId: ApiPath.bannerId,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _isLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {},
        onAdOpened: (Ad ad) => print('$BannerAd onAdOpened.'),
        onAdClosed: (Ad ad) => print('$BannerAd onAdClosed.'),
      ),
      request: const AdRequest(),
    );

    _bannerAdd.load();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoaded
        ? Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            height: _bannerAdd.size.height.toDouble(),
            width: _bannerAdd.size.width.toDouble(),
            color: Colors.transparent,
            child: AdWidget(ad: _bannerAdd),
          )
        : const SizedBox();
  }
}
