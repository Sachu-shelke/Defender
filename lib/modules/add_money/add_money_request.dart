import 'package:defenders/modules/add_money/payment_request_screen.dart';
import 'package:flutter/material.dart';

class AddMoneyRequestScreen extends StatefulWidget {
  final int amount; // Accept the amount as a parameter

  AddMoneyRequestScreen({required this.amount}); // Constructor to receive the amount

  @override
  _AddMoneyRequestScreenState createState() => _AddMoneyRequestScreenState();
}

class _AddMoneyRequestScreenState extends State<AddMoneyRequestScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Money Request'),
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.orange),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Image.asset(
                'assets/images/upi_qr1.png', // Replace with your QR code image
                height: 200,
                width: 200,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'mirrorhub@hdfcbank',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            Divider(height: 30.0, thickness: 2.0),
            AccountDetails(),
            SizedBox(height: 20.0),
            Text(
              'Amount: ₹${widget.amount}', // Display the passed amount
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Pass the amount as a String to PaymentRequestScreen
                Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentRequestScreen(amount: widget.amount.toString(),)));
                print("Add Money Request with ₹${widget.amount}");
                // You can add more logic here for submitting the money request
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
              child: Text('Add Money Request'),
            ),
            SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: () {
                // Handle checking the add money request status
                print("Checking Add Money Request Status for ₹${widget.amount}");
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              child: Text('Add Money Request Status'),
            ),
          ],
        ),
      ),
    );
  }
}

class AccountDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        accountDetailItem('BANK NAME', 'IndusInd Bank'),
        accountDetailItem('ACCOUNT TYPE', 'Saving Account'),
        accountDetailItem('ACCOUNT HOLDER', 'Mirrorinfo tech Pvt Ltd'),
        accountDetailItem('ACCOUNT NUMBER', '259112421742'),
        accountDetailItem('IFSC CODE', 'INDB0000173'),
      ],
    );
  }

  Widget accountDetailItem(String title, String value, {bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(color: Colors.grey, fontSize: 16.0),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: bold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
