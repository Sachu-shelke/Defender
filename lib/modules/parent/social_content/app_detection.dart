import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppDetectionScreen extends StatefulWidget {
  @override
  _AppDetectionScreenState createState() => _AppDetectionScreenState();
}

class _AppDetectionScreenState extends State<AppDetectionScreen> {
  // List of apps with their detection status
  final List<Map<String, dynamic>> apps = [
    {"name": "WhatsApp", "icon": Icons.message, "enabled": false, "description": "Detect message conversations"},
    {"name": "Instagram", "icon": Icons.photo, "enabled": false, "description": "Detect searched content, browsed texts, and sent messages"},
    {"name": "YouTube", "icon": Icons.ondemand_video, "enabled": false, "description": "Detect searched content, and viewed and posted video titles"},
    {"name": "Facebook", "icon": Icons.facebook, "enabled": false, "description": "Detect searched content, and browsed and posted texts"},
    {"name": "LINE", "icon": Icons.chat, "enabled": false, "description": "Detect message conversations"},
    {"name": "X", "icon": Icons.article, "enabled": false, "description": "Detect searched content and browsed texts"},
    {"name": "Snapchat", "icon": Icons.camera_alt, "enabled": false, "description": "Detect message conversations"},
    {"name": "Telegram", "icon": Icons.send, "enabled": false, "description": "Detect message conversations"},
  ];

  @override
  void initState() {
    super.initState();
    _loadSwitchValues();
  }

  // Load switch values from SharedPreferences
  Future<void> _loadSwitchValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    for (int i = 0; i < apps.length; i++) {
      bool isEnabled = prefs.getBool(apps[i]['name']) ?? false;
      setState(() {
        apps[i]['enabled'] = isEnabled;
      });
    }
  }

  // Save switch value to SharedPreferences
  Future<void> _saveSwitchValue(String appName, bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(appName, value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("App Detection "),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: ListView.builder(
        itemCount: apps.length,
        itemBuilder: (context, index) {
          return SwitchListTile(
            secondary: Material(
              elevation: 2,
              borderRadius: BorderRadius.circular(30),
              child: CircleAvatar(
                backgroundColor: Colors.white70,
                foregroundColor: Colors.blue,
                child: Icon(apps[index]['icon'], color: Colors.black),
              ),
            ),
            title: Text(apps[index]['name'], style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(apps[index]['description']),
            value: apps[index]['enabled'],
            onChanged: (bool value) {
              setState(() {
                apps[index]['enabled'] = value;
              });
              _saveSwitchValue(apps[index]['name'], value);
            },
          );
        },
      ),
    );
  }
}
