// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:device_apps/device_apps.dart';
// import 'package:app_usage/app_usage.dart';
// import 'package:permission_handler/permission_handler.dart';
//
// class InstalledAppsScreen extends StatefulWidget {
//   @override
//   _InstalledAppsScreenState createState() => _InstalledAppsScreenState();
// }
//
// class _InstalledAppsScreenState extends State<InstalledAppsScreen> {
//   List<Application> _apps = [];
//   Map<String, double> _usageStats = {};
//   Timer? _usageTimer;
//
//   @override
//   void initState() {
//     super.initState();
//     _getInstalledApps();
//     _requestUsagePermission();
//   }
//
//   Future<void> _getInstalledApps() async {
//     List<Application> apps = await DeviceApps.getInstalledApplications(
//       includeAppIcons: true, // Get app icons
//       includeSystemApps: false, // Ignore system apps
//     );
//     setState(() {
//       _apps = apps;
//     });
//   }
//
//   Future<void> _requestUsagePermission() async {
//     PermissionStatus permissionStatus = await Permission.activityRecognition.request();
//
//     if (permissionStatus.isGranted) {
//       _fetchAppUsage();
//       _startUsageTimer();
//     } else {
//       print('Permission denied');
//     }
//   }
//
//   Future<void> _fetchAppUsage() async {
//     try {
//       DateTime endTime = DateTime.now();
//       DateTime startTime = endTime.subtract(Duration(hours: 1)); // Last 1 hour usage
//
//       List<AppUsageInfo> usageList = await AppUsage().getAppUsage(startTime, endTime);
//       Map<String, double> usageMap = {
//         for (var info in usageList) info.packageName: info.usage.inMinutes.toDouble()
//       };
//
//       setState(() {
//         _usageStats = usageMap;
//       });
//     } catch (e) {
//       print('Error fetching app usage: $e');
//     }
//   }
//
//   void _startUsageTimer() {
//     _usageTimer = Timer.periodic(Duration(seconds: 10), (timer) {
//       _fetchAppUsage();
//     });
//   }
//
//   @override
//   void dispose() {
//     _usageTimer?.cancel();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//           backgroundColor: Colors.white,
//           title: Text('Installed Apps & Usage')),
//       body: _apps.isEmpty
//           ? Center(child: CircularProgressIndicator())
//           : ListView.builder(
//         itemCount: _apps.length,
//         itemBuilder: (context, index) {
//           Application app = _apps[index];
//           double usageMinutes = _usageStats[app.packageName] ?? 0.0;
//
//           return ListTile(
//             leading: app is ApplicationWithIcon
//                 ? Image.memory(app.icon, width: 40, height: 40)
//                 : Icon(Icons.android),
//             title: Text(app.appName),
//             subtitle: Text('Usage: ${usageMinutes.toStringAsFixed(1)} min'),
//             trailing: IconButton(
//               icon: Icon(Icons.open_in_new),
//               onPressed: () => DeviceApps.openApp(app.packageName),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
