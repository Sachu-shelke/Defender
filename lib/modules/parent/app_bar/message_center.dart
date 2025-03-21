import 'package:defenders/constants/app_const_assets.dart';
import 'package:flutter/material.dart';

import '../widget/nodata.dart';

class MessageCenterScreen extends StatefulWidget {
  @override
  _MessageCenterScreenState createState() => _MessageCenterScreenState();
}

class _MessageCenterScreenState extends State<MessageCenterScreen> {
  // Sample data for messages
  List<Map<String, dynamic>> messages = [
    {"title": "New Update Available!", "date": "2025-02-24", "isRead": false, "content": "Click here to update your app.", "category": "System"},
    {"title": "Welcome to Defender!", "date": "2025-02-23", "isRead": true, "content": "We're glad to have you on board.", "category": "Alerts"},
    {"title": "New Request for Permission", "date": "2025-02-22", "isRead": false, "content": "Please grant permission to access location.", "category": "Requests"},
    {"title": "Reminder", "date": "2025-02-21", "isRead": true, "content": "Don't forget to check your settings.", "category": "Alerts"},
    {"title": "System Update Completed", "date": "2025-02-20", "isRead": true, "content": "The latest system update has been successfully installed.", "category": "System"},
  ];

  // Function to toggle the 'isRead' status
  void _toggleReadStatus(int index, List<Map<String, dynamic>> messagesList) {
    setState(() {
      messages[messages.indexOf(messagesList[index])]['isRead'] = !messages[messages.indexOf(messagesList[index])]['isRead'];
    });
  }

  // Function to delete a message
  void _deleteMessage(int index, List<Map<String, dynamic>> messagesList) {
    setState(() {
      messages.remove(messagesList[index]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // 3 tabs
      child: Scaffold(
        appBar: AppBar(
          title: Text("Message Center"),
          backgroundColor: Colors.blue,
          bottom: TabBar(
            tabs: [
              Tab(text: 'Alerts'),
              Tab(text: 'Requests'),
              Tab(text: 'System'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Alerts Tab
            _buildMessageList(
                messages.where((message) => message['category'] == 'Alerts').toList(),
                "No alerts available"),

            // Requests Tab
            _buildMessageList(
                messages.where((message) => message['category'] == 'Requests').toList(),
                "No requests available"),

            // System Tab
            _buildMessageList(
                messages.where((message) => message['category'] == 'System').toList(),
                "No system messages available"),
          ],
        ),
      ),
    );
  }

  // Reusable method to build a list of messages or show NoDataScreen
  Widget _buildMessageList(List<Map<String, dynamic>> messagesList, String noDataMessage) {
    if (messagesList.isEmpty) {
      return NoDataScreen(message: noDataMessage);
    }

    return ListView.builder(
      itemCount: messagesList.length,
      itemBuilder: (context, index) {
        return Card(
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: ListTile(
            contentPadding: EdgeInsets.all(10),
            leading: Icon(
              messagesList[index]['isRead'] ? Icons.mark_email_read : Icons.mark_email_unread,
              color: messagesList[index]['isRead'] ? Colors.green : Colors.red,
            ),
            title: Text(
              messagesList[index]['title'],
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(messagesList[index]['date']),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => _deleteMessage(index, messagesList),
              color: Colors.red,
            ),
            onTap: () {
              _toggleReadStatus(index, messagesList);
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text(messagesList[index]['title']),
                    content: Text(messagesList[index]['content']),
                    actions: <Widget>[
                      TextButton(
                        child: Text("Close"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}


