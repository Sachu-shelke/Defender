import 'package:flutter/material.dart';

import '../call_sms_monitoring/keybord_management_screen.dart';
import 'app_detection.dart';

class ScrollableButtonScreen extends StatefulWidget {
  const ScrollableButtonScreen({super.key});

  @override
  State<ScrollableButtonScreen> createState() => _ScrollableButtonScreenState();
}

class _ScrollableButtonScreenState extends State<ScrollableButtonScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _currentContent = 'Select an option to see content below';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _changeContent(String content) {
    setState(() {
      _currentContent = content;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Social Content Detection'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Container(
            width: double.infinity,
            child: TabBar(
              controller: _tabController,
              indicator: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              indicatorWeight: 6.0,
              labelStyle: TextStyle(
                // fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
                fontSize: 18,
              ),
              tabs: const [
                Tab(
                  text: 'Keyword Detection',
                ),
                Tab(
                  text: 'Activity',
                ),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Tab content area
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  // First Tab Content: Keyword Detection
                  Container(
                   child: Column(
                     children: [
                       RichText(
                         text: TextSpan(
                           text: 'Manage the apps and keywords to be monitored for sensitive content. ',
                           style: TextStyle(
                             fontSize: 14,
                             color: Colors.black,
                           ),
                           children: <TextSpan>[
                             TextSpan(
                               text: 'You will receive alerts if any is detected.',
                               style: TextStyle(
                                 fontSize: 14,
                                 color: Colors.black,
                               ),
                             ),
                           ],
                         ),
                       ),
                       SizedBox(
                         height: 10,
                       ),
                       Card(
                         color: Colors.white,
                         elevation: 10,
                         child: Column(
                           children: [
                             ListTile(
                               leading: Icon(Icons.add_box_outlined),
                               title: Text('App Detection Management'),
                               trailing: Icon(Icons.arrow_forward_ios),
                               onTap: (){
                                 Navigator.push(context, MaterialPageRoute(builder: (context)=>AppDetectionScreen()));
                               },
                             ),
                             ListTile(
                               leading: Icon(Icons.camera_outlined),
                               title: Text('Keyword Management'),
                               trailing: Icon(Icons.arrow_forward_ios),
                               onTap: (){
                                 Navigator.push(context, MaterialPageRoute(builder: (context)=>KeywordManagementScreen()));

                               },
                             ),
                           ],
                         ),
                       ),
                       Row(
                         children: [
                           Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: Text('Recent Detection Record',style: TextStyle(color: Colors.grey),),
                           ),
                         ],
                       )
                     ],
                   ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white70,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Today',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
