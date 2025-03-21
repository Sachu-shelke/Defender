import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ModeScreen extends StatefulWidget {
  const ModeScreen({Key? key}) : super(key: key);

  @override
  _ModeScreenState createState() => _ModeScreenState();
}

class _ModeScreenState extends State<ModeScreen> {
  int? _selectedMode; // This will hold the selected mode

  @override
  void initState() {
    super.initState();
    _loadSelectedMode(); // Load the selected mode when the screen is initialized
  }

  // Method to load selected mode from SharedPreferences
  Future<void> _loadSelectedMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedMode = prefs.getString('selectedMode');
    setState(() {
      if (savedMode == null) {
        _selectedMode = 1; // Default to Unrestricted Mode if no mode is saved
      } else if (savedMode == 'Unrestricted Mode') {
        _selectedMode = 1;
      } else if (savedMode == 'Blacklist Mode') {
        _selectedMode = 2;
      } else if (savedMode == 'Whitelist Mode') {
        _selectedMode = 3;
      }
    });
  }

  // Method to save selected mode to SharedPreferences
  Future<void> _saveSelectedMode(String modeName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedMode', modeName); // Save the mode title
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(

        title: const Text('Select Mode'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // First ListTile (Unrestricted Mode)
            ListTile(
              title: const Text('Unrestricted Mode'),
              trailing: Radio<int>(
                value: 1,
                groupValue: _selectedMode,
                onChanged: (int? value) {
                  setState(() {
                    _selectedMode = value;
                    _saveSelectedMode('Unrestricted Mode'); // Save to SharedPreferences
                  });
                },
              ),
            ),
            const SizedBox(height: 10),

            // Second ListTile (Blacklist Mode)
            ListTile(
              title: const Text('Blacklist Mode'),
              subtitle: const Text('Block the incoming and outgoing calls from blacklisted numbers'),
              trailing: Radio<int>(
                value: 2,
                groupValue: _selectedMode,
                onChanged: (int? value) {
                  setState(() {
                    _selectedMode = value;
                    _saveSelectedMode('Blacklist Mode'); // Save to SharedPreferences
                  });
                },
              ),
            ),
            const SizedBox(height: 10),

            // Third ListTile (Whitelist Mode)
            ListTile(
              title: const Text('Whitelist Mode'),
              subtitle: const Text('Only allow the incoming and outgoing calls from emergency numbers and whitelisted'),
              trailing: Radio<int>(
                value: 3,
                groupValue: _selectedMode,
                onChanged: (int? value) {
                  setState(() {
                    _selectedMode = value;
                    _saveSelectedMode('Whitelist Mode'); // Save to SharedPreferences
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
