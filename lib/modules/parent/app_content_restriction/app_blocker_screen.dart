// import 'dart:typed_data';
// import 'package:flutter/material.dart';
// import 'package:device_apps/device_apps.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class AppBlockedScreen extends StatefulWidget {
//   @override
//   _AppBlockerScreenState createState() => _AppBlockerScreenState();
// }
//
// class _AppBlockerScreenState extends State<AppBlockedScreen> {
//   List<Application> installedApps = [];
//   TextEditingController searchController = TextEditingController();
//   List<Application> filteredApps = [];
//
//   @override
//   void initState() {
//     super.initState();
//     _loadInstalledApps();
//   }
//
//   // Method to get installed apps
//   Future<void> _loadInstalledApps() async {
//     try {
//       List<Application> apps = await DeviceApps.getInstalledApplications(includeAppIcons: true);
//       setState(() {
//         installedApps = apps;
//         filteredApps = apps;
//       });
//     } catch (e) {
//       print("Error fetching apps: $e");
//     }
//   }
//
//   // Filter apps based on the search query
//   void _filterApps(String query) {
//     final filtered = installedApps.where((app) {
//       return app.appName.toLowerCase().contains(query.toLowerCase());
//     }).toList();
//
//     setState(() {
//       filteredApps = filtered;
//     });
//   }
//
//   // Save the block status of apps using SharedPreferences
//   Future<void> _saveAppBlockStatus(String packageName, bool isBlocked) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setBool(packageName, isBlocked);
//   }
//
//   // Load block status of apps
//   Future<bool> _getAppBlockStatus(String packageName) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     return prefs.getBool(packageName) ?? false;
//   }
//
//   // Open an app if it's not blocked
//   Future<void> _openApp(String packageName) async {
//     bool isBlocked = await _getAppBlockStatus(packageName);
//     if (isBlocked) {
//       _showBlockedAlert();
//     } else {
//       await DeviceApps.openApp(packageName);
//     }
//   }
//
//   // Show alert when an app is blocked
//   void _showBlockedAlert() {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('App Blocked'),
//         content: const Text('This app is currently blocked and cannot be opened.'),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//             child: const Text('OK'),
//           ),
//         ],
//       ),
//     );
//   }
//
//   // Fetch app icon as a future
//   Future<Uint8List?> _getAppIcon(String packageName) async {
//     try {
//       // return await DeviceApps.getAppIcon(packageName);
//     } catch (e) {
//       print('Error fetching icon for $packageName: $e');
//       return null;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         title: const Text('App Blocker'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: searchController,
//               onChanged: _filterApps,
//               decoration: InputDecoration(
//                 hintText: 'Search apps...',
//                 prefixIcon: Icon(Icons.search),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 10),
//             Expanded(
//               child: FutureBuilder<List<Application>>(
//                 future: DeviceApps.getInstalledApplications(includeAppIcons: true),
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return Center(child: CircularProgressIndicator());
//                   } else if (snapshot.hasError) {
//                     return Center(child: Text('Error: ${snapshot.error}'));
//                   } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//                     return Center(child: Text('No applications available.'));
//                   } else {
//                     List<Application> apps = snapshot.data!;
//                     return ListView.builder(
//                       itemCount: apps.length,
//                       itemBuilder: (context, index) {
//                         final app = apps[index];
//                         return FutureBuilder<Uint8List?>(
//                           future: _getAppIcon(app.packageName),
//                           builder: (context, iconSnapshot) {
//                             if (iconSnapshot.connectionState == ConnectionState.waiting) {
//                               return ListTile(
//                                 leading: CircularProgressIndicator(),
//                                 title: Text(app.appName ?? 'Unknown App'),
//                                 trailing: Switch(
//                                   value: false,
//                                   onChanged: (bool value) {},
//                                 ),
//                               );
//                             } else if (iconSnapshot.hasError) {
//                               return ListTile(
//                                 leading: Icon(Icons.error),
//                                 title: Text(app.appName ?? 'Unknown App'),
//                                 trailing: Switch(
//                                   value: false,
//                                   onChanged: (bool value) {},
//                                 ),
//                               );
//                             } else {
//                               // If icon is available
//                               Uint8List? appIcon = iconSnapshot.data;
//                               return ListTile(
//                                 leading: appIcon != null
//                                     ? Image.memory(
//                                   appIcon,
//                                   width: 40,
//                                   height: 40,
//                                 )
//                                     : Icon(Icons.apple, size: 40),
//                                 title: Text(app.appName ?? 'Unknown App'),
//                                 trailing: FutureBuilder<bool>(
//                                   future: _getAppBlockStatus(app.packageName),
//                                   builder: (context, snapshot) {
//                                     bool isBlocked = snapshot.data ?? false;
//                                     return Switch(
//                                       value: isBlocked,
//                                       onChanged: (bool value) {
//                                         _saveAppBlockStatus(app.packageName, value);
//                                         setState(() {});
//                                       },
//                                     );
//                                   },
//                                 ),
//                                 onTap: () {
//                                   _openApp(app.packageName);
//                                 },
//                               );
//                             }
//                           },
//                         );
//                       },
//                     );
//                   }
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
// }
