import 'package:flutter/material.dart';
import '../main_home/widget/build_widget/listtile.dart';

class WebsiteRestriction extends StatefulWidget {
  const WebsiteRestriction({super.key});

  @override
  State<WebsiteRestriction> createState() => _WebsiteRestrictionState();
}

class _WebsiteRestrictionState extends State<WebsiteRestriction> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Website Restriction'),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 80), // Space for the bottom container
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('assets/images/web.png',height: 150,width: 150,),
                  const SizedBox(height: 10),
                  const Text(
                    'Defender Browser',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Text('A browser designed for parents and children, helping',
                  style: TextStyle(fontSize: 12),),
                  const Text('you better monitor your child\'s internet browsing',
                  style: TextStyle(fontSize: 12),),
                  const Text('behavior',style: TextStyle(fontSize: 12),),
                  const SizedBox(height: 20),
                  CustomListTile(
                    leadingIcon: Icons.account_circle_outlined,
                    title: 'Remote Browser Management',
                    subtitle: 'Configure and apply browser rules in Defender Parental '
                        'Controls to the Defender browser on your child\'s device.',
                  ),
                  CustomListTile(
                    leadingIcon: Icons.account_balance_wallet_sharp,
                    title: 'Content Filtering',
                    subtitle: 'Block harmful internet content such as adult websites, '
                        'violent content, etc., to keep your child safe online.',
                  ),
                  CustomListTile(
                    leadingIcon: Icons.display_settings_sharp,
                    title: 'URL Blacklist and Whitelist',
                    subtitle: 'Set up URL blacklists and whitelists to easily manage '
                        'your child\'s access.',
                  ),
                  CustomListTile(
                    leadingIcon: Icons.access_time,
                    title: 'History Tracking',
                    subtitle: 'Parent can view thier child browsing history and '
                        'block website from it.')
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 80,
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: Colors.blue,
                  ),
                  child: const Text(
                    'How to download?',
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
