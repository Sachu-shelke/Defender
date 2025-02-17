import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:math';

import '../../main_home/widget/mainscreen.dart';

class BindingScreen extends StatefulWidget {
  @override
  _BindingScreenState createState() => _BindingScreenState();
}

class _BindingScreenState extends State<BindingScreen> {
  late String qrData;
  late String bindingCode;

  // Generate a random binding code
  String _generateBindingCode() {
    Random random = Random();
    return "${random.nextInt(999)} ${random.nextInt(999)} ${random.nextInt(999)}";
  }

  String _generateQrData() {
    Random random = Random();
    return "https://kids.Defender.at/${random.nextInt(999999999)}";
  }

  @override
  void initState() {
    super.initState();
    qrData = _generateQrData();
    bindingCode = _generateBindingCode();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Binding the Child's Device"),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/influencer.png',
              height: 150,
            ),
            SizedBox(height: 10),

            const Text(
              "Binding the Child's Device",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),

            const Text(
              "Install Defender Kids on your child's device",
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),

            // QrImage(
            //   data: qrData,
            //   version: QrVersions.auto,
            //   size: 200,
            // ),
            SizedBox(height: 10),

            // QR link display
            Text(
              qrData,
              style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
            ),
            SizedBox(height: 20),

            // Code display
            Text(
              "Open Defender Kids and enter the code below",
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),

            Text(
              bindingCode,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              "The code is always valid",
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            SizedBox(height: 20),

            // Button to generate new QR code and binding code
            TextButton(
              onPressed: () {
                setState(() {
                  qrData = _generateQrData();
                  bindingCode = _generateBindingCode();
                });
              },
              child: Text("Generate New Code", style: TextStyle(color: Colors.blue)),
            ),
            SizedBox(height: 10),
            TextButton(
              onPressed: () {
                Navigator.push(context,
                MaterialPageRoute(
                  builder: (context) => Mainscreen(),
                ));
              }, child: Text('Home'),

            ),

            Spacer(),

            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Not now", style: TextStyle(color: Colors.blue)),
            ),
          ],
        ),
      ),
    );
  }
}
