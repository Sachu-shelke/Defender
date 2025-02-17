import 'package:flutter/material.dart';

import '../accessing/parent_accessing.dart';

class SuperviseChildScreen extends StatelessWidget {
  const SuperviseChildScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/smartphone.png',
              height: 200,
            ),
            const SizedBox(height: 20),
            const Text(
              'Supervise Child\'s Device',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            const Text(
              'With Defender Parental Control, parents can keep an eye on how their kids use their devices and help them manage their screen time.',
              // textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: Colors.black54),
            ),
            const SizedBox(height: 20),
            RichText(
              text: TextSpan(
                style: const TextStyle(fontSize: 14, color: Colors.black54),
                children: [
                  const TextSpan(text: 'Before you continue to use our services, you have read and fully understood our '),
                  TextSpan(
                    text: 'Terms of Service',
                    style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const Text(
              'You expressly undertake to comply with the applicable laws and regulations in your territory during the use '
                  'of the application. We care about the safety and welfare of children and value privacy. You agree and '
                  'authorize our product to obtain data and information from your child\'s devices.',
              style: TextStyle(fontSize: 12, color: Colors.black54),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Not now',
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                    MaterialPageRoute(
                      builder: (context) => BindingScreen(),
                    )
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    child: Text(
                      'Agree',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
