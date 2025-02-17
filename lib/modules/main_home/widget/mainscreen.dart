import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../../server/call_log/call_sms.dart';
import '../../camera/camera_screen.dart';
import '../../notification/notification_screen.dart';
// import '../../widgets/custom_widgets.dart';
import '../../parent/app_content_restriction/app_content_restriction.dart';
import '../../parent/application/application_restrict.dart';
import '../../parent/application/application_screen.dart';
import '../../parent/applimits/app_limits_screen.dart';
import '../../parent/call_sms_monitoring/call_sms_monitoring.dart';
import '../../parent/check_required_permission/check_premission.dart';
import '../../parent/downtime/downtime_screen.dart';
import '../../parent/notification/notification_screen.dart';
import '../../parent/social_content/social_content.dart';
import '../../parent/website_restriction/website_restriction.dart';
import 'build_widget/build_widget.dart'; // Import the custom widgets

class Mainscreen extends StatefulWidget {
  const Mainscreen({super.key});

  @override
  State<Mainscreen> createState() => _MainscreenState();
}

class _MainscreenState extends State<Mainscreen> {
  late WebSocketChannel channel;

  @override
  void initState() {
    super.initState();
    channel = WebSocketChannel.connect(Uri.parse('ws://your-server-url'));
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: CircleAvatar(
          backgroundImage: AssetImage('assets/images/logo.jpg'),
        ),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Column(
          children: [
            Text('Defender'),
            Text('Welcome to the Defender App', style: TextStyle(fontSize: 10)),
          ],
        ),
        actions: [
          IconButton(icon: Icon(Icons.message), onPressed: () {}),
          IconButton(icon: Icon(Icons.add), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(15),
                  bottomLeft: Radius.circular(15),
                ),
                color: Colors.lightBlue,
              ),
              child: Center(
                child: Text('Defender',
                    style: TextStyle(
                        color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold)),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                color: Colors.orange,
                elevation: 20,
                shadowColor: Colors.black,
                child: Container(
                  height: 150,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CameraReceiverPage(wsUrl: '')),
                          );
                        },
                        child: CustomWidgets.buildCard(
                            'Remote \n Camera', Colors.blueAccent, 'assets/icons/photo.png'),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => NotificationScreen()),
                          );
                        },
                        child: CustomWidgets.buildCard(
                            'Notification', Colors.blueAccent, 'assets/icons/binoculars.png'),
                      ),
                      CustomWidgets.buildCard(
                          'One Way\n Audio', Colors.blue, 'assets/icons/heaphones.png'),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            CustomWidgets.buildSectionHeader('Device Overview'),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomWidgets.buildListTileSection([
                CustomWidgets.buildListTile(Icons.notifications_none, 'Notification', onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AlertsScreen()));
                }),
                CustomWidgets.buildListTile(Icons.grid_view_outlined, 'Application',onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => InstalledAppsScreen()));
                }),
              ]),
            ),
            CustomWidgets.buildSectionHeader('Device Supervision'),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomWidgets.buildListTileSection([
                CustomWidgets.buildListTile(Icons.lock_outline_rounded, 'Instant Block', onTap: () {}),
                CustomWidgets.buildListTile(Icons.timelapse, 'Downtime', onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DowntimeScreen()));
                }),
                CustomWidgets.buildListTile(Icons.verified_outlined, 'Always Allowed', onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AppBlockerScreen()));
                }),
                CustomWidgets.buildListTile(Icons.access_time, 'App Limits', onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AppLimitsScreen()));
                }),
                CustomWidgets.buildListTile(Icons.settings_suggest_outlined, 'App & Content Restrictions', onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AppContentRestriction()));
                }),
                CustomWidgets.buildListTile(Icons.remove_red_eye_outlined, 'Social Content Detection', onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ScrollableButtonScreen()));
                }),
                CustomWidgets.buildListTile(Icons.camera, 'Website Restrictions', onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => WebsiteRestriction()));
                }),
                CustomWidgets.buildListTile(Icons.masks_sharp, 'Calls & SMS Monitoring', onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>     CallSmsScreen())); //CallSmsMonitoring()));
                }),
              ]),
            ),
            CustomWidgets.buildSectionHeader('Other'),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomWidgets.buildListTileSection([
                CustomWidgets.buildListTile(Icons.format_align_center_rounded, 'Check the Required\n Permissions', onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => CheckPremission()));
                }),
                CustomWidgets.buildListTile(Icons.upload_outlined, 'Check Updates', onTap: () {}),
                CustomWidgets.buildListTile(Icons.lightbulb_outlined,'Open the Hidden Defender Kids?',)
              ]
              )
            ),
          ],
        ),
      ),
    );
  }
}
