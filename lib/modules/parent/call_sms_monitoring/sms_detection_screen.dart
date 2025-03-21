import 'package:flutter/material.dart';

import '../widget/nodata.dart';
class SmsDetectionScreen extends StatefulWidget {
  const SmsDetectionScreen({super.key});

  @override
  State<SmsDetectionScreen> createState() => _SmsDetectionScreenState();
}

class _SmsDetectionScreenState extends State<SmsDetectionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('SMS Detection Records'),
      ),
      body: NoDataScreen(
          message: 'No Detection History Yet'),
    );
  }
}
