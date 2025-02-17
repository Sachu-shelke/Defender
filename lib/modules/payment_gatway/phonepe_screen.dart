import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:phonepe_payment_sdk/phonepe_payment_sdk.dart';
import 'package:crypto/crypto.dart' as cr;

class PhonePeScreen extends StatefulWidget {
  const PhonePeScreen({super.key});

  @override
  State<PhonePeScreen> createState() => _PhonePeScreenState();
}

class _PhonePeScreenState extends State<PhonePeScreen> {
  // String result = '';
  String environment = 'PRODUCTION';
  String appId = 'com.mirrorinfo';
  String merchantId = 'MIRRORINONLINE';
  bool enableLogging = true;
  String checksupm = '';
  String saltKey = '815dbae3-09ba-41da-9b83-c73968f48bc2';
  String saltIndex = '1';
  String callBackUrl = '';
  String body = '';
  Object? result;
  String endPoint = '/pg/v1/pay';

  @override
  void initState() {
    super.initState();
    getInit();
    body = getCheckSupm().toString();
  }

  getInit() {
    PhonePePaymentSdk.init(environment, appId, merchantId, enableLogging)
        .then((val) => {
              print(val.toString()),
              setState(() {
                result = 'PhonePe SDK Initialized - $val';
              })
            })
        .catchError((error) {
      print('----$error');
      // handleError(error);
      return <dynamic>{};
    });
  }

  getCheckSupm() {
    final resultData = {
      "merchantId": merchantId,
      "merchantTransactionId": "3243565434567",
      "merchantUserId": "90223250",
      "amount": 1100,
      "redirectUrl": "https://webhook.site/redirect-url",
      "redirectMode": "REDIRECT",
      "callbackUrl": "https://webhook.site/callback-url",
      "mobileNumber": "9999999999",
      "paymentInstrument": {"type": "PAY_PAGE"}
    };
    String bas = base64.encode(utf8.encode(json.encode(resultData)));

    checksupm =
        '${cr.sha256.convert(utf8.encode(bas + endPoint + saltKey)).toString()}###$saltIndex';

    setState(() {});
    return bas;
  }

  startPgTg() {
    PhonePePaymentSdk.startTransaction(body, callBackUrl, checksupm, '')
        .then((response) => {
              setState(() {
                if (response != null) {
                  String status = response['status'].toString();
                  String error = response['error'].toString();
                  if (status == 'SUCCESS') {
                    print('---->>>$response');
                    // "Flow Completed - Status: Success!";
                  } else {
                    print('------>>$response');
                    // "Flow Completed - Status: $status and Error: $error";
                  }
                } else {
                  // "Flow Incomplete";
                }
              })
            })
        .catchError((error) {
      // handleError(error)
      print(error);
      return <dynamic>{};
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          InkWell(
            onTap: () {
              startPgTg();
            },
            child: Container(
              height: 100,
              width: 100,
              color: Colors.red,
            ),
          )
        ],
      ),
    );
  }
}

// import 'dart:convert';
// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:phonepe_payment_sdk/phonepe_payment_sdk.dart';

// // void main() {
// //   runApp(const MerchantApp());
// // }

// class MerchantApp extends StatefulWidget {
//   const MerchantApp({super.key});

//   @override
//   State<MerchantApp> createState() => MerchantScreen();
// }

// class MerchantScreen extends State<MerchantApp> {
//   String body = '''
// {
//                 merchantId: phonepeConfig.merchantId,
//                 merchantTransactionId: ref_id,
//                 merchantUserId: 'MUID' + user_id,
//                 amount: amount * 100,
//                 redirectUrl: http://localhost:3001/api/phonepe/redirect-url,
//                 redirectMode: 'POST',
//                 mobileNumber: mobile,
//                 paymentInstrument: {
//                     type: 'PAY_PAGE'
//                 }
//             }''';
//   String callback = "flutterDemoApp";
//   String checksum = "d7a8e4458caa6fcd781166bbdc85fec76740c18cb9baa9a4c48cf2387d554180###1";

//   Map<String, String> headers = {};
//   List<String> environmentList = <String>['SANDBOX', 'PRODUCTION'];
//   bool enableLogs = true;
//   Object? result;
//   String environmentValue = 'SANDBOX';
//   String appId = "";
//   String merchantId = "M22CW71WXNNO4";
//   String packageName = "com.mirrorinfo.business";

//   void initPhonePeSdk() {
//     PhonePePaymentSdk.init(environmentValue, appId, merchantId, enableLogs)
//         .then((isInitialized) => {
//               setState(() {
//                 result = 'PhonePe SDK Initialized - $isInitialized';
//               })
//             })
//         .catchError((error) {
//       handleError(error);
//       return <dynamic>{};
//     });
//   }

