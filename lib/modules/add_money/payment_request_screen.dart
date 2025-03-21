import 'dart:io';
import 'package:defenders/modules/add_money/payment_failed_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // Importing ImagePicker
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import '../../utils/encrypted_api_path.dart';
import '../suceess/add_money_sucess_screen.dart'; // Import for MediaType

class PaymentRequestScreen extends StatefulWidget {
  final String amount; // Accepting amount as a parameter

  PaymentRequestScreen({required this.amount});

  @override
  _PaymentRequestScreenState createState() => _PaymentRequestScreenState();
}

class _PaymentRequestScreenState extends State<PaymentRequestScreen> {
  TextEditingController _utrController = TextEditingController();
  String? _selectedPaymentMode = 'UPI';
  File? _selectedImage;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _utrController.dispose(); // Dispose of the controller when the widget is disposed
    super.dispose();
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  // API call method to submit the payment request
  Future<void> _submitRequest() async {
    if (_utrController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter UTR No.')),
      );
      return;
    }
    if (_selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please upload deposit proof')),
      );
      return;
    }

    String baseurl = 'https://secure.mirror.org.in/api/';

    // Prepare the API endpoint URL
    String apiUrl = baseurl + EncryptedApiPath.addMoneyManual; // Replace with your API URL

    // Prepare request headers (if any)
    Map<String, String> headers = {
      'Authorization': 'authorizationToken', // Optional, if you need an auth token
    };

    // Prepare the image file to send in the request
    var request = http.MultipartRequest('POST', Uri.parse(apiUrl));
    request.headers.addAll(headers);

    // Add the fields to the request
    request.fields['amount'] = widget.amount;
    request.fields['utr_number'] = _utrController.text;
    request.fields['payment_mode'] = _selectedPaymentMode ?? 'UPI';

    // Add the image file to the request
    request.files.add(
      await http.MultipartFile.fromPath(
        'deposit_proof', // Field name expected by the API
        _selectedImage!.path,
        contentType: MediaType('image', 'jpeg'), // Assuming it's a jpeg image
      ),
    );

    // Send the request and handle the response
    try {
      var response = await request.send();

      // Convert the response stream to string and print it
      String responseBody = await response.stream.bytesToString();
      print('Response Body: $responseBody');
      print('Response Status Code: ${response.statusCode}');

      // Check if the status code is 200 (Success)
      if (response.statusCode == 200) {
        // Success
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AddMoneySucessScreen()),
        );
      } else {
        // Failure - handle the failed response
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(content: Text('Error: ${response.statusCode}. $responseBody')),
        // );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => PaymentFailedScreen()),
        );
      }
    } catch (e) {
      // Catch any exceptions and print them
      print('Error: $e');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => PaymentFailedScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Payment Request')),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            // Display the amount (disabled for editing)
            TextField(
              decoration: InputDecoration(
                labelText: 'Amount',
                border: OutlineInputBorder(),
              ),
              controller: TextEditingController(text: '₹ ${widget.amount}'),
              // enabled: false,
            ),
            SizedBox(height: 10),
            // UTR Number text field
            TextField(
              controller: _utrController,
              decoration: InputDecoration(
                labelText: 'UTR No.',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            // Dropdown to select payment mode
            DropdownButtonFormField<String>(
              value: _selectedPaymentMode,
              items: ['UPI', 'Bank Transfer'].map((String mode) {
                return DropdownMenuItem(
                  value: mode,
                  child: Text(mode),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedPaymentMode = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Select Payment Mode',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 30),
            Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Button to pick image (deposit proof)',style: TextStyle(
                      fontSize: 13.0, // Font size
                      fontWeight: FontWeight.bold, // Font weight
                    ),),
                    SizedBox(height: 10),
                    // Button to pick image (deposit proof)
                    ElevatedButton(
                      onPressed: _pickImage,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange, // Background color
                        padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0), // Padding around the button
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0), // Rounded corners
                        ),
                        textStyle: TextStyle(
                          fontSize: 16.0, // Font size
                          fontWeight: FontWeight.bold, // Font weight
                          color: Colors.white, // Text color
                        ),
                      ),
                      child: Text('Choose File'),
                    ),
                    // Display the selected image or show a placeholder
                    _selectedImage != null
                        ? Image.file(_selectedImage!, height: 100)
                        : Text('No file chosen'),
                    SizedBox(height: 20),
                    // Button to submit the request
                    ElevatedButton(
                      onPressed: _submitRequest,
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white, backgroundColor: Colors.green, // Text color
                        padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0), // Padding
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0), // Rounded corners
                        ),
                        textStyle: TextStyle(
                          fontSize: 18.0, // Font size
                          fontWeight: FontWeight.bold, // Font weight
                        ),
                      ),
                      child: Text('Submit Request'),
                    )

                  ],
                ),
              ],
            ),
            // Button to pick image (deposit proof)

          ],
        ),
      ),
    );
  }
}

// Success Screen
class SuccessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Success')),
      body: Center(
        child: Text(
          'Payment request submitted successfully!',
          style: TextStyle(fontSize: 24, color: Colors.green),
        ),
      ),
    );
  }
}

// Failed Screen
class FailedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Failed')),
      body: Center(
        child: Text(
          'Failed to submit payment request. Please try again.',
          style: TextStyle(fontSize: 24, color: Colors.red),
        ),
      ),
    );
  }
}
