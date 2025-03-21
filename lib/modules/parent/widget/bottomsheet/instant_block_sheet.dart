import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomBottomSheet extends StatefulWidget {
  @override
  _CustomBottomSheetState createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  String? selectedOption; // The selected option that will be saved in SharedPreferences

  @override
  void initState() {
    super.initState();
    _loadSelectedOption(); // Load the selected option when the screen initializes
  }

  // Save the selected option to SharedPreferences
  Future<void> _saveSelectedOption(String option) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedOption', option);
  }

  // Load the selected option from SharedPreferences
  Future<void> _loadSelectedOption() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedOption = prefs.getString('selectedOption') ?? 'Until Manually Off'; // Default option
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      height: 400,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Instant Block',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          RichText(

            selectionColor: Colors.black,
              textAlign: TextAlign.center,
              text: TextSpan(
                style: TextStyle(color: Colors.black54),
            text: 'When turned on all apps except those always allowed will be instanly blocked until the set time ends or this feture is manually turned off.'

          )),
          SizedBox(height: 10),
          // List of options
          RadioListTile<String>(
            title: Text("1 Hour"),
            value: '1 Hour',
            groupValue: selectedOption,
            onChanged: (value) {
              setState(() {
                selectedOption = value;
              });
            },
          ),
          RadioListTile<String>(
            title: Text("2 Hours"),
            value: '2 Hours',
            groupValue: selectedOption,
            onChanged: (value) {
              setState(() {
                selectedOption = value;
              });
            },
          ),
          RadioListTile<String>(
            title: Text("Until Midnight"),
            value: 'Until Midnight',
            groupValue: selectedOption,
            onChanged: (value) {
              setState(() {
                selectedOption = value;
              });
            },
          ),
          RadioListTile<String>(
            title: Text("Until Manually Off"),
            value: 'Until Manually Off',
            groupValue: selectedOption,
            onChanged: (value) {
              setState(() {
                selectedOption = value;
              });
            },
          ),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(onPressed: (){
                Navigator.pop(context); // Close the bottom sheet without saving

              }, child: Text('Cancel'),),
              // OK Button
              ElevatedButton(
                onPressed: () {
                  if (selectedOption != null) {
                    _saveSelectedOption(selectedOption!); // Save the selected option
                    Navigator.pop(context); // Close the bottom sheet
                  }
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Colors.blue, // Text color
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15), // Padding for the button
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 5, // Elevation (shadow) effect
                ),
                child: Text(
                  'OK',
                  style: TextStyle(
                    fontSize: 16, // Text size
                    fontWeight: FontWeight.bold, // Font weight
                  ),
                ),
              ),

            ],
          ),
        ],
      ),
    );
  }
}
