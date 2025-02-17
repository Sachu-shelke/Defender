import 'dart:async';
import 'package:flutter/material.dart';
import 'package:device_apps/device_apps.dart';
import 'package:app_usage/app_usage.dart';
import 'package:permission_handler/permission_handler.dart';

class AppBlockerScreen extends StatefulWidget {
  @override
  _AppBlockerScreenState createState() => _AppBlockerScreenState();
}

class _AppBlockerScreenState extends State<AppBlockerScreen> {
  List<Application> _apps = [];
  Map<String, double> _usageStats = {};
  List<String> _blockedApps = ['com.facebook.katana', 'com.whatsapp']; // Example of blocked apps
  Timer? _usageTimer;

  @override
  void initState() {
    super.initState();
    _getInstalledApps();
    _requestUsagePermission();
  }

  Future<void> _getInstalledApps() async {
    List<Application> apps = await DeviceApps.getInstalledApplications(
      includeAppIcons: true,
      includeSystemApps: false,
    );
    setState(() {
      _apps = apps;
    });
  }

  Future<void> _requestUsagePermission() async {
    PermissionStatus permissionStatus = await Permission.activityRecognition.request();

    if (permissionStatus.isGranted) {
      _fetchAppUsage();
      _startUsageTimer();
    } else {
      print('Permission denied');
    }
  }

  Future<void> _fetchAppUsage() async {
    try {
      DateTime endTime = DateTime.now();
      DateTime startTime = endTime.subtract(Duration(minutes: 5)); // Last 5 minutes usage

      List<AppUsageInfo> usageList = await AppUsage().getAppUsage(startTime, endTime);
      Map<String, double> usageMap = {
        for (var info in usageList) info.packageName: info.usage.inMinutes.toDouble()
      };

      setState(() {
        _usageStats = usageMap;
      });

      _checkForBlockedApps();
    } catch (e) {
      print('Error fetching app usage: $e');
    }
  }

  void _startUsageTimer() {
    _usageTimer = Timer.periodic(Duration(seconds: 5), (timer) {
      _fetchAppUsage();
    });
  }

  void _checkForBlockedApps() {
    _usageStats.forEach((packageName, usage) {
      if (_blockedApps.contains(packageName) && usage > 0) {
        _showBlockScreen(packageName);
      }
    });
  }

  // ✅ Show block/unblock options dialog
  void _showBlockUnblockDialog(Application app) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Block/Unblock App"),
          content: Text("Would you like to block or unblock ${app.appName}?"),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  if (_blockedApps.contains(app.packageName)) {
                    _blockedApps.remove(app.packageName); // Unblock app
                  } else {
                    _blockedApps.add(app.packageName); // Block app
                  }
                });
                Navigator.of(context).pop();
              },
              child: Text(_blockedApps.contains(app.packageName) ? "Unblock" : "Block"),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("Cancel"),
            ),
          ],
        );
      },
    );
  }

  void _showBlockScreen(String packageName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Blocked App Detected"),
          content: Text("You are trying to use a blocked app: $packageName."),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("Close"),
            ),
          ],
        );
      },
    );
  }

  Future<void> _openAppIfNotBlocked(String packageName) async {
    if (_blockedApps.contains(packageName)) {
      // Show blocked message
      _showBlockScreen(packageName);
    } else {
      // Open app if not blocked
      await DeviceApps.openApp(packageName);
    }
  }

  @override
  void dispose() {
    _usageTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('App Blocker')),
      body: _apps.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: _apps.length,
        itemBuilder: (context, index) {
          Application app = _apps[index];
          double usageMinutes = _usageStats[app.packageName] ?? 0.0;

          return ListTile(
            leading: app is ApplicationWithIcon
                ? Image.memory(app.icon, width: 40, height: 40)
                : Icon(Icons.android),
            title: Text(app.appName),
            trailing: IconButton(
              icon: Icon(Icons.open_in_new),
              onPressed: () => _openAppIfNotBlocked(app.packageName),
            ),
            onTap: () => _showBlockUnblockDialog(app), // Show block/unblock dialog
          );
        },
      ),
    );
  }
}
