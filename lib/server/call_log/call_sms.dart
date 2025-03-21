import 'package:defenders/server/call_log/sms_screen.dart';
import 'package:flutter/material.dart';
import 'calls_screen.dart';

class CallSmsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Call & SMS Logs"),
          bottom: TabBar(
            tabs: [
              // Tab(text: "📞 Calls"),
              Tab(text: "📩 SMS"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // CallLogsScreen(),
            // SmsLogsScreen(),
          ],
        ),
      ),
    );
  }
}
