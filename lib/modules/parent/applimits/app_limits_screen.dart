import 'package:flutter/material.dart';
import 'dart:convert'; // For jsonEncode and jsonDecode
import 'package:shared_preferences/shared_preferences.dart';
import 'add_limit_screen.dart';

// Widget for displaying each limit in the list
class LimitCard extends StatelessWidget {
  final Map<String, dynamic> limit;
  final Function(bool) onToggle;
  final Function() onDelete;

  const LimitCard({required this.limit, required this.onToggle, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white70,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Limit Type: ${limit['selectedLimitType']}'),
            Text('Days: ${limit['selectedDays']}'),
            Text('Start Time: ${limit['startTime']}'),
            Text('End Time: ${limit['endTime']}'),
            Text('Geofence: ${limit['geofenceEnabled'] ? 'Enabled' : 'Disabled'}'),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Active:', style: TextStyle(fontWeight: FontWeight.bold)),
                Switch(
                  value: limit['isActive'] ?? false,  // Default to false if not set
                  onChanged: onToggle,
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: onDelete,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class AppLimitsScreen extends StatefulWidget {
  const AppLimitsScreen({super.key});

  @override
  State<AppLimitsScreen> createState() => _AppLimitsScreenState();
}

class _AppLimitsScreenState extends State<AppLimitsScreen> {
  List<Map<String, dynamic>> limits = [];

  @override
  void initState() {
    super.initState();
    _loadLimits();
  }

  // Load saved limits from SharedPreferences
  Future<void> _loadLimits() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedLimits = prefs.getString('limits');

    if (savedLimits != null) {
      // Decode the saved limits into a list of maps
      List<dynamic> decodedLimits = jsonDecode(savedLimits);
      setState(() {
        limits = decodedLimits.map((e) => Map<String, dynamic>.from(e)).toList();
      });
    }
  }

  // Save limits to SharedPreferences
  Future<void> _saveLimits() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String encodedLimits = jsonEncode(limits);  // Convert list of maps to a JSON string
    prefs.setString('limits', encodedLimits);
  }

  // Toggle the 'isActive' status of a limit
  void _toggleLimitStatus(int index, bool value) {
    setState(() {
      limits[index]['isActive'] = value;  // Update the limit's 'isActive' value
    });
    _saveLimits();  // Save the updated limits to SharedPreferences
  }

  // Delete a limit from the list and update SharedPreferences
  void _deleteLimit(Map<String, dynamic> limit) {
    setState(() {
      limits.remove(limit);
    });
    _saveLimits();  // Update SharedPreferences after deletion
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('App Limits'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/break.png', // Placeholder image
              width: 200,
              height: 200,
            ),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: TextStyle(fontSize: 16, color: Colors.black),
                children: [
                  TextSpan(
                    text: 'Set time limits or schedule downtime to make apps or categories ',
                    style: TextStyle(fontSize: 14),
                  ),
                  TextSpan(
                    text: 'inaccessible within a certain time frame.',
                    style: TextStyle(fontSize: 14, ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            if (limits.isEmpty)
              Center(
                child: Text(
                  '',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              )
            else
              Expanded(
                child: ListView.builder(
                  itemCount: limits.length,
                  itemBuilder: (context, index) {
                    var limit = limits[index];
                    return LimitCard(
                      limit: limit,
                      onToggle: (bool value) => _toggleLimitStatus(index, value),
                      onDelete: () => _deleteLimit(limit),
                    );
                  },
                ),
              ),
            SizedBox(height: 32),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  // Navigate to AddLimitScreen and await the returned data
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddLimitScreen()),
                  );

                  // If data is returned, update the limits list and save to SharedPreferences
                  if (result != null) {
                    setState(() {
                      // Set default value of 'isActive' to false when adding a new limit
                      result['isActive'] = false;
                      limits.add(result);
                    });
                    _saveLimits();  // Save the updated limits to SharedPreferences
                  }
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Colors.blue, // Text color
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15), // Padding inside the button
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), // Rounded corners
                  ),
                  elevation: 5, // Shadow effect
                ),
                child: Text(
                  'Add Limit',
                  style: TextStyle(
                    fontSize: 18, // Font size
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
}
