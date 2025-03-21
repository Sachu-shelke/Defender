import 'package:defenders/constants/app_const_assets.dart';
import 'package:flutter/material.dart';

class NoDataScreen extends StatelessWidget {
  final String message;

  // Constructor
  const NoDataScreen({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // GIF Image in the center
            Image.asset(
              AppAssets.nodata,
              width: 70,
              height: 70,
            ),
            const SizedBox(height: 20),

            Text(
              message,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
