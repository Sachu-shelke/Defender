import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widget/appwideget.dart';  // Assuming you have CustomizeDaysSection imported

class AddLimitScreen extends StatefulWidget {
  @override
  _AddLimitScreenState createState() => _AddLimitScreenState();
}

class _AddLimitScreenState extends State<AddLimitScreen> {
  String selectedLimitType = 'Time Limits'; // Default option
  List<String> selectedDays = []; // List for multiple days
  TimeOfDay startTime = TimeOfDay(hour: 6, minute: 0);
  TimeOfDay endTime = TimeOfDay(hour: 18, minute: 0);
  bool geofenceEnabled = false;

  final List<String> limitTypes = ['Time Limits', 'Downtime'];
  List<String> allDays = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];

  // Load preferences from shared preferences
  Future<void> _loadPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      selectedLimitType = prefs.getString('selectedLimitType') ?? 'Time Limits';
      selectedDays = prefs.getStringList('selectedDays') ?? [];
      startTime = TimeOfDay(
        hour: prefs.getInt('startHour') ?? 6,
        minute: prefs.getInt('startMinute') ?? 0,
      );
      endTime = TimeOfDay(
        hour: prefs.getInt('endHour') ?? 18,
        minute: prefs.getInt('endMinute') ?? 0,
      );
      geofenceEnabled = prefs.getBool('geofenceEnabled') ?? false;
    });
  }

  // Save preferences to shared preferences
  Future<void> _savePreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('selectedLimitType', selectedLimitType);
    prefs.setStringList('selectedDays', selectedDays);
    prefs.setInt('startHour', startTime.hour);
    prefs.setInt('startMinute', startTime.minute);
    prefs.setInt('endHour', endTime.hour);
    prefs.setInt('endMinute', endTime.minute);
    prefs.setBool('geofenceEnabled', geofenceEnabled);
  }

  @override
  void initState() {
    super.initState();
    _loadPreferences();  // Load preferences when the screen initializes
  }

  Future<void> _selectTime(BuildContext context, bool isStartTime) async {
    TimeOfDay selectedTime = isStartTime ? startTime : endTime;
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        if (isStartTime) {
          startTime = picked;
        } else {
          endTime = picked;
        }
      });
    }
  }

  // Show the dialog to select multiple days
  void _showSelectDaysDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Select Days'),
          content: SingleChildScrollView(
            child: Column(
              children: allDays.map((day) {
                return CheckboxListTile(
                  title: Text(day),
                  value: selectedDays.contains(day),
                  onChanged: (bool? selected) {
                    setState(() {
                      if (selected != null && selected) {
                        selectedDays.add(day);
                      } else {
                        selectedDays.remove(day);
                      }
                    });
                  },
                );
              }).toList(),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Done'),
              onPressed: () {
                setState(() {
                  // Update selectedDays
                  // if (selectedDays.isEmpty) {
                  //   selectedDays = ['    '];
                  // }
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // Callback for CustomizeDaysSection
  void _onCustomizePressed() {
    _showSelectDaysDialog();
  }

  // Callback for Every day selection
  void _onSetEveryDay() {
    setState(() {
      selectedDays = allDays;
    });
  }

  // Callback for Monday to Friday selection
  void _onSetMonToFri() {
    setState(() {
      selectedDays = allDays.sublist(1, 6); // Monday to Friday
    });
  }

  // Callback for Saturday and Sunday selection
  void _onSetSatSun() {
    setState(() {
      selectedDays = [allDays[0], allDays[6]]; // Saturday and Sunday
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Add Limits"),
      ),
      body: Stack(  // Use Stack to overlay the button at the bottom
        children: [
          SingleChildScrollView(  // Wrap the whole body in SingleChildScrollView
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Limit Type Section
                Text("Limit Type", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ListTile(
                  title: Text("Time Limits"),
                  subtitle: Text("Set a total usage limit. Once reached, access to the app requires your permission."),
                  trailing: Radio<String>(
                    value: 'Time Limits',
                    groupValue: selectedLimitType,
                    onChanged: (value) {
                      setState(() {
                        selectedLimitType = value!;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: Text("Downtime"),
                  subtitle: Text("Schedule a downtime during which access to the app requires your permission."),
                  trailing: Radio<String>(
                    value: 'Downtime',
                    groupValue: selectedLimitType,
                    onChanged: (value) {
                      setState(() {
                        selectedLimitType = value!;
                      });
                    },
                  ),
                ),
                Divider(),

                // Customize Days Section
                // Text("Customize Days", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                CustomizeDaysSection(
                  selectedDaysList: selectedDays,
                  onCustomizePressed: _onCustomizePressed,
                  onSetEveryDay: _onSetEveryDay,
                  onSetMonToFri: _onSetMonToFri,
                  onSetSatSun: _onSetSatSun,
                ),
                Divider(),

                // Time Section
                Text("Select Time", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Start Time", style: TextStyle(fontSize: 16)),
                    TextButton(
                      onPressed: () => _selectTime(context, true),
                      child: Text("${startTime.format(context)}", style: TextStyle(fontSize: 16)),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("End Time", style: TextStyle(fontSize: 16)),
                    TextButton(
                      onPressed: () => _selectTime(context, false),
                      child: Text("${endTime.format(context)}", style: TextStyle(fontSize: 16)),
                    ),
                  ],
                ),
                Divider(),

                // Geofence Area Section
                SwitchListTile(
                  title: Text("Geofence Area"),
                  subtitle: Text("Apply the limit in a specific area."),
                  value: geofenceEnabled,
                  onChanged: (value) {
                    setState(() {
                      geofenceEnabled = value;
                    });
                  },
                ),
                SizedBox(height: 50),
              ],
            ),
          ),
          Positioned(
            bottom: 20,  // Position the button 20 pixels from the bottom
            left: 16,
            right: 16,
            child: ElevatedButton(
              onPressed: () {
                _savePreferences();  // Save preferences on button click

                // Pass the data back to the AppLimitsScreen
                Navigator.pop(context, {
                  'selectedLimitType': selectedLimitType,
                  'selectedDays': selectedDays.join(', '),
                  'startTime': startTime.format(context),
                  'endTime': endTime.format(context),
                  'geofenceEnabled': geofenceEnabled,
                });
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
                "Save",
                style: TextStyle(
                  fontSize: 18, // Font size
                  fontWeight: FontWeight.bold, // Text weight
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
