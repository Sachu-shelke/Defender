import 'package:flutter/material.dart';
import 'package:defenders/modules/vendor/vendor_screen.dart';

class LiveTrainingScreen extends StatefulWidget {
  const LiveTrainingScreen({super.key});

  @override
  State<LiveTrainingScreen> createState() => _LiveTrainingScreenState();
}

class _LiveTrainingScreenState extends State<LiveTrainingScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: VendorScreen(
        url: 'https://zoom.mirror.org.in/',
      ),
    );
  }
}
