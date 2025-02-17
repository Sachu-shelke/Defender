import 'package:flutter/material.dart';

import '../../main_home/widget/build_widget/build_widget.dart';
import '../../main_home/widget/build_widget/listtile.dart';
class CheckPremission extends StatefulWidget {
  const CheckPremission({super.key});

  @override
  State<CheckPremission> createState() => _CheckPremissionState();
}

class _CheckPremissionState extends State<CheckPremission> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Check the Required Permissions',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
        actions: [
          Icon(Icons.refresh),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              color: Colors.blue,
                height: 200,
                width: double.infinity,
                child: Image.asset('assets/images/happy.png')),
            SizedBox(height: 10,),
            CustomWidgets.buildSectionHeader('Permissions not granted'),
            CustomWidgets.buildListTileSection([
              CustomListTile(leadingIcon: Icons.location_on_outlined, title: 'Real-time Location',
              subtitle: 'You havent granted permission to device\n location on the child\'s device. ',
              trailing: CircleAvatar( backgroundColor:Colors.orange, child: Center(child: Text('!',style: TextStyle(color: Colors.white),)), radius: 10,)),
              Divider(thickness: 1,color: Colors.grey,),
              CustomListTile(leadingIcon: Icons.roundabout_left, title: 'Route History',
              subtitle: 'you haven\'t granted permission to device\nlocation on the child\'s device. ',
                  trailing: CircleAvatar( backgroundColor:Colors.orange, child: Center(child: Text('!',style: TextStyle(color: Colors.white),)), radius: 10,)),
              Divider(thickness: 1, color: Colors.grey,),
              CustomListTile(leadingIcon: Icons.control_point_sharp, title: 'Geofencing',
              subtitle: 'You haven\'t granted permission to device\nlocation on the child\'s device. ',
                  trailing: CircleAvatar( backgroundColor:Colors.orange, child: Center(child: Text('!',style: TextStyle(color: Colors.white),)), radius: 10,)),
            ]
            )
          ],
        ),
      ),
    );
  }
}
