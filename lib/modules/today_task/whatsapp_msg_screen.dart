import 'package:flutter/material.dart';
import 'package:defenders/widget/appbars/custom_app_bar.dart';

class WhatsappMarketingScreen extends StatefulWidget {
  const WhatsappMarketingScreen({super.key});

  @override
  State<WhatsappMarketingScreen> createState() =>
      _WhatsappMarketingScreenState();
}

class _WhatsappMarketingScreenState extends State<WhatsappMarketingScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(title: 'Whatsapp MSG'),
      body: Column(
        children: [],
      ),
    );
  }
}
