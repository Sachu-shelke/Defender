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
  List<String> _selectedDaysList = [];
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
      _selectedDaysList = _prefs.getStringList('selectedDaysList') ?? [];
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
              RemarkField(remarkController: _remarkController),
              SizedBox(height: 20),
              CustomizeDaysSection(
                selectedDaysList: _selectedDaysList,
                onCustomizePressed: _showCustomizeDaysSheet,
                onSetEveryDay: () {
                  setState(() {
                    _selectedDaysList = List.generate(7, (index) => _getDayOfWeek(index)); // Select all days
                  });
                },
                onSetMonToFri: () {
                  setState(() {
                    _selectedDaysList = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday'];
                  });
                },
                onSetSatSun: () {
                  setState(() {
                    _selectedDaysList = ['Saturday', 'Sunday'];
                  });
                },
              ),
              Divider(),
              DownTimeSection(
                startTime: _startTime,
                endTime: _endTime,
                onSelectStartTime: _selectStartTime,
                onSelectEndTime: _selectEndTime,
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

class RemarkField extends StatelessWidget {
  final TextEditingController remarkController;

  RemarkField({required this.remarkController});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'Remark',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(width: 10),
        Expanded(
          child: TextField(
            controller: remarkController,
            decoration: InputDecoration(
              hintText: 'Enter remark...',
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }
}

class CustomizeDaysSection extends StatelessWidget {
  final List<String> selectedDaysList;
  final VoidCallback onCustomizePressed;
  final VoidCallback onSetEveryDay;
  final VoidCallback onSetMonToFri;
  final VoidCallback onSetSatSun;

  CustomizeDaysSection({
    required this.selectedDaysList,
    required this.onCustomizePressed,
    required this.onSetEveryDay,
    required this.onSetMonToFri,
    required this.onSetSatSun,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Customize Days',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        ListTile(
          title: Text('Every day'),
          trailing: IconButton(
            icon: Icon(
              selectedDaysList.length == 7
                  ? Icons.check_circle
                  : Icons.radio_button_unchecked,
              color: selectedDaysList.length == 7 ? Colors.blue : null,
            ),
            onPressed: onSetEveryDay,
          ),
        ),
        Divider(),
        ListTile(
          title: Text('Monday to Friday'),
          trailing: IconButton(
            icon: Icon(
              selectedDaysList.length == 5
                  ? Icons.check_circle
                  : Icons.radio_button_unchecked,
              color: selectedDaysList.length == 5 ? Colors.blue : null,
            ),
            onPressed: onSetMonToFri,
          ),
        ),
        Divider(),
        ListTile(
          title: Text('Saturday and Sunday'),
          trailing: IconButton(
            icon: Icon(
              selectedDaysList.length == 2
                  ? Icons.check_circle
                  : Icons.radio_button_unchecked,
              color: selectedDaysList.length == 2 ? Colors.blue : null,
            ),
            onPressed: onSetSatSun,
          ),
        ),
        Divider(),
        ListTile(
          title: Text('Customize'),
          trailing: IconButton(
            icon: Icon(
              selectedDaysList.isNotEmpty && selectedDaysList.length != 7
                  ? Icons.check_circle
                  : Icons.radio_button_unchecked,
              color: selectedDaysList.isNotEmpty && selectedDaysList.length != 7
                  ? Colors.blue
                  : null,
            ),
            onPressed: onCustomizePressed,
          ),
        ),
      ],
    );
  }
}

class DownTimeSection extends StatelessWidget {
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final VoidCallback onSelectStartTime;
  final VoidCallback onSelectEndTime;

  DownTimeSection({
    required this.startTime,
    required this.endTime,
    required this.onSelectStartTime,
    required this.onSelectEndTime,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'DownTime',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        ListTile(
          title: Text('Start Time: ${startTime.format(context)}'),
          trailing: IconButton(
            icon: Icon(Icons.access_time),
            onPressed: onSelectStartTime,
          ),
        ),
        ListTile(
          title: Text('End Time: ${endTime.format(context)}'),
          trailing: IconButton(
            icon: Icon(Icons.access_time),
            onPressed: onSelectEndTime,
          ),
        ),
      ],
    );
  }
}
