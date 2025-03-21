import 'package:flutter/material.dart';

class PaymentFailedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Payment Failed")),
      body: Center(
        child: Text(
          "Your payment has failed. Please try again.",
          style: TextStyle(fontSize: 18, color: Colors.red),
        ),
      ),
    );
  }
}
