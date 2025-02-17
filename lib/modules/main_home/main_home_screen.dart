import 'dart:async';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:defenders/modules/auth/login/login_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:defenders/config/manager/global_singleton.dart';
import 'package:defenders/config/manager/storage_manager.dart';
import 'package:defenders/config/routes/router_import.gr.dart';
import 'package:defenders/config/theme/app_colors.dart';
import 'package:defenders/config/theme/app_text_style.dart';
import 'package:defenders/constants/app_const_assets.dart';
import 'package:defenders/constants/app_const_text.dart';
import 'package:defenders/modules/main_home/drawer/drawer.dart';
import 'package:defenders/modules/main_home/main_home_model.dart';
import 'package:defenders/modules/main_home/main_home_presenter.dart';
import 'package:defenders/modules/main_home/mian_home_view.dart';

import '../parent/permission_sceen/permission_child.dart';
import '../parent/permission_sceen/permisssion_parent.dart';


@RoutePage()
class MainHomeScreen extends StatefulWidget {
  final bool? isFromSignup;
  const MainHomeScreen({super.key, this.isFromSignup});

  @override
  State<MainHomeScreen> createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> with SingleTickerProviderStateMixin implements MainHomeView {
  MainHomePresenter presenter = BasicMainHomePresenter();
  late MainHomeModel model;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Timer? timer;
  int indexOF = 0;

  @override
  void initState() {
    super.initState();
    presenter.updateView = this;
    startTimer();
    if (GlobalSingleton.prime != 1) {
      presenter.getPrimePlanDetails(context: context);
    }
    presenter.getAdditionalUserInfoDetails(context: context);
  }

  startTimer() {
    timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      indexOF++;
      if (indexOF > 4) {
        indexOF = 0;
      }
      setState(() {});
    });
  }

  @override
  void refreshModel(MainHomeModel mainHomeModel) {
    model = mainHomeModel;

    if (model.primeList.isNotEmpty) {
      getTimeCheck();
    }
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    timer?.cancel(); // Safe cancellation of timer
    super.dispose();
  }

  getTimeCheck() {
    DateTime currentTime = DateTime.now();

    if (currentTime.hour >= 0 && currentTime.hour < 12) {
      StorageManager.clearKey('pmmarketingStoreTime');
      if (StorageManager.getIntValue('ammarketingStoreTime') == null) {
        int timestamp = DateTime.now().millisecondsSinceEpoch;
        StorageManager.setIntValue(key: 'ammarketingStoreTime', value: timestamp);
      }
    } else {
      StorageManager.clearKey('ammarketingStoreTime');
      if (StorageManager.getIntValue('pmmarketingStoreTime') == null) {
        int timestamp = DateTime.now().millisecondsSinceEpoch;
        StorageManager.setIntValue(key: 'pmmarketingStoreTime', value: timestamp);
        // showDialog(
        //   context: context,
        //   // builder: (context) {
        //   //   // return markeingWidget();
        //   // },
        // );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return Dialog(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 5,
                    child: Container(
                      padding: EdgeInsets.all(20),
                      height: 290,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 40,
                            child: Icon(Icons.person),
                            // backgroundImage: AssetImage('assets/child_supervision.png'),  // Replace with actual image
                          ),
                          SizedBox(height: 10),
                          Text(
                            'User Profile',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Name: User name \nEmail: Useremail@example.com',
                            style: TextStyle(fontSize: 14),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {
                              // Navigator.of(context).pop();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginScreen(),
                                ),
                              );
                            },

                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                            ),
                            child: Text('Logout'),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          )
        ],
      ),
      key: _scaffoldKey,
      body: Column(
        children: [
          // Title Text
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Whose device is this?',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,  // Center the text
            ),
          ),
          SizedBox(height: 10),

          // First Stack for "Mine" section
          Stack(
            alignment: Alignment.center,
            children: [
              // Blue container
              InkWell(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SuperviseChildScreen(),
                    ),
                  );
                },
                child: Container(
                  height: 200,
                  width: double.infinity,
                ),
              ),

              InkWell(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SuperviseChildScreen(),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 50.0, left: 30.0, right: 30.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(20),  // Optional rounded corners
                    ),
                    height: 150,
                    width: double.infinity,  // Ensures it takes the full width of the screen
                  ),
                ),
              ),

              // CircleAvatar with "Mine"
              Positioned(
                top: 20,  // Position it down from the top
                child: CircleAvatar(
                  backgroundImage: AssetImage("assets/images/parent.jpg"),
                  radius: 40,
                  backgroundColor: Colors.white,
                ),
              ),

              // "Mine" Text
              Positioned(
                top: 100,
                child: Text(
                  'Mine',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              // Text below the circle
              Positioned(
                top: 130,
                child: Text(
                  "I will use it to manage my child's device",
                  textAlign: TextAlign.center,  // Center the text
                ),
              ),
            ],
          ),

          SizedBox(height: 20),

          // Second Stack for "My Child's" section
          Stack(
            alignment: Alignment.center,  // Center the children inside the Stack
            children: [
              // Blue container
              InkWell(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyChildScreen(),
                    ),
                  );
                },
                child: Container(
                  height: 200,
                  width: double.infinity,
                ),
              ),

              InkWell(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyChildScreen(),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 50.0, left: 30.0, right: 30.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(20),  // Optional rounded corners
                    ),
                    height: 150,
                    width: double.infinity,  // Ensures it takes the full width of the screen
                  ),
                ),
              ),

              // CircleAvatar with "My Child's"
              Positioned(
                top: 20,  // Position it down from the top
                child: CircleAvatar(
                  backgroundImage: AssetImage("assets/images/child.jpg"),
                  radius: 40,
                  backgroundColor: Colors.white,
                ),
              ),

              // "My Child's" Text
              Positioned(
                top: 100,
                child: Text(
                  "My Child's",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),


              Positioned(
                top: 130,
                child: Text(
                  "I want to supervise this device",
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ],
      ),
     );
  }
}


