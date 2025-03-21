import 'dart:convert'; // For JSON encoding and decoding
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'downscreen.dart'; // Assuming you have a Downscreen file for the 'Downscreen' widget

class DowntimeScreen extends StatefulWidget {
  @override
  _DowntimeScreenState createState() => _DowntimeScreenState();
}

class _DowntimeScreenState extends State<DowntimeScreen> {
  List<Map<String, dynamic>> newDataList = [];
  bool _isTimeCustomizable = false;

  @override
  void initState() {
    super.initState();
    _loadSavedData();
  }

  // Load saved data from SharedPreferences
  Future<void> _loadSavedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Load saved customization setting
    bool isTimeCustomizable = prefs.getBool('isTimeCustomizable') ?? false;
    setState(() {
      _isTimeCustomizable = isTimeCustomizable;
    });

    // Load saved data list
    String? savedDataString = prefs.getString('newDataList');
    if (savedDataString != null) {
      List<dynamic> savedDataList = jsonDecode(savedDataString); // Deserialize JSON into a List<Map<String, dynamic>>
      setState(() {
        newDataList = List<Map<String, dynamic>>.from(savedDataList);
      });
    }
  }

  // Save data to SharedPreferences
  Future<void> _saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Save customization settings
    await prefs.setBool('isTimeCustomizable', _isTimeCustomizable);

    // Save downtime data
    String savedDataString = jsonEncode(newDataList); // Serialize List<Map<String, dynamic>> to JSON
    await prefs.setString('newDataList', savedDataString);
  }

  void _loadDataFromDownscreen() async {
    final data = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Downscreen()),
    );

    if (data != null) {
      setState(() {
        // Set the default selected days to all days
        newDataList.add({
          'remark': data['remark'],
          'selectedDays': List<String>.from([
            'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'
          ]), // Default to all days selected
          'isScheduled': data['isScheduled'],
          'startTime': data['startTime'],  // Store the selected start time
          'endTime': data['endTime'],      // Store the selected end time
        });
      });

      // Save the updated list of data to SharedPreferences
      await _saveData();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Data saved successfully!')),
      );
    }
  }

  // Toggle downtime scheduled state
  void _toggleScheduled(int index, bool value) {
    setState(() {
      newDataList[index]['isScheduled'] = value;
    });
    _saveData();
  }

  // Delete an entry from the list
  void _deleteData(int index) {
    setState(() {
      newDataList.removeAt(index);
    });
    _saveData();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Data deleted successfully!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Downtime Data'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.asset('assets/images/smartphone.png', width: 200, height: 200),
            SizedBox(height: 20),
            Text('During downtime, only phone calls and the'),
            Text('apps that you add to the Always Allowed will be'),
            Text('available'),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: newDataList.length,
                itemBuilder: (context, index) {
                  var data = newDataList[index];

                  // Ensure startTime and endTime are valid (not null)
                  TimeOfDay startTime = data['startTime'] ?? TimeOfDay(hour: 12, minute: 0); // Default to 12:00 PM if null
                  TimeOfDay endTime = data['endTime'] ?? TimeOfDay(hour: 12, minute: 0); // Default to 12:00 PM if null

                  String startTimeFormatted = startTime.format(context);
                  String endTimeFormatted = endTime.format(context);

                  return Card(
                    color: Colors.white70,
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(data['remark']),
                          subtitle: Text('Custom Days: ${data['selectedDays'].join(', ')}'),
                          trailing: Switch(
                            value: data['isScheduled'] ?? false,
                            onChanged: (bool value) {
                              _toggleScheduled(index, value);
                            },
                          ),
                          onTap: () {
                            // Handle tap if necessary
                          },
                        ),
                        // Display the time range (start time - end time)
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: Text(
                                'Time: $startTimeFormatted - $endTimeFormatted',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                        // Add the delete button
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                _deleteData(index);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: _loadDataFromDownscreen,
                  child: Text(
                    'Add New Downtime Data',
                    style: TextStyle(
                      color: Colors.white, // Text color
                      fontSize: 16, // Font size
                      fontWeight: FontWeight.bold, // Font weight
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Colors.blue, // Text color on the button
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8), // Rounded corners
                    ),
                    elevation: 5, // Shadow effect
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
