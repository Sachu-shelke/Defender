import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import '../../../../config/manager/global_singleton.dart';
import '../../../../config/theme/app_text_style.dart';
import '../../../../constants/app_const_assets.dart';
import '../../../../constants/app_const_text.dart';
import '../../../../constants/app_sizes.dart';
import '../../../add_money/add_money_screen.dart';
import '../../../camera/camera_screen.dart';
import '../../../income_passbook/income_passbook_screen.dart';
import '../../../notification/notification_screen.dart';
import '../../../passbook/prime_passbook/prime_passbook_screen.dart';
import '../../../passbook/wallet_passbook/wallet_passbook_screen.dart';
import '../../../payment_gatway/phonepe_screen.dart';
import '../../../redeem/redeem_screen.dart';
import '../../../send_money/send_money_mobile_number/send_money_screen.dart';
import '../../../suceess/add_money_sucess_screen.dart';
import '../../always_allow/Always_allowed_apps_acreen/allow_apps_screen.dart';
import '../../app_bar/message_center.dart';
import '../../app_content_restriction/app_content_restriction.dart';
import '../../application/appusage.dart';
import '../../applimits/app_limits_screen.dart';
import '../../call_sms_monitoring/call_sms_monitoring.dart';
import '../../check_required_permission/check_premission.dart';
import '../../downtime/downtime_screen.dart';
import '../../notification/notification_screen.dart';
import '../../social_content/social_content.dart';
import '../../website_restriction/website_restriction.dart';
import '../../widget/bottomsheet/instant_block_sheet.dart';
import 'build_widget/build_widget.dart';

class Mainscreen extends StatefulWidget {
  const Mainscreen({super.key});

  @override
  State<Mainscreen> createState() => _MainscreenState();
}

class _MainscreenState extends State<Mainscreen> {
  bool _isInstantBlockEnabled = false;
  String locationName = "Fetching location..."; // Default text
  bool isLoading = true; // Added to handle loading state

  @override
  void initState() {
    super.initState();
    _getCurrentLocation(); // Fetch the location when the screen initializes
  }

