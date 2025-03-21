import 'package:flutter/material.dart';

import '../widget/nodata.dart';
class BlockedCallsScreen extends StatefulWidget {
  const BlockedCallsScreen({super.key});

  @override
  State<BlockedCallsScreen> createState() => _BlockedCallsScreenState();
}

class _BlockedCallsScreenState extends State<BlockedCallsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Blocked Calls'),
      ),
      body: NoDataScreen(
          message: 'No Blocked Records'),
    );
  }
}
