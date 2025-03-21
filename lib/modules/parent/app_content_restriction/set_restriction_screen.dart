
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SetRestrictionScreen extends StatefulWidget {
  final Function(String) onOptionSelected;

  const SetRestrictionScreen({super.key, required this.onOptionSelected});

  @override
  _SetRestrictionScreenState createState() => _SetRestrictionScreenState();
}

class _SetRestrictionScreenState extends State<SetRestrictionScreen> {
  String selectedOption = 'Allowed';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Set Restriction'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          color: Colors.white,
          elevation: 5,
          child: Container(
            width: double.infinity, // Makes the card take full width
            height: MediaQuery.of(context).size.height * 0.3, // 30% of the screen height
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                RadioListTile<String>(
                  title: const Text('Allowed'),
                  value: 'Allowed',
                  groupValue: selectedOption,
                  onChanged: (String? value) {
                    setState(() {
                      selectedOption = value!;
                    });
                  },
                ),
                RadioListTile<String>(
                  title: const Text('Don\'t Allowed'),
                  value: 'Don\'t Allowed',
                  groupValue: selectedOption,
                  onChanged: (String? value) {
                    setState(() {
                      selectedOption = value!;
                    });
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    widget.onOptionSelected(selectedOption);
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Colors.blue, // Text color
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12), // Padding
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // Rounded corners
                    ),
                    elevation: 5, // Shadow effect
                  ),
                  child: const Text(
                    'Save Option',
                    style: TextStyle(
                      fontSize: 16, // Font size
                      fontWeight: FontWeight.bold, // Font weight
                    ),
                  ),
                )

              ],
            ),
          ),
        ),
      ),

    );
  }
}
