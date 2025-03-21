import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../config/manager/global_singleton.dart';
import '../main_home/main_home_screen.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  final InAppPurchase _iap = InAppPurchase.instance;
  final String _subscriptionId = "defender_plan";
  bool _available = false;
  bool _isSubscribed = false;
  final String _apiUrl = "https://your-api.com/subscription"; // Change this

  @override
  void initState() {
    super.initState();
    _checkSubscriptionStatus();
    _initializeIAP();
  }

  Future<void> _checkSubscriptionStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.reload();
    bool isSubscribed = prefs.getBool('isSubscribed') ?? false;
    setState(() => _isSubscribed = isSubscribed);
  }

  Future<void> _initializeIAP() async {
    final bool available = await _iap.isAvailable();
    setState(() => _available = available);

    if (_available) {
      _iap.purchaseStream.listen((List<PurchaseDetails> purchases) async {
        for (var purchase in purchases) {
          if (purchase.status == PurchaseStatus.purchased) {
            await _verifyPurchase(purchase);
          } else if (purchase.status == PurchaseStatus.error) {
            print("❌ Purchase failed");
          }
        }
      }, onError: (error) {
        print("❌ IAP Error: $error");
      });
    }
  }

  Future<void> _verifyPurchase(PurchaseDetails purchase) async {
    if (purchase.status == PurchaseStatus.purchased) {
      await _updateSubscriptionStatus(true);
      Future.delayed(Duration.zero, _navigateToHome);
    }
  }

  Future<void> _updateSubscriptionStatus(bool status) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isSubscribed', status);
    setState(() => _isSubscribed = status);
    await _sendSubscriptionToAPI(status);
  }

  String? getUserId() {
    return GlobalSingleton.loginInfo?.data?.mobile?.toString();
  }

  Future<void> _sendSubscriptionToAPI(bool status) async {
    final Map<String, dynamic> data = {
      "user_id": getUserId(),
      "isSubscribed": status
    };

    try {
      final response = await http.post(
        Uri.parse(_apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        print(" Subscription updated successfully on server");
      } else {
        print(" Failed to update subscription on server: ${response.body}");
      }
    } catch (e) {
      print(" Error sending subscription data: $e");
    }
  }

  void _navigateToHome() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => MainHomeScreen()),
    );
  }

  Future<void> _buySubscription() async {
    if (!_available) {
      print(" IAP not available");
      return;
    }

    final ProductDetailsResponse response =
    await _iap.queryProductDetails({_subscriptionId});
    if (response.productDetails.isEmpty) {
      print(" Subscription not found");
      return;
    }

    final PurchaseParam purchaseParam =
    PurchaseParam(productDetails: response.productDetails.first);
    _iap.buyNonConsumable(purchaseParam: purchaseParam);
  }

  Future<void> _toggleSubscriptionForTesting() async {
    bool newStatus = !_isSubscribed;
    await _updateSubscriptionStatus(newStatus);

    if (newStatus) {
      Future.delayed(Duration.zero, _navigateToHome);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: const Text("Subscription Options",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/background.jpg"), // Add your image
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            color: Colors.black.withOpacity(0.4), // Dark overlay
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 100),
                Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  color: Colors.white,
                  child: const ListTile(
                    leading: Icon(Icons.shopping_bag_rounded, size: 40, color: Colors.orange),
                    title: Text("Defender",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black)),
                    subtitle: Text("Weekly Subscription",
                        style: TextStyle(fontSize: 16, color: Colors.black54)),
                  ),
                ),
                const SizedBox(height: 20),
                const Text("Starting today",
                    style: TextStyle(fontSize: 16, color: Colors.white70)),
                const SizedBox(height: 5),
                const Text("₹4.00/weekly",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
                const SizedBox(height: 20),
                const Text(
                  "- You've already participated in the free trial.\n"
                      "- Cancel at any time in Subscriptions on Google Play.\n"
                      "- Play Pass will automatically be shared with your family members.\n"
                      "- Your subscription will renew automatically unless canceled before the next billing date.\n"
                      "- No refunds for partial subscription periods.\n"
                      "- Payment will be charged to your Google Play account upon confirmation of purchase.\n"
                      "- Offers and prices may vary depending on your region and currency.",
                  style: TextStyle(fontSize: 14, color: Colors.white70),
                ),
                const Spacer(),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: _available ? _buySubscription : null,
                  child: const Text("Subscribe via Google Play",
                      style: TextStyle(fontSize: 18, color: Colors.white)),
                ),
                const SizedBox(height: 15),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isSubscribed ? Colors.red : Colors.green,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: _toggleSubscriptionForTesting,
                  child: Text(
                    _isSubscribed
                        ? "Cancel Subscription (Test Mode)"
                        : "Activate Subscription (Test Mode)",
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('Terms of use', style: TextStyle(color: Colors.white70)),
                    Text('Privacy policy', style: TextStyle(color: Colors.white70)),
                    Text('Restore', style: TextStyle(color: Colors.white70)),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
