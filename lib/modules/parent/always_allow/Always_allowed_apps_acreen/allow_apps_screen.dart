import 'package:defenders/modules/parent/website_restriction/website_restriction.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AllowAppsScreen extends StatefulWidget {
  const AllowAppsScreen({super.key});

  @override
  State<AllowAppsScreen> createState() => _AllowAppsScreenState();
}

class _AllowAppsScreenState extends State<AllowAppsScreen> {
  // Store selected apps here
  List<String> selectedApps = [];
  List<String> allApps = [
    'App 1',
    'App 2',
    'App 3',
    'App 4',
    'App 5',
    'App 6',
    'App 7',
    'App 8',
    'App 9',
    'App 10',
  ];

  // Store filtered apps based on search query
  List<String> filteredSelectedApps = [];
  List<String> filteredAllApps = [];

  TextEditingController searchController = TextEditingController();

  // Method to load selected apps from SharedPreferences
  void loadSelectedApps() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedApps = prefs.getStringList('selected_apps') ?? [];
      filteredSelectedApps = List.from(selectedApps);
      filteredAllApps = allApps.where((app) => !selectedApps.contains(app)).toList();
    });
  }

  // Method to toggle app selection (move between selected and unselected apps)
  void toggleAppSelection(String appName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      if (selectedApps.contains(appName)) {
        selectedApps.remove(appName); // Move the app from selected to unselected
      } else {
        selectedApps.add(appName); // Move the app from unselected to selected
      }

      // Update filtered lists after changing selection
      filteredSelectedApps = List.from(selectedApps);
      filteredAllApps = allApps.where((app) => !selectedApps.contains(app)).toList();
    });

    // Save the updated selected apps list to SharedPreferences
    await prefs.setStringList('selected_apps', selectedApps);
  }

  // Method to filter apps based on the search query
  void filterApps(String query) {
    setState(() {
      // Filter selected apps based on the search query
      filteredSelectedApps = selectedApps
          .where((app) => app.toLowerCase().contains(query.toLowerCase()))
          .toList();

      // Filter available apps based on the search query, excluding selected apps
      filteredAllApps = allApps
          .where((app) =>
      app.toLowerCase().contains(query.toLowerCase()) &&
          !selectedApps.contains(app)) // Exclude selected apps
          .toList();
    });
  }

  @override
  void initState() {
    super.initState();
    loadSelectedApps(); // Load selected apps on screen initialization
    searchController.addListener(() {
      filterApps(searchController.text); // Filter apps as the user types
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text('Always Allowed',
          style: TextStyle(fontSize: 19, fontWeight: FontWeight.w700),
        ),
        // actions: [
        //   IconButton(
        //     icon: Icon(Icons.check),
        //     onPressed: () {
        //       Navigator.pop(context); // Go back on pressing the "Done" button
        //     },
        //   ),
        // ],
      ),
      body: Column(
        children: [
          // Row with two Containers
          Container(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                // First Container for "Apps" with BorderRadius
                Container(
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Center(
                    child: Text(
                      'Apps',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                // Second Container for "Website" with BorderRadius
                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>WebsiteRestriction()));
                    },
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Center(
                      child: Text(
                        'Website',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search for an app...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15)
                ),
              ),
            ),
          ),
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text('Selected Apps',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: filteredSelectedApps.map((appName) {
                return ListTile(
                  leading: CircleAvatar(
                      backgroundColor: Colors.orangeAccent,
                      child: Icon(Icons.apps)),
                  title: Row(
                    children: [
                      SizedBox(width: 8),
                      Text(appName),
                    ],
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.cancel_rounded),
                    onPressed: () => toggleAppSelection(appName),
                  ),
                );
              }).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text('Available Apps',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: filteredAllApps.map((appName) {
                return ListTile(
                  leading: CircleAvatar(
                      backgroundColor: Colors.orangeAccent,
                      child: Icon(Icons.apps)),
                  title: Row(
                    children: [
                      SizedBox(width: 8),
                      Text(appName),
                    ],
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.add_circle_outlined),
                    onPressed: () => toggleAppSelection(appName),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
