// import 'package:flutter/material.dart';
// import 'package:device_apps/device_apps.dart';
// import 'package:permission_handler/permission_handler.dart';
//
// class AppDetailsScreen extends StatefulWidget {
//   final Application app;
//
//   AppDetailsScreen({required this.app});
//
//   @override
//   _AppDetailsScreenState createState() => _AppDetailsScreenState();
// }
//
// class _AppDetailsScreenState extends State<AppDetailsScreen> {
//   int notificationCount = 0; // Placeholder for notification count
//   double dataUsage = 0.0; // Placeholder for data usage (in bytes)
//   String developer = "Unknown Developer"; // Removed developer fetching logic
//   String ageRating = "4+"; // Placeholder for age rating
//   List<String> permissions = [];
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchAppDetails();
//   }
//
//   // Function to fetch app details like developer and permissions
//   Future<void> _fetchAppDetails() async {
//     // Fetch permissions for the app using permission_handler
//     await _getPermissions();
//
//     // Removed developer fetching logic for now
//
//     setState(() {});
//   }
//
//   // Fetch permissions granted by the app
//   Future<void> _getPermissions() async {
//     // Request permissions for the app
//     PermissionStatus permissionStatus = await Permission.notification.request();
//
//     if (permissionStatus.isGranted) {
//       permissions.add("Notification Access");
//     } else {
//       permissions.add("No Notification Access");
//     }
//     setState(() {});
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.app.appName),
//         backgroundColor: Colors.blueGrey,
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: ListView(
//           children: [
//             Card(
//               child: Column(
//                 children: [
//                   ListTile(
//                     title: Text('App Name', style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black)),
//                     subtitle: Text(widget.app.appName, style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black)),
//                   ),
//                   // Number of Notifications
//                   ListTile(
//                     title: Text('Number of Notifications'),
//                     subtitle: Row(
//                       children: [
//                         Text('$notificationCount'),
//                         Text(' Received notifications'),
//                       ],
//                     ),
//                   ),
//                   // Cellular Data Usage
//                   ListTile(
//                     title: Text('Cellular Data Usage'),
//                     subtitle: Row(
//                       children: [
//                         Text('${dataUsage.toStringAsFixed(2)}'),
//                         Text(' Bytes'),
//                       ],
//                     ),
//                   ),
//                   // Package Name
//                   ListTile(
//                     title: Text('Package Name'),
//                     subtitle: Text(widget.app.packageName),
//                   ),
//                   // Version
//                   ListTile(
//                     title: Text('Version'),
//                     subtitle: Text(widget.app.versionName ?? "N/A"),
//                   ),
//                   // Categories
//                   ListTile(
//                     title: Text('Categories'),
//                     subtitle: Text(widget.app.category?.name ?? "No category available"),
//                   ),
//                   // Installed Time
//                   ListTile(
//                     title: Text('Installed Time'),
//                     subtitle: Text(
//                       widget.app.installTimeMillis == null
//                           ? "N/A"
//                           : "${DateTime.fromMillisecondsSinceEpoch(widget.app.installTimeMillis!)}",
//                     ),
//                   ),
//                   // Developer (Removed fetching logic, just placeholder)
//                   ListTile(
//                     title: Text('Developer'),
//                     subtitle: Text(developer),  // Just a placeholder
//                   ),
//                   // Age Rating
//                   ListTile(
//                     title: Text('Age Rating'),
//                     subtitle: Text(ageRating), // Placeholder for Age Rating
//                   ),
//                   // Last Updated Time
//                   ListTile(
//                     title: Text('Last Updated'),
//                     subtitle: Text(
//                       widget.app.updateTimeMillis == null
//                           ? "N/A"
//                           : "${DateTime.fromMillisecondsSinceEpoch(widget.app.updateTimeMillis!)}",
//                     ),
//                   ),
//                   // Permissions
//                   ListTile(
//                     title: Text('Permissions'),
//                     subtitle: Text(permissions.join(', ') ?? "Permissions data unavailable"),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
