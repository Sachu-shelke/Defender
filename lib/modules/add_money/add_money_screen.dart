import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';  // Import the url_launcher package
import 'add_money_request.dart';

class AddMoneyScreen extends StatefulWidget {
  @override
  _AddMoneyScreenState createState() => _AddMoneyScreenState();
}

class _AddMoneyScreenState extends State<AddMoneyScreen> {
  TextEditingController _amountController = TextEditingController();
  final List<int> _recommendedAmounts = [500, 1000, 2500, 5000];

  void _onAmountSelected(int amount) {
    setState(() {
      _amountController.text = amount.toString();
    });
  }

  // Save the selected amount to SharedPreferences
  Future<void> _storeAmount(int amount) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('selected_amount', amount);
  }

  void _onProceed() async {
    if (_amountController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enter an amount")),
      );
      return;
    }

    int? enteredAmount = int.tryParse(_amountController.text);
    if (enteredAmount == null || enteredAmount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Enter a valid amount")),
      );
      return;
    }

    // Store the selected amount in SharedPreferences
    await _storeAmount(enteredAmount);

    // Navigate to the Add Money Request Screen and pass the amount
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddMoneyRequestScreen(amount: enteredAmount),
      ),
    );
  }

  // Launch UPI Payment
  Future<void> _launchUPIPayment(double amount) async {
    String upiId = 'sachinshelke930791@okicici';
    String payeeName = 'ReceiverName';
    String merchantCode = '12345';
    String transactionId = 'sachin';
    String referenceId = 'sach';
    String transactionNote = 'Thanks you';
    String currency = 'INR';

    // Format the amount to ensure it's in correct decimal format
    String formattedAmount = amount.toStringAsFixed(2);

    String upiUri = generateUpiUri(
      upiId: upiId,
      payeeName: payeeName,
      merchantCode: merchantCode,
      transactionId: transactionId,
      referenceId: referenceId,
      transactionNote: transactionNote,
      amount: formattedAmount,  // Use formatted amount
      currency: currency,
    );

    // Check if the UPI app can be launched
    if (await canLaunch(upiUri)) {
      await launch(upiUri);
    } else {
      // Handle the case if UPI app can't be launched (e.g., UPI app not installed)
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Could not launch UPI payment app")));
    }
  }

  // UPI URI Generation
  String generateUpiUri({
    required String upiId,
    required String payeeName,
    required String merchantCode,
    required String transactionId,
    required String referenceId,
    required String transactionNote,
    required String amount,
    required String currency,
  }) {
    // Construct the UPI URI with properly formatted amount
    return 'upi://pay?pa=$upiId&pn=$payeeName&mc=$merchantCode&tid=$transactionId&tr=$referenceId&tn=$transactionNote&am=$amount&cu=$currency';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Add Money", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.lightBlue,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                  boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 5)],
                ),
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Topup Wallet", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    TextField(
                      controller: _amountController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: "Enter Amount",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text("Recommended", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: _recommendedAmounts.map((amount) {
                        return Expanded(
                          child: ElevatedButton(
                            onPressed: () => _onAmountSelected(amount),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              side: BorderSide(color: Colors.lightBlue),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                            child: Text("₹$amount", style: TextStyle(color: Colors.green, fontSize: 10, fontWeight: FontWeight.bold)),
                          ),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _onProceed,
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          backgroundColor: Colors.blue,
                        ),
                        child: Text("Proceed", style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Card(
                color: Colors.blueAccent,
                child: GestureDetector(
                  onTap: () {
                    double amount = double.tryParse(_amountController.text) ?? 500.00;
                    _launchUPIPayment(amount); // Pass the selected amount
                  },
                  child: Container(
                    height: 50,
                    width: 130,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset('assets/icons/upi.png', height: 30, width: 50),
                        Text(
                          'UPI',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
