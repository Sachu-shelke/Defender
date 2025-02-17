// // ignore_for_file: use_build_context_synchronously

// import 'package:flutter/material.dart';
// import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
// import 'package:defenders/config/manager/global_singleton.dart';
// import 'package:defenders/config/theme/app_colors.dart';
// import 'package:defenders/config/theme/app_text_style.dart';
// import 'package:defenders/constants/app_const_assets.dart';
// import 'package:defenders/constants/method/common_method.dart';
// import 'package:defenders/modules/home/home_widget/banner_widget/banner.dart';
// import 'package:defenders/modules/today_task/today_follow_up/today_follow_up_screen.dart';
// import 'package:defenders/utils/api_path.dart';
// import 'package:defenders/utils/network/network_dio.dart';
// import 'package:defenders/utils/progress_indicator.dart';
// import 'package:defenders/widget/appbars/custom_app_bar.dart';
// // import 'package:call_log/call_log.dart';

// class TodayCallScreen extends StatefulWidget {
//   const TodayCallScreen({super.key});

//   @override
//   State<TodayCallScreen> createState() => _TodayCallScreenState();
// }

// class _TodayCallScreenState extends State<TodayCallScreen> {
//   // List<CallLogEntry>? reciveentries;
//   // List<CallLogEntry>? sendentries;
//   Circle progress = Circle();

//   int incomeCallCount = 0;
//   @override
//   void initState() {
//     super.initState();
//     Future.delayed(const Duration(seconds: 0), () {
//       dialogData();
//     });

//     _getCallLogs();
//     _getSendCall();
//   }

//   _getCallLogs() async {
//     // DateTime now = DateTime.now();
//     // DateTime startOfDay = DateTime(now.year, now.month, now.day);
//     // DateTime endOfDay = DateTime(now.year, now.month, now.day, 23, 59, 59);
//     // Iterable<CallLogEntry> entries = await CallLog.query(
//     //   dateFrom: startOfDay.millisecondsSinceEpoch,
//     //   dateTo: endOfDay.millisecondsSinceEpoch,
//     //   type: CallType.incoming,
//     // );

//     // reciveentries = entries.toList();
//     // if (reciveentries != null && reciveentries!.isNotEmpty) {
//     //   getMsgContent(context: context);
//     // }

//     // setState(() {});
//   }

//   Future<void> getMsgContent({
//     required BuildContext context,
//   }) async {
//     List callList = [];

//     for (var i = 0; i < reciveentries!.length; i++) {
//       callList.add({
//         'mobile': reciveentries![i].number,
//         'name': reciveentries![i].name,
//         'type': 'incoming',
//       });
//     }

//     Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
//         url: ApiPath.apiEndPoint + ApiPath.uploadUserContact,
//         data: {
//           'user_id': GlobalSingleton.loginInfo!.data!.id.toString(),
//           'dataList': callList
//         });
//     if (response != null && response['status'] == 200) {}
//     setState(() {});
//   }

//   _getSendCall() async {
//     DateTime now = DateTime.now();
//     DateTime startOfDay = DateTime(now.year, now.month, now.day);
//     DateTime endOfDay = DateTime(now.year, now.month, now.day, 23, 59, 59);
//     Iterable<CallLogEntry> entries = await CallLog.query(
//       dateFrom: startOfDay.millisecondsSinceEpoch,
//       dateTo: endOfDay.millisecondsSinceEpoch,
//       type: CallType.outgoing,
//     );
//     sendentries = entries.toList();

