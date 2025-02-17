import 'package:flutter/material.dart';
import '../../main_home/widget/build_widget/build_widget.dart';
import '../../main_home/widget/build_widget/listtile.dart';

class CallSmsMonitoring extends StatefulWidget {
  const CallSmsMonitoring({super.key});

  @override
  State<CallSmsMonitoring> createState() => _CallSmsMonitoringState();
}

class _CallSmsMonitoringState extends State<CallSmsMonitoring> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Call and SMS Monitoring')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              const Text('Phone', style: TextStyle(fontSize: 12, color: Colors.grey)),
              const Divider(thickness: 1),

              CustomWidgets.buildListTileSection([
                CustomListTile(
                  leadingIcon: Icons.add_chart_outlined,
                  title: 'Mode',
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min, // Ensures proper alignment
                    children: const [
                      Text('Blacklist Mode'),
                      SizedBox(width: 4),
                      Icon(Icons.arrow_forward_ios_outlined, size: 12),
                    ],
                  ),
                ),
                CustomListTile(
                  leadingIcon: Icons.mobile_off,
                  title: 'Call Blacklist',
                  trailing: const Icon(Icons.arrow_forward_ios_outlined, size: 12),
                ),
                CustomListTile(
                  leadingIcon: Icons.mobile_friendly,
                  title: 'Call Whitelist',
                  trailing: const Icon(Icons.arrow_forward_ios_outlined, size: 12),
                ),
              ]),

              const SizedBox(height: 5),
              const Divider(thickness: 1), // Divider between sections

              CustomWidgets.buildListTileSection([
                CustomListTile(
                  leadingIcon: Icons.call_outlined,
                  title: 'Blocked Calls',
                  trailing: const Icon(Icons.arrow_forward_ios_outlined, size: 12),
                ),
              ]),
              const Text('SMS', style: TextStyle(fontSize: 12, color: Colors.grey)),

              CustomWidgets.buildListTileSection([
                CustomListTile(
                  leadingIcon: Icons.sms_outlined,
                  title: 'SMS Keyword Detection',
                  trailing: const Icon(Icons.arrow_forward_ios_outlined, size: 12),
                ),
                CustomListTile(
                  leadingIcon: Icons.keyboard,
                  title: 'keyboard Management',
                  trailing: const Icon(Icons.arrow_forward_ios_outlined, size: 12),
                ),
              ]),
              SizedBox(height: 10,),
              CustomWidgets.buildListTileSection([
                CustomListTile(
                  leadingIcon: Icons.try_sms_star_outlined,
                  title: 'SMS Detection Records',
                  trailing: const Icon(Icons.arrow_forward_ios_outlined, size: 12),
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
