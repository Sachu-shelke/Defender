import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'add_keyword.dart';

class KeywordManagementScreen extends StatefulWidget {
  const KeywordManagementScreen({super.key});

  @override
  _KeywordManagementScreenState createState() =>
      _KeywordManagementScreenState();
}

class _KeywordManagementScreenState extends State<KeywordManagementScreen> {
  List<Map<String, dynamic>> keywords = []; // List to store added keywords with categories

  // Load the keywords from SharedPreferences
  Future<void> loadKeywords() async {
    final prefs = await SharedPreferences.getInstance();
    final savedKeywords = prefs.getStringList('keywords'); // Retrieve the list
    if (savedKeywords != null) {
      setState(() {
        keywords = savedKeywords.map((e) {
          var parts = e.split('::'); // Split the string by the separator
          return {
            'keyword': parts[0],
            'category': parts[1],
            'isEnabled': parts.length > 2 ? parts[2] == 'true' : true, // Default to true if not present
          }; // Map to a Map<String, dynamic>
        }).toList();
      });
    }
  }

  // Save the keywords to SharedPreferences
  Future<void> saveKeywords() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> savedKeywords = keywords.map((e) {
      return '${e['keyword']}::${e['category']}::${e['isEnabled']}'; // Include the 'isEnabled' value
    }).toList();
    await prefs.setStringList('keywords', savedKeywords); // Save the updated list to SharedPreferences
  }

  // Function to add a keyword to the list and save it
  void addKeyword(String keyword, String category) {
    setState(() {
      keywords.add({
        'keyword': keyword,
        'category': category,
        'isEnabled': true, // Default to true (enabled)
      });
    });
    saveKeywords(); // Save the updated list to SharedPreferences
  }

  // Function to remove a keyword
  void removeKeyword(int index) {
    setState(() {
      keywords.removeAt(index); // Remove keyword at the specified index
    });
    saveKeywords(); // Save the updated list to SharedPreferences
  }

  // Toggle the 'isEnabled' state of a keyword
  void toggleKeywordState(int index, bool value) {
    setState(() {
      keywords[index]['isEnabled'] = value;
    });
    saveKeywords(); // Save the updated list to SharedPreferences
  }

  // Navigate to AddKeywordScreen to add a new keyword
  void navigateToAddKeywordScreen() async {
    final keywordData = await Navigator.push<Map<String, String>>(
      context,
      MaterialPageRoute(builder: (context) => AddKeywordScreen()),
    );
    if (keywordData != null && keywordData.isNotEmpty) {
      addKeyword(keywordData['keyword']!, keywordData['category']!);
    }
  }

  @override
  void initState() {
    super.initState();
    loadKeywords(); // Load saved keywords when the screen is initialized
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Keyword Management', style: TextStyle(color: Colors.black)),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Center(
                child: Image.asset(
                  'assets/images/influencer.png',
                  width: 150,
                  height: 150,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: RichText(
                    textAlign: TextAlign.center,  // This will center the text
                    text: TextSpan(
                      style: TextStyle(fontSize: 16, color: Colors.black87),
                      children: <TextSpan>[
                        TextSpan(text: 'Add Keywords to receive '),
                        TextSpan(
                          text: 'alerts',
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
                        ),
                        TextSpan(text: ' when the words are detected'),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15),
              Expanded(
                child: ListView.builder(
                  itemCount: keywords.length,
                  itemBuilder: (context, index) {
                    return Card(
                      color: Colors.white,
                      margin: EdgeInsets.all(10),
                      child: ListTile(
                        title: Text(
                          keywords[index]['keyword']!,
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          'Category: ${keywords[index]['category']}',
                          style: TextStyle(color: Colors.grey),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Switch(
                              value: keywords[index]['isEnabled']!,
                              onChanged: (value) {
                                toggleKeywordState(index, value); // Toggle state of the keyword
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () => removeKeyword(index),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: ElevatedButton(
              onPressed: navigateToAddKeywordScreen,
              child: Text('Add Keywords', style: TextStyle(color: Colors.black)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