//   void isPhonePeInstalled() {
//     PhonePePaymentSdk.isPhonePeInstalled()
//         .then((isPhonePeInstalled) => {
//               setState(() {
//                 result = 'PhonePe Installed - $isPhonePeInstalled';
//               })
//             })
//         .catchError((error) {
//       handleError(error);
//       return <dynamic>{};
//     });
//   }

//   void isGpayInstalled() {
//     PhonePePaymentSdk.isGPayAppInstalled()
//         .then((isGpayInstalled) => {
//               setState(() {
//                 result = 'GPay Installed - $isGpayInstalled';
//               })
//             })
//         .catchError((error) {
//       handleError(error);
//       return <dynamic>{};
//     });
//   }

//   void isPaytmInstalled() {
//     PhonePePaymentSdk.isPaytmAppInstalled()
//         .then((isPaytmInstalled) => {
//               setState(() {
//                 result = 'Paytm Installed - $isPaytmInstalled';
//               })
//             })
//         .catchError((error) {
//       handleError(error);
//       return <dynamic>{};
//     });
//   }

//   void getPackageSignatureForAndroid() {
//     if (Platform.isAndroid) {
//       PhonePePaymentSdk.getPackageSignatureForAndroid()
//           .then((packageSignature) => {
//                 setState(() {
//                   result = 'getPackageSignatureForAndroid - $packageSignature';
//                 })
//               })
//           .catchError((error) {
//         handleError(error);
//         return <dynamic>{};
//       });
//     }
//   }

//   void getInstalledUpiAppsForiOS() {
//     if (Platform.isIOS) {
//       PhonePePaymentSdk.getInstalledUpiAppsForiOS()
//           .then((apps) => {
//                 setState(() {
//                   result = 'getUPIAppsInstalledForIOS - $apps';

//                   // For Usage
//                   List<String> stringList = apps
//                           ?.whereType<
//                               String>() // Filters out null and non-String elements
//                           .toList() ??
//                       [];

//                   // Check if the string value 'Orange' exists in the filtered list
//                   String searchString = 'PHONEPE';
//                   bool isStringExist = stringList.contains(searchString);

//                   if (isStringExist) {
//                     print('$searchString app exist in the device.');
//                   } else {
//                     print('$searchString app does not exist in the list.');
//                   }
//                 })
//               })
//           .catchError((error) {
//         handleError(error);
//         return <dynamic>{};
//       });
//     }
//   }

//   void getInstalledApps() {
//     if (Platform.isAndroid) {
//       getInstalledUpiAppsForAndroid();
//     } else {
//       getInstalledUpiAppsForiOS();
//     }
//   }

//   void getInstalledUpiAppsForAndroid() {
//     PhonePePaymentSdk.getInstalledUpiAppsForAndroid()
//         .then((apps) => {
//               // setState(() {
//               //   if (apps != null) {
//               //     Iterable l = json.decode(apps);
//               //     List<UPIApp> upiApps = List<UPIApp>.from(
//               //         l.map((model) => UPIApp.fromJson(model)));
//               //     String appString = '';
//               //     for (var element in upiApps) {
//               //       appString +=
//               //           "${element.applicationName} ${element.version} ${element.packageName}";
//               //     }
//               //     result = 'Installed Upi Apps - $appString';
//               //   } else {
//               //     result = 'Installed Upi Apps - 0';
//               //   }
//               // })
//             })
//         .catchError((error) {
//       handleError(error);
//       return <dynamic>{};
//     });
//   }

//   void startTransaction() async {
//     try {
//       PhonePePaymentSdk.startTransaction(body, callback, checksum, packageName)
//           .then((response) => {
//                 setState(() {
//                   if (response != null) {
//                     String status = response['status'].toString();
//                     String error = response['error'].toString();
//                     if (status == 'SUCCESS') {
//                       result = "Flow Completed - Status: Success!";
//                     } else {
//                       result =
//                           "Flow Completed - Status: $status and Error: $error";
//                     }
//                   } else {
//                     result = "Flow Incomplete";
//                   }
//                 })
//               })
//           .catchError((error) {
//         handleError(error);
//         return <dynamic>{};
//       });
//     } catch (error) {
//       handleError(error);
//     }
//   }

