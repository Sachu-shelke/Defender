// import 'package:defenders/modules/parent/app_content_restriction/set_restriction_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:device_apps/device_apps.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../application/application_restrict.dart';
// import 'app_blocker_screen.dart';
//
// class AppContentRestriction extends StatefulWidget {
//   const AppContentRestriction({super.key});
//
//   @override
//   State<AppContentRestriction> createState() => _AppContentRestrictionState();
// }
//
// class _AppContentRestrictionState extends State<AppContentRestriction> {
//   List<Application> installedApps = [];
//   String? selectedOption;
//
//   @override
//   void initState() {
//     super.initState();
//     _loadInstalledApps();
//     _loadSelectedOption();
//   }
//
//   // Method to get installed apps
//   Future<void> _loadInstalledApps() async {
//     try {
//       List<Application> apps = await DeviceApps.getInstalledApplications(includeAppIcons: true);
//       setState(() {
//         installedApps = apps;
//       });
//     } catch (e) {
//       print("Error fetching apps: $e");
//     }
//   }
//
//   // Method to load the selected option from SharedPreferences
//   Future<void> _loadSelectedOption() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     setState(() {
//       selectedOption = prefs.getString('installedAppsOption') ?? 'Allowed';
//     });
//   }
//
//   // Method to save the selected option to SharedPreferences
//   Future<void> _saveSelectedOption(String option) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setString('installedAppsOption', option);
//     setState(() {
//       selectedOption = option;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         title: const Text('App Content Restriction'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Container(
//           height: MediaQuery.of(context).size.height * 0.20,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(15),
//             border: Border.all(width: 2, color: Colors.black),
//             color: Colors.grey[300],
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               ListTile(
//                 title: const Text('Open Newly Installed Apps'),
//                 trailing: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Text(selectedOption ?? 'Not selected', style: const TextStyle(fontSize: 14)),
//                     const SizedBox(width: 5),
//                     const Icon(Icons.arrow_forward_ios_outlined, size: 15),
//                   ],
//                 ),
//                 onTap: () async {
//                   final result = await Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => SetRestrictionScreen(onOptionSelected: (String option) {
//                         _saveSelectedOption(option); // Save selected option when user selects one
//                       }),
//                     ),
//                   );
//                 },
//               ),
//               const Divider(height: 1, thickness: 1, color: Colors.black),
//               InkWell(
//                 onTap: () async {
//                   Navigator.push(context, MaterialPageRoute(builder: (context)=>AppBlockedScreen()));
//                 },
//                 child: const ListTile(
//                   title: Text('App Blocker'),
//                   trailing: Icon(Icons.arrow_forward_ios_outlined, size: 15),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
