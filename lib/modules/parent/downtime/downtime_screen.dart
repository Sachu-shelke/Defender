import 'package:flutter/material.dart';
class DowntimeScreen extends StatefulWidget {
  const DowntimeScreen({super.key});

  @override
  State<DowntimeScreen> createState() => _DowntimeScreenState();
}

class _DowntimeScreenState extends State<DowntimeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Downtime'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/smartphone.png',width: 200,height: 200,),
            Text('During downtime, only phone calls and the'),
            Text('apps that you add to the Always Allowed will be'),
            Text('avilailable'),
            SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
              onPressed: () {}, child: Text('Add Limit',style: TextStyle(
              color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold
            ),),
            )
          ],
        ),
      ),
    );
  }
}
