import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Downscreen extends StatefulWidget {
  @override
  _DownscreenState createState() => _DownscreenState();
}

class _DownscreenState extends State<Downscreen> {
  final TextEditingController _remarkController = TextEditingController();
  late SharedPreferences _prefs;
  bool _geofenceEnabled = true;
  List<String> _selectedDaysList = []; // Default: every day selected
  TimeOfDay _startTime = TimeOfDay(hour: 18, minute: 0);
  TimeOfDay _endTime = TimeOfDay(hour: 7, minute: 0);
  bool _isTimeCustomizable = false;

  @override
  void initState() {
    super.initState();
    _loadSavedData();
  }

  // Load saved data from SharedPreferences
  Future<void> _loadSavedData() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _remarkController.text = _prefs.getString('remark') ?? '';
      _geofenceEnabled = _prefs.getBool('geofenceEnabled') ?? true;
      _selectedDaysList = _prefs.getStringList('selectedDaysList') ?? ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday']; // Default to all days
      _startTime = TimeOfDay(
          hour: _prefs.getInt('startHour') ?? 18,
          minute: _prefs.getInt('startMinute') ?? 0);
      _endTime = TimeOfDay(
          hour: _prefs.getInt('endHour') ?? 7,
          minute: _prefs.getInt('endMinute') ?? 0);
      _isTimeCustomizable = _prefs.getBool('isTimeCustomizable') ?? false;
    });
  }

  // Save data to SharedPreferences
  Future<void> _saveData() async {
    await _prefs.setString('remark', _remarkController.text);
    await _prefs.setBool('geofenceEnabled', _geofenceEnabled);
    await _prefs.setStringList('selectedDaysList', _selectedDaysList);
    await _prefs.setInt('startHour', _startTime.hour);
    await _prefs.setInt('startMinute', _startTime.minute);
    await _prefs.setInt('endHour', _endTime.hour);
    await _prefs.setInt('endMinute', _endTime.minute);
    await _prefs.setBool('isTimeCustomizable', _isTimeCustomizable);

    // Return the saved data
    Map<String, dynamic> savedData = {
      'remark': _remarkController.text,
      'selectedDaysList': _selectedDaysList,
      'isScheduled': _geofenceEnabled,
    };

    Navigator.pop(context, savedData); // Pop and send data back
  }

  Future<void> _selectStartTime() async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _startTime,
    );
    if (picked != null && picked != _startTime) {
      setState(() {
        _startTime = picked;
      });
    }
  }

  Future<void> _selectEndTime() async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _endTime,
    );
    if (picked != null && picked != _endTime) {
      setState(() {
        _endTime = picked;
      });
    }
  }

  // Function to get the day name based on the index (0 = Sunday, 1 = Monday, etc.)
  String _getDayOfWeek(int index) {
    switch (index) {
      case 0:
        return 'Sunday';
      case 1:
        return 'Monday';
      case 2:
        return 'Tuesday';
      case 3:
        return 'Wednesday';
      case 4:
        return 'Thursday';
      case 5:
        return 'Friday';
      case 6:
        return 'Saturday';
      default:
        return '';
    }
  }

  // Show customize days sheet
  void _showCustomizeDaysSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return ListView(
              children: [
                for (int i = 0; i < 7; i++)
                  ListTile(
                    title: Text(_getDayOfWeek(i)),
                    trailing: Checkbox(
                      value: _selectedDaysList.contains(_getDayOfWeek(i)),
                      onChanged: (bool? value) {
                        setState(() {
                          if (value == true) {
                            _selectedDaysList.add(_getDayOfWeek(i));
                          } else {
                            _selectedDaysList.remove(_getDayOfWeek(i));
                          }
                        });
                      },
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); // Close the bottom sheet
                    },
                    child: Text('Close'),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Downtime'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Remark',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: _remarkController,
                      decoration: InputDecoration(
                        hintText: 'Enter remark...',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              // Customize Days Section
              Text(
                'Customize Days',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              ListTile(
                title: Text('Every day'),
                trailing: IconButton(
                  icon: Icon(
                    _selectedDaysList.length == 7
                        ? Icons.check_circle
                        : Icons.radio_button_unchecked,
                    color: _selectedDaysList.length == 7 ? Colors.blue : null,
                  ),
                  onPressed: () {
                    setState(() {
                      _selectedDaysList = List.generate(7, (index) => _getDayOfWeek(index));  // Select all days
                    });
                  },
                ),
              ),
              Divider(),
              ListTile(
                title: Text('Monday to Friday'),
                trailing: IconButton(
                  icon: Icon(
                    _selectedDaysList.length == 5
                        ? Icons.check_circle
                        : Icons.radio_button_unchecked,
                    color: _selectedDaysList.length == 5 ? Colors.blue : null,
                  ),
                  onPressed: () {
                    setState(() {
                      _selectedDaysList = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday'];
                    });
                  },
                ),
              ),
              Divider(),
              ListTile(
                title: Text('Saturday and Sunday'),
                trailing: IconButton(
                  icon: Icon(
                    _selectedDaysList.length == 2
                        ? Icons.check_circle
                        : Icons.radio_button_unchecked,
                    color: _selectedDaysList.length == 2 ? Colors.blue : null,
                  ),
                  onPressed: () {
                    setState(() {
                      _selectedDaysList = ['Saturday', 'Sunday'];
                    });
                  },
                ),
              ),
              Divider(),
              ListTile(
                title: Text('Customize'),
                trailing: IconButton(
                  icon: Icon(
                    _selectedDaysList.isNotEmpty && _selectedDaysList.length != 7
                        ? Icons.check_circle
                        : Icons.radio_button_unchecked,
                    color: _selectedDaysList.isNotEmpty && _selectedDaysList.length != 7
                        ? Colors.blue
                        : null,
                  ),
                  onPressed: () {
                    _showCustomizeDaysSheet(); // Show the bottom sheet for customizing
                  },
                ),
              ),
              Divider(),
              Text(
                'DownTime',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ListTile(
                title: Text('Start Time: ${_startTime.format(context)}'),
                trailing: IconButton(
                  icon: Icon(Icons.access_time),
                  onPressed: _selectStartTime,
                ),
              ),
              ListTile(
                title: Text('End Time: ${_endTime.format(context)}'),
                trailing: IconButton(
                  icon: Icon(Icons.access_time),
                  onPressed: _selectEndTime,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: _saveData,
                  child: Text('Save'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
