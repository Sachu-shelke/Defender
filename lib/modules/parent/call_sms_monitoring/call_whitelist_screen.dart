import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CallWhitelistScreen extends StatefulWidget {
  const CallWhitelistScreen({super.key});

  @override
  State<CallWhitelistScreen> createState() => _CallWhitelistScreenState();
}

class _CallWhitelistScreenState extends State<CallWhitelistScreen> {
  List<String> _whitelistedNumbers = []; // List to store whitelisted numbers

  @override
  void initState() {
    super.initState();
    _loadWhitelistedNumbers(); // Load whitelisted numbers from SharedPreferences
  }

  // Method to load whitelisted numbers from SharedPreferences
  Future<void> _loadWhitelistedNumbers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _whitelistedNumbers = prefs.getStringList('whitelistedNumbers') ?? [];
    });
  }

  // Method to save whitelisted numbers to SharedPreferences
  Future<void> _saveWhitelistedNumbers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('whitelistedNumbers', _whitelistedNumbers);
  }

  // Method to open a dialog to add a phone number to the whitelist
  Future<void> _showAddNumberDialog() async {
    final TextEditingController _numberController = TextEditingController();
    final TextEditingController _nameController = TextEditingController();

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // User must select an option
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Phone Number to Whitelist'),
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
                    _whitelistedNumbers.add(
                        '${_nameController.text}: ${_numberController.text}');
                  });
                  _saveWhitelistedNumbers(); // Save updated list
                  Navigator.of(context).pop(); // Close the dialog
                }
              },
            ),
          ],
        );
      },
    );
  }

  // Method to delete a whitelisted number
  Future<void> _deleteWhitelistedNumber(int index) async {
    setState(() {
      _whitelistedNumbers.removeAt(index); // Remove from the list
    });
    _saveWhitelistedNumbers(); // Save updated list
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Call Whitelist'),
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
                'Whitelisted phone numbers',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _whitelistedNumbers.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_whitelistedNumbers[index].split(':')[0]), // Contact name
                  subtitle: Text(_whitelistedNumbers[index].split(':')[1]), // Phone number
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _deleteWhitelistedNumber(index), // Delete on press
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
