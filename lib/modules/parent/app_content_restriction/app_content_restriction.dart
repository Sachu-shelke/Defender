import 'package:flutter/material.dart';

class AppContentRestriction extends StatefulWidget {
  const AppContentRestriction({super.key});

  @override
  State<AppContentRestriction> createState() => _AppContentRestrictionState();
}

class _AppContentRestrictionState extends State<AppContentRestriction> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App Content Restriction'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          height: MediaQuery.of(context).size.height*0.17,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(width: 2, color: Colors.black),
            color: Colors.grey[300],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: const Text('Open Newly Installed Apps'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min, // Fixes layout issue
                  children: const [
                    Text("Allowed", style: TextStyle(fontSize: 14)),
                    SizedBox(width: 5),
                    Icon(Icons.arrow_forward_ios_outlined, size: 15),
                  ],
                ),
              ),
              const Divider(height: 1, thickness: 1, color: Colors.black), // Cleaner divider
              const ListTile(
                title: Text('App Blocker'),
                trailing: Icon(Icons.arrow_forward_ios_outlined, size: 15),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