//   void handleError(error) {
//     setState(() {
//       if (error is Exception) {
//         result = error.toString();
//       } else {
//         result = {"error": error};
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     print(base64Encode(utf8.encode('''{
//   "merchantId": "PGTESTPAYUAT",
//   "merchantTransactionId": "MT7850590068188104",
//   "merchantUserId": "MUID123",
//   "amount": 10000,
//   "redirectUrl": "https://webhook.site/redirect-url",
//   "redirectMode": "REDIRECT",
//   "callbackUrl": "https://webhook.site/callback-url",
//   "mobileNumber": "9999999999",
//   "paymentInstrument": {
//     "type": "PAY_PAGE"
//   }''')));
//     return MaterialApp(
//       home: Scaffold(
//           appBar: AppBar(
//             title: const Text('Flutter Merchant Demo App'),
//           ),
//           body: SingleChildScrollView(
//             child: Container(
//               margin: const EdgeInsets.all(7),
//               child: Column(
//                 children: <Widget>[
//                   TextField(
//                     decoration: const InputDecoration(
//                       border: OutlineInputBorder(),
//                       hintText: 'Merchant Id',
//                     ),
//                     onChanged: (text) {
//                       merchantId = text;
//                     },
//                   ),
//                   TextField(
//                     decoration: const InputDecoration(
//                       border: OutlineInputBorder(),
//                       hintText: 'App Id',
//                     ),
//                     onChanged: (text) {
//                       appId = text;
//                     },
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: <Widget>[
//                       const Text('Select the environment'),
//                       DropdownButton<String>(
//                         value: environmentValue,
//                         icon: const Icon(Icons.arrow_downward),
//                         elevation: 16,
//                         underline: Container(
//                           height: 2,
//                           color: Colors.black,
//                         ),
//                         onChanged: (String? value) {
//                           setState(() {
//                             environmentValue = value!;
//                             if (environmentValue == 'PRODUCTION') {
//                               packageName = "com.phonepe.app";
//                             } else if (environmentValue == 'SANDBOX') {
//                               packageName = "com.phonepe.simulator";
//                             }
//                           });
//                         },
//                         items: environmentList
//                             .map<DropdownMenuItem<String>>((String value) {
//                           return DropdownMenuItem<String>(
//                             value: value,
//                             child: Text(value),
//                           );
//                         }).toList(),
//                       )
//                     ],
//                   ),
//                   Visibility(
//                       maintainSize: false,
//                       maintainAnimation: false,
//                       maintainState: false,
//                       visible: Platform.isAndroid,
//                       child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: <Widget>[
//                             const SizedBox(height: 10),
//                             Text("Package Name: $packageName"),
//                           ])),
//                   const SizedBox(height: 10),
//                   Row(
//                     children: <Widget>[
//                       Checkbox(
//                           value: enableLogs,
//                           onChanged: (state) {
//                             setState(() {
//                               enableLogs = state!;
//                             });
//                           }),
//                       const Text("Enable Logs")
//                     ],
//                   ),
//                   const SizedBox(height: 10),
//                   const Text(
//                     'Warning: Init SDK is Mandatory to use all the functionalities*',
//                     style: TextStyle(color: Colors.red),
//                   ),
//                   ElevatedButton(
//                       onPressed: initPhonePeSdk, child: const Text('INIT SDK')),
//                   const SizedBox(width: 5.0),
//                   TextField(
//                     decoration: const InputDecoration(
//                       border: OutlineInputBorder(),
//                       hintText: 'body',
//                     ),
//                     onChanged: (text) {
//                       body = text;
//                     },
//                   ),
//                   const SizedBox(height: 10),
//                   TextField(
//                     decoration: const InputDecoration(
//                       border: OutlineInputBorder(),
//                       hintText: 'checksum',
//                     ),
//                     onChanged: (text) {
//                       checksum = text;
//                     },
//                   ),
//                   const SizedBox(height: 10),
//                   ElevatedButton(
//                       onPressed: startTransaction,
//                       child: const Text('Start Transaction')),
//                   Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: <Widget>[
//                         Expanded(
//                             child: ElevatedButton(
//                                 onPressed: isPhonePeInstalled,
//                                 child: const Text('PhonePe App'))),
//                         const SizedBox(width: 5.0),
//                         Expanded(
//                             child: ElevatedButton(
//                                 onPressed: isGpayInstalled,
//                                 child: const Text('Gpay App'))),
//                         const SizedBox(width: 5.0),
//                         Expanded(
//                             child: ElevatedButton(
//                                 onPressed: isPaytmInstalled,
//                                 child: const Text('Paytm App'))),
//                       ]),
//                   ElevatedButton(
//                       onPressed: getInstalledApps,
//                       child: const Text('Get UPI Apps')),
//                   const SizedBox(width: 5.0),
//                   Visibility(
//                       maintainSize: false,
//                       maintainAnimation: false,
//                       maintainState: false,
//                       visible: Platform.isAndroid,
//                       child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: <Widget>[
//                             Expanded(
//                                 child: ElevatedButton(
//                                     onPressed: getPackageSignatureForAndroid,
//                                     child:
//                                         const Text('Get Package Signature'))),
//                             const SizedBox(width: 5.0)
//                           ])),
//                   Text("Result: \n $result")
//                 ],
//               ),
//             ),
//           )),
//     );
//   }
// }
