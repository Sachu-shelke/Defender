// import 'package:defenders/modules/parent/application/usage_details.dart';
// import 'package:flutter/material.dart';
// // import 'package:device_apps/device_apps.dart';
// import 'package:percent_indicator/linear_percent_indicator.dart';
//
// class AppUsageScreen extends StatefulWidget {
//   @override
//   _AppUsageScreenState createState() => _AppUsageScreenState();
// }
//
// class _AppUsageScreenState extends State<AppUsageScreen> {
//   // List<Application>? apps;
//
//   @override
//   void initState() {
//     super.initState();
//     _getInstalledApps();
//   }
//
//   void _getInstalledApps() async {
//     List<Application> installedApps = await DeviceApps.getInstalledApplications(
//       includeSystemApps: false,  // Only user apps
//       onlyAppsWithLaunchIntent: true,  // Only launchable apps
//     );
//
//     installedApps.sort((a, b) {
//       int usageA = (a.packageName.length * 10);
//       int usageB = (b.packageName.length * 10);
//       return usageB - usageA;
//     });
//
//     setState(() {
//       apps = installedApps;
//     });
//   }
//
//   String formatUsageTime(int totalSeconds) {
//     int hours = totalSeconds ~/ 3600;
//     int minutes = (totalSeconds % 3600) ~/ 60;
//     int seconds = totalSeconds % 60;
//     return "$hours h $minutes min $seconds s";
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Today's Event"),
//         backgroundColor: Colors.blueGrey,
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               "Most Used Apps Today",
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 10),
//             apps == null
//                 ? Center(child: CircularProgressIndicator()) // Show a loading indicator
//                 : Expanded(
//               child: ListView.builder(
//                 itemCount: apps!.length,
//                 itemBuilder: (context, index) {
//                   int totalUsageSeconds = (index + 1) * 600; // Simulated usage time (10 min per app)
//                   String formattedTime = formatUsageTime(totalUsageSeconds);
//                   double percent = (index + 1) / apps!.length;
//                   Color progressColor;
//                   if (percent >= 0.75) {
//                     progressColor = Colors.red;
//                   } else if (percent >= 0.5) {
//                     progressColor = Colors.orange;
//                   } else {
//                     progressColor = Colors.green;
//                   }
//
//                   return Card(
//                     elevation: 2,
//                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//                     child: ListTile(
//                       leading: Icon(Icons.app_blocking, size: 30, color: Colors.blueGrey),
//                       title: Text(apps![index].appName),
//                       subtitle: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text("Usage Time: $formattedTime"),
//                           SizedBox(height: 5),
//                           LinearPercentIndicator(
//                             lineHeight: 6.0,
//                             percent: percent,
//                             backgroundColor: Colors.grey.shade300,
//                             progressColor: progressColor,
//                           ),
//                         ],
//                       ),
//                       onTap: () {
//                         // Navigate to the AppDetailsScreen
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => AppDetailsScreen(app: apps![index]),
//                           ),
//                         );
//                       },
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
