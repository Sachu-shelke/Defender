import 'package:flutter/material.dart';
import 'package:defenders/config/theme/app_text_style.dart';
import 'package:defenders/widget/appbars/custom_app_bar.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(title: "About us"),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(
              'Recharge and Utility services Digital Wallet',
              style: AppTextStyle.semiBold16,
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              '''India’s First wallet payments & Shopping app with high cash back on Recharge and utility services.

#Mirror Provides mobile, DTH/Data card Recharge, Bill Payments, instant money transfers, online shopping and creating and gifting gift cards you can do it all securely with #Mirror.

Along with this Mirror is ways to make money online by using refer and earn program.

With the Mirror we strive to bring you daily needs through your mobile phone and desktop.

With innovation supported by various technologies we continuously upgrading our wallet that specially designed to fulfilled user’s daily requirements.
''',
              textScaleFactor: 1.0,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Mirror is committed to transform the clarity',
              style: AppTextStyle.semiBold16,
            ),
          ],
        )
        //   Container(
        //     padding: const EdgeInsets.all(16),
        //     child: const Text(
        //       """Recharge and Utility services Digital Wallet

        // India’s First wallet payments & Shopping app with high cash back on Recharge and utility services.
        // #Mirror Provides mobile, DTH/Data card Recharge, Bill Payments, instant money transfers, online shopping and creating and gifting gift cards you can do it all securely with #Mirror.
        // Along with this Mirror is ways to make money online by using refer and earn program.
        // With the Mirror we strive to bring you daily needs through your mobile phone and desktop.
        // With innovation supported by various technologies we continuously upgrading our wallet that specially designed to fulfilled user’s daily requirements.
        // Mirror is committed to transform the clarity.""",
        //       textScaleFactor: 1.0,
        //     ),
        //   ),

        );
  }
}
