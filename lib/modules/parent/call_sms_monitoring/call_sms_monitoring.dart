import 'package:defenders/modules/parent/call_sms_monitoring/sms_detection_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main_home/widget/build_widget/build_widget.dart';
import '../main_home/widget/build_widget/listtile.dart';
import 'blocked_calls_screen.dart';
import 'call_blacklist_screen.dart';
import 'call_whitelist_screen.dart';
import 'keybord_management_screen.dart';
import 'mode_screen.dart';

class CallSmsMonitoring extends StatefulWidget {
  const CallSmsMonitoring({super.key});

  @override
  State<CallSmsMonitoring> createState() => _CallSmsMonitoringState();
}

class _CallSmsMonitoringState extends State<CallSmsMonitoring> {
  bool _isSwitched = false; // Variable to track the state of the switch

  // Method to handle switch toggle
  void _handleSwitchChange(bool value) {
    setState(() {
      _isSwitched = value; // Update the state of the switch
    });
  }
  String _selectedMode = 'Unrestricted Mode'; // Default value

  // Method to get the selected mode from SharedPreferences
  Future<void> _getSelectedMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedMode = prefs.getString('selectedMode') ?? 'Unrestricted Mode'; // Retrieve saved mode
    });
  }

  @override
  void initState() {
    super.initState();
    _getSelectedMode(); // Fetch selected mode when screen loads
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text('Call and SMS Monitoring')),
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

                // Display selected mode
                CustomListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ModeScreen()),
                    ).then((_) {
                      _getSelectedMode(); // Update the mode after returning from ModeScreen
                    });
                  },
                  leadingIcon: Icons.add_chart_outlined,
                  title: 'Mode',
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(_selectedMode),  // Display selected mode here
                      const SizedBox(width: 4),
                      const Icon(Icons.arrow_forward_ios_outlined, size: 12),
                    ],
                  ),
                ),

                CustomListTile(
                  leadingIcon: Icons.mobile_off,
                  title: 'Call Blacklist',
                  trailing: const Icon(Icons.arrow_forward_ios_outlined, size: 12),
                  onTap:(){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CallBlacklistScreen()),
                    );
                  },
                ),
                CustomListTile(
                  leadingIcon: Icons.mobile_friendly,
                  title: 'Call Whitelist',
                  trailing: const Icon(Icons.arrow_forward_ios_outlined, size: 12),
                  onTap:(){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CallWhitelistScreen()),
                    );
                  },
                ),
              ]),

              const SizedBox(height: 5),
              const Divider(thickness: 1), // Divider between sections

              CustomWidgets.buildListTileSection([
                CustomListTile(
                  leadingIcon: Icons.call_outlined,
                  title: 'Blocked Calls',
                  trailing: const Icon(Icons.arrow_forward_ios_outlined, size: 12),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>BlockedCallsScreen()));

                  },
                ),
              ]),

              const Text('SMS', style: TextStyle(fontSize: 12, color: Colors.grey)),

              CustomWidgets.buildListTileSection([
                CustomWidgets.buildListTileWithSwitch(
                  Icons.sms_outlined,
                  iconColor: Colors.blueAccent,
                  'SMS Keyword Detection',
                  _isSwitched,
                  _handleSwitchChange,
                ),
                // CustomListTile(
                //   leadingIcon: Icons.sms_outlined,
                //   title: 'SMS Keyword Detection',
                //   trailing: const Icon(Icons.arrow_forward_ios_outlined, size: 12),
                // ),
                CustomListTile(
                  leadingIcon: Icons.keyboard,
                  title: 'Keyboard Management',
                  trailing: const Icon(Icons.arrow_forward_ios_outlined, size: 12),
                  onTap: () {
                    // Navigate to Keyboard Management Screen
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>KeywordManagementScreen()));
                  },
                ),
              ]),

              SizedBox(height: 10),

              CustomWidgets.buildListTileSection([
                CustomListTile(
                  leadingIcon: Icons.try_sms_star_outlined,
                  title: 'SMS Detection Records',
                  trailing: const Icon(Icons.arrow_forward_ios_outlined, size: 12),
                  onTap: () {
                    // Navigate to SMS Detection Records Screen
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>SmsDetectionScreen()));
                  },
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
