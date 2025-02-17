import 'package:flutter/material.dart';
class AppLimitsScreen extends StatefulWidget {
  const AppLimitsScreen({super.key});

  @override
  State<AppLimitsScreen> createState() => _AppLimitsScreenState();
}

class _AppLimitsScreenState extends State<AppLimitsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AppLimits'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/break.png',width: 200,height: 200,),
            Text('set time limit or schedule downtime to make apps'),
            Text('or categories inccessible within a certain amount '),
            Text('of time frame.'),
            SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
              onPressed: () {},
              child: Text('Add Limit',style: TextStyle(
                color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold
            ),),
            )
          ],
        ),
      ),
    );
  }
}
