import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';  // Import this to use jsonEncode and jsonDecode

class AddKeywordScreen extends StatefulWidget {
  @override
  _AddKeywordScreenState createState() => _AddKeywordScreenState();
}

class _AddKeywordScreenState extends State<AddKeywordScreen> {
  final TextEditingController _keywordController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();

  // List to hold the added keywords and categories
  List<Map<String, String>> keywordList = [];

  @override
  void initState() {
    super.initState();
    _loadKeywords();
  }

  // Load keywords from SharedPreferences
  Future<void> _loadKeywords() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? savedKeywords = prefs.getStringList('keywords');
    if (savedKeywords != null) {
      setState(() {
        keywordList = savedKeywords
            .map((e) => Map<String, String>.from(jsonDecode(e)))  // Decode JSON strings back into maps
            .toList();
      });
    }
  }

  // Save the keywords to SharedPreferences
  Future<void> _saveKeywords() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> encodedKeywords = keywordList
        .map((e) => jsonEncode(e))
        .toList();
    await prefs.setStringList('keywords', encodedKeywords);  // Save the list of JSON strings
  }

  // Function to save keyword to the list
  void _saveKeyword(BuildContext context) {
    String keyword = _keywordController.text.trim();
    String category = _categoryController.text.trim();
    if (keyword.isNotEmpty && category.isNotEmpty) {
      setState(() {
        keywordList.add({'keyword': keyword, 'category': category});
      });
      _saveKeywords();  // Save the updated list to SharedPreferences
      Navigator.pop(context);  // Close the dialog
      _keywordController.clear();
      _categoryController.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter both keyword and category')),
      );
    }
  }

  // Function to remove keyword from the list
  void _removeKeyword(int index) {
    setState(() {
      keywordList.removeAt(index);
    });
    _saveKeywords();  // Save the updated list to SharedPreferences
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Keyword Management"),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text('Keyword Management', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          Card(
            color: Colors.white70,
            elevation: 10,
            child: ListTile(
              trailing: Icon(Icons.add_circle_outlined,color: Colors.blueAccent,),
              title: Text('Enter Keyword'),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      shadowColor: Colors.blueAccent,
                      elevation: 15,
                      backgroundColor: Colors.white,
                      title: Text("Add Keyword"),
                      content: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextField(
                              controller: _keywordController,
                              decoration: InputDecoration(labelText: 'Enter Keyword'),
                            ),
                            TextField(
                              controller: _categoryController,
                              decoration: InputDecoration(labelText: 'Enter Category'),
                            ),
                          ],
                        ),
                      ),
                      actions: [
                        ElevatedButton(
                          onPressed: () => _saveKeyword(context),
                          child: Text(
                            'Save',
                            style: TextStyle(
                              color: Colors.white,         // Text color
                              fontSize: 16,                // Font size
                              fontWeight: FontWeight.bold, // Font weight
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white, backgroundColor: Colors.blue,      // Text color when button is pressed
                            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),  // Padding inside button
                            shape: RoundedRectangleBorder( // Rounded corners
                              borderRadius: BorderRadius.circular(8),
                            ),
                            elevation: 5,                 // Shadow elevation
                          ),
                        ),

                        TextButton(
                          onPressed: () {
                            Navigator.pop(context); // Close the dialog without saving
                          },
                          child: Text('Cancel'),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: keywordList.length,
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.white,
                  margin: EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(keywordList[index]['keyword']!),
                    subtitle: Text('Category: ${keywordList[index]['category']}'),
                    leading: Icon(Icons.keyboard),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _removeKeyword(index),
                    ),
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
