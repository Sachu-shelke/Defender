// import 'package:flutter/material.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class CallLogsScreen extends StatefulWidget {
//   @override
//   _CallLogsScreenState createState() => _CallLogsScreenState();
// }
//
// class _CallLogsScreenState extends State<CallLogsScreen> {
//   List<Map<String, String>> callLogs = [];
//
//   @override
//   void initState() {
//     super.initState();
//     loadCallLogs();
//   }
//
//   Future<void> loadCallLogs() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     List<String>? savedLogs = prefs.getStringList("call_logs");
//
//     if (savedLogs != null) {
//       setState(() {
//         callLogs = savedLogs.map((log) {
//           List<String> parts = log.split("|");
//           return {"number": parts[0], "time": parts[1]};
//         }).toList();
//       });
//     } else {
//       getCallLogs();
//     }
//   }
//
//   Future<void> getCallLogs() async {
//     if (await Permission.phone.request().isGranted &&
//         await Permission.contacts.request().isGranted) {
//       Iterable<CallLogEntry> entries = await CallLog.get();
//       List<Map<String, String>> logs = [];
//
//       for (CallLogEntry entry in entries) {
//         String formattedTime = DateTime.fromMillisecondsSinceEpoch(entry.timestamp ?? 0)
//             .toLocal()
//             .toString();
//         logs.add({"number": entry.number ?? "Unknown", "time": formattedTime});
//       }
//
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       await prefs.setStringList("call_logs", logs.map((e) => "${e['number']}|${e['time']}").toList());
//
//       setState(() {
//         callLogs = logs;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: callLogs.length,
//       itemBuilder: (context, index) {
//         return ListTile(
//           leading: Icon(Icons.call, color: Colors.green),
//           title: Text(callLogs[index]["number"] ?? "Unknown"),
//           subtitle: Text(callLogs[index]["time"] ?? ""),
//         );
//       },
//     );
//   }
// }
