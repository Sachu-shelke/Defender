// import 'package:flutter/material.dart';
// import 'package:telephony/telephony.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class SmsLogsScreen extends StatefulWidget {
//   @override
//   _SmsLogsScreenState createState() => _SmsLogsScreenState();
// }
//
// class _SmsLogsScreenState extends State<SmsLogsScreen> {
//   List<Map<String, String>> smsLogs = [];
//
//   @override
//   void initState() {
//     super.initState();
//     loadSmsLogs();
//   }
//
//   Future<void> loadSmsLogs() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     List<String>? savedLogs = prefs.getStringList("sms_logs");
//
//     if (savedLogs != null) {
//       setState(() {
//         smsLogs = savedLogs.map((log) {
//           List<String> parts = log.split("|");
//           return {"number": parts[0], "message": parts[1], "time": parts[2]};
//         }).toList();
//       });
//     } else {
//       getSmsLogs();
//     }
//   }
//
//   Future<void> getSmsLogs() async {
//     final Telephony telephony = Telephony.instance;
//     if (await Permission.sms.request().isGranted) {
//       List<SmsMessage> messages = await telephony.getInboxSms();
//       List<Map<String, String>> logs = [];
//
//       for (SmsMessage message in messages) {
//         String formattedTime = DateTime.fromMillisecondsSinceEpoch(message.date ?? 0)
//             .toLocal()
//             .toString();
//         logs.add({
//           "number": message.address ?? "Unknown",
//           "message": message.body ?? "",
//           "time": formattedTime
//         });
//       }
//
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       await prefs.setStringList(
//           "sms_logs", logs.map((e) => "${e['number']}|${e['message']}|${e['time']}").toList());
//
//       setState(() {
//         smsLogs = logs;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: smsLogs.length,
//       itemBuilder: (context, index) {
//         return ListTile(
//           leading: Icon(Icons.message, color: Colors.blue),
//           title: Text(smsLogs[index]["number"] ?? "Unknown"),
//           subtitle: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(smsLogs[index]["message"] ?? ""),
//               Text(smsLogs[index]["time"] ?? "", style: TextStyle(fontSize: 12, color: Colors.grey)),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
