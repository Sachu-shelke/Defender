import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CallBlacklistScreen extends StatefulWidget {
  const CallBlacklistScreen({super.key});

  @override
  State<CallBlacklistScreen> createState() => _CallBlacklistScreenState();
}

class _CallBlacklistScreenState extends State<CallBlacklistScreen> {
  List<String> _blacklistedNumbers = []; // List to store blacklisted numbers

  @override
  void initState() {
    super.initState();
    _loadBlacklistedNumbers(); // Load blacklisted numbers from SharedPreferences
  }

  // Method to load blacklisted numbers from SharedPreferences
  Future<void> _loadBlacklistedNumbers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _blacklistedNumbers = prefs.getStringList('blacklistedNumbers') ?? [];
    });
  }

  // Method to save blacklisted numbers to SharedPreferences
  Future<void> _saveBlacklistedNumbers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('blacklistedNumbers', _blacklistedNumbers);
  }

  // Method to open a dialog to add a phone number to the blacklist
  Future<void> _showAddNumberDialog() async {
    final TextEditingController _numberController = TextEditingController();
    final TextEditingController _nameController = TextEditingController();

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // User must select an option
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Phone Number to Blacklist'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(hintText: 'Enter contact name'),
              ),
              TextField(
                controller: _numberController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(hintText: 'Enter phone number'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: const Text('Add'),
              onPressed: () {
                if (_numberController.text.isNotEmpty) {
                  setState(() {
                    _blacklistedNumbers.add(
                        '${_nameController.text}: ${_numberController.text}');
                  });
                  _saveBlacklistedNumbers(); // Save updated list
                  Navigator.of(context).pop(); // Close the dialog
                }
              },
            ),
          ],
        );
      },
    );
  }

  // Method to delete a blacklisted number
  Future<void> _deleteBlacklistedNumber(int index) async {
    setState(() {
      _blacklistedNumbers.removeAt(index); // Remove from the list
    });
    _saveBlacklistedNumbers(); // Save updated list
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Call Blacklist'),
      ),
      body: Column(
        children: [
          Card(
            color: Colors.white70,
            child: ListTile(
              title: const Text('Add Phone Number'),
              trailing: const Icon(
                Icons.add_circle_outlined,
                color: Colors.blueAccent,
              ),
              onTap: _showAddNumberDialog,
            ),
          ),
          const SizedBox(height: 10),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Blacklisted phone numbers',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _blacklistedNumbers.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_blacklistedNumbers[index].split(':')[0]), // Contact name
                  subtitle: Text(_blacklistedNumbers[index].split(':')[1]), // Phone number
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _deleteBlacklistedNumber(index), // Delete on press
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