  Future<void> _getCurrentLocation() async {
    // Check if location services are enabled
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        locationName = 'Location services are disabled.';
        isLoading = false;
      });
      return;
    }

    // Check location permissions
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          locationName = 'Location permissions are denied.';
          isLoading = false;
        });
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() {
        locationName = 'Location permissions are permanently denied, we cannot request permissions.';
        isLoading = false;
      });
      return;
    }

    // Fetch current location using Geolocator
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    // Use Geocoding to get the location name
    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    if (placemarks.isNotEmpty) {
      setState(() {
        // Fetching the most detailed address components
        String locality = placemarks[0].locality ?? '';
        String subLocality = placemarks[0].subLocality ?? ''; // May represent district/village
        String administrativeArea = placemarks[0].administrativeArea ?? '';
        String country = placemarks[0].country ?? '';

        // Construct a more detailed location string
        locationName = '$subLocality, $locality, $administrativeArea, $country';
        isLoading = false; // Location fetched successfully, stop loading
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: InkWell(
            onTap: () {
              _showAccountDialog(context);
            },
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/images/logo.jpg'),
            ),
          ),
        ),
        backgroundColor: Colors.lightBlue,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Column(
              children: [
                Text('Defender'),
                Text('Welcome to the Defender App', style: TextStyle(fontSize: 10)),
              ],
            ),
            SizedBox(width: 30),
            Row(
              children: [
                Text(
                  '${AppConstString.rupeesSymbol} ${GlobalSingleton.walletBalance}',
                  style: AppTextStyle.semiBold18,
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.message),
            onPressed: () {
              // Navigate to the call SMS monitoring screen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MessageCenterScreen()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
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
                    child: Text(
                      'Defender',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            blurRadius: 10.0,
                            color: Colors.black.withOpacity(0.5),
                            offset: Offset(2.0, 2.0),
                          ),
                          Shadow(
                            blurRadius: 10.0,
                            color: Colors.grey.withOpacity(0.5),
                            offset: Offset(-2.0, -2.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 10,
                  child: isLoading
                      ? CircularProgressIndicator(color: Colors.white)
                      : Text(
                    locationName,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Card(
              child: Container(
                height: 150,
                padding: const EdgeInsets.symmetric(horizontal: AppSizes.size10, vertical: 15),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AppAssets.cardBlueService),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Add Money Section
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddMoneyScreen()//RedeemScreen(isFromEwallet: true),
                            ),
                          );
                        },

                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/icons/recharge_pay/addmoney.png',
                              height: 50,
                              width: 50,
                            ),
                            Text(
                              'Add Money',
                              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Send Money Section
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SendMoneyScreen(isFromEpin: '')),
                          ); // Navigate to Send Money screen
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/icons/recharge_pay/sendmoney.png',
                              height: 50,
                              width: 50,
                            ),
                            Text(
                              'Send Money',
                              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // History Section
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => IncomePassbookScreen(isFromDrawer: true),
                            ),
                          );
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/icons/recharge_pay/passbook.png',
                              height: 50,
                              width: 50,
                            ),
                            Text(
                              'History',
                              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                color: Colors.lightBlue,
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
                            MaterialPageRoute(builder: (context) => CameraReceiverPage(wsUrl: '')),
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
                CustomWidgets.buildListTile(Icons.grid_view_outlined, 'Application', onTap: () {
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => AppUsageScreen()));//InstalledAppsScreen()));
                }),
              ]),
            ),
            CustomWidgets.buildSectionHeader('Device Supervision'),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomWidgets.buildListTileSection([
                CustomWidgets.buildListTileWithSwitch(
                  Icons.lock_outline_rounded,
                  'Instant Block',
                  _isInstantBlockEnabled,
                      (newValue) {
                    setState(() {
                      _isInstantBlockEnabled = newValue;
                    });
                  },
                  onTap: () {
                    // Trigger the bottom sheet when this ListTile is tapped
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (context) {
                        return CustomBottomSheet(); // Return the InstantBottomSheet widget
                      },
                    );
                  },
                ),
                CustomWidgets.buildListTile(Icons.timelapse, 'Downtime', onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DowntimeScreen()));
                }),
                CustomWidgets.buildListTile(Icons.verified_outlined, 'Always Allowed', onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AllowAppsScreen()));
                }),
                CustomWidgets.buildListTile(Icons.access_time, 'App Limits', onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AppLimitsScreen()));
                }),
                CustomWidgets.buildListTile(Icons.settings_suggest_outlined, 'App & Content Restrictions', onTap: () {
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => AppContentRestriction()));
                }),
                CustomWidgets.buildListTile(Icons.remove_red_eye_outlined, 'Social Content Detection', onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ScrollableButtonScreen()));
                }),
                CustomWidgets.buildListTile(Icons.camera, 'Website Restrictions', onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => WebsiteRestriction()));
                }),
                CustomWidgets.buildListTile(Icons.masks_sharp, 'Calls & SMS Monitoring', onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => CallSmsMonitoring()));
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
                CustomWidgets.buildListTile(Icons.lightbulb_outlined, 'Open the Hidden Defender Kids?'),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
void _showAccountDialog(BuildContext context) {
  List<Map<String, String>> accounts = [
    {
      'name': 'User',
      'email': 'User.abc@gmail.com',
      'image': 'assets/images/logo.jpg',
    },
    {
      'name': 'user1',
      'email': 'user1.123@gmail.com',
      'image': 'assets/images/logo.jpg',
    },
    {
      'name': 'User2',
      'email': 'User2.1234@gmail.com',
      'image': 'assets/images/logo.jpg',
    },
  ];

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        title: Text('Account Information'),
        content: Container(
          color: Colors.white70,
          height: 300,
          width: double.maxFinite,
          child: ListView.builder(
            itemCount: accounts.length,
            itemBuilder: (context, index) {
              var account = accounts[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage(account['image']!),
                ),
                title: Text(account['name']!),
                subtitle: Text(account['email']!),
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close the dialog
            },
            child: Text('Close'),
          ),
        ],
      );
    },
  );
}