//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: const CustomAppBar(title: 'Today Call'),
//       body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//         const Banners(
//           localModel: [AppAssets.todayCallBanner],
//         ),
//         const SizedBox(
//           height: 10,
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             const SizedBox(
//               width: 10,
//             ),
//             Expanded(
//               child: Container(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10),
//                     border: Border.all(color: AppColors.greyColor)),
//                 child: Column(
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Image.asset(
//                           AppAssets.phoneCallback,
//                           height: 20,
//                           width: 20,
//                         ),
//                         const SizedBox(
//                           width: 10,
//                         ),
//                         Text(
//                           '${reciveentries != null ? reciveentries!.length : 0}',
//                           style: AppTextStyle.semiBold16,
//                         ),
//                       ],
//                     ),
//                     const Text('Today target Call'),
//                   ],
//                 ),
//               ),
//             ),
//             const SizedBox(
//               width: 10,
//             ),
//             Expanded(
//               child: InkWell(
//                 onTap: () {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) =>
//                               const TodayFollowUpScreen())).then((value) {
//                     _getSendCall();
//                   });
//                 },
//                 child: Container(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10),
//                       border: Border.all(color: AppColors.greyColor)),
//                   child: Column(
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Image.asset(
//                             AppAssets.phonecall,
//                             height: 20,
//                             width: 20,
//                           ),
//                           const SizedBox(
//                             width: 10,
//                           ),
//                           Text(
//                             '${sendentries != null ? sendentries!.length : 0}',
//                             style: AppTextStyle.semiBold16
//                                 .copyWith(color: AppColors.secoundColors),
//                           ),
//                         ],
//                       ),
//                       const Text('Today Done Call'),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(
//               width: 10,
//             ),
//           ],
//         ),
//         const SizedBox(
//           height: 20,
//         ),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 10),
//           child: Text(
//             'Today Call',
//             style: AppTextStyle.semiBold16,
//           ),
//         ),
//         const SizedBox(
//           height: 5,
//         ),
//         if (reciveentries != null)
//           Expanded(
//             child: ListView.builder(
//               itemCount: reciveentries!.length,
//               itemBuilder: (context, index) {
//                 CallLogEntry log = reciveentries![index];
//                 return Container(
//                     margin:
//                         const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 10,
//                       vertical: 8,
//                     ),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10),
//                       border: Border.all(color: AppColors.appColors),
//                     ),
//                     child: Row(
//                       children: [
//                         Container(
//                           decoration: const BoxDecoration(
//                               color: AppColors.appColors,
//                               shape: BoxShape.circle,
//                               boxShadow: [
//                                 BoxShadow(
//                                     offset: Offset(6, 6),
//                                     blurRadius: 15.0,
//                                     color: Color.fromARGB(255, 132, 179, 202),
//                                     spreadRadius: 1)
//                               ]),
//                           alignment: Alignment.topCenter,
//                           child: ClipOval(
//                             child: SizedBox.fromSize(
//                               size: const Size.fromRadius(20),
//                               child: Image.asset(
//                                 AppAssets.appLogo,
//                               ),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(
//                           width: 10,
//                         ),
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text('Name : ${log.name ?? ''}'),
//                             Text('Mobile Number : ${log.number ?? ''}'),
//                           ],
//                         ),
//                         const Spacer(),
//                         InkWell(
//                           onTap: () {
//                             if (log.number != null) {
//                               CommonMethod.whatsapp(
//                                   mobileNumber: log.number.toString());
//                             }
//                           },
//                           child: Image.asset(
//                             AppAssets.whatsapp,
//                             height: 30,
//                             width: 30,
//                           ),
//                         ),
//                         const SizedBox(
//                           width: 6,
//                         ),
//                         InkWell(
//                           onTap: () async {
//                             if (log.number != null) {
//                               await FlutterPhoneDirectCaller.callNumber(
//                                   log.number.toString());
//                             }
//                           },
//                           child: Image.asset(
//                             AppAssets.phoneIcon,
//                             height: 30,
//                             width: 30,
//                           ),
//                         ),
//                       ],
//                     )
//                     // ListTile(
//                     //   title: Text('Name: ${log.name ?? ''}'),
//                     //   subtitle: Text('Mobile Number :- ${log.number ?? ''}'),
//                     // ),
//                     );
//               },
//             ),
//           )
//       ]),
//     );
//   }

//   dialogData() {
//     return showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (context) {
//         return Dialog(
//           shape: const RoundedRectangleBorder(
//             borderRadius: BorderRadius.all(
//               Radius.circular(32.0),
//             ),
//           ),
//           child: Container(
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(30),
//               color: Colors.white,
//             ),
//             padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 Text(
//                   'Declaimer',
//                   style: AppTextStyle.semiBold20,
//                 ),
//                 const SizedBox(
//                   height: 6,
//                 ),
//                 Text(
//                   'Mirror respects your privacy. Therefore we do not collect or store your contact history. this feature only helps to remind for your leads.',
//                   textAlign: TextAlign.left,
//                   style: AppTextStyle.regular16,
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 Align(
//                   alignment: Alignment.center,
//                   child: InkWell(
//                     onTap: () {
//                       Navigator.pop(context);
//                     },
//                     child: Container(
//                       padding: const EdgeInsets.symmetric(
//                           vertical: 8, horizontal: 40),
//                       decoration: BoxDecoration(
//                         color: AppColors.appColors,
//                         borderRadius: BorderRadius.circular(10.0),
//                       ),
//                       child: const Text(
//                         'OK',
//                         textScaleFactor: 1.0,
//                         style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 20,
//                             fontWeight: FontWeight.w600),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

// }
