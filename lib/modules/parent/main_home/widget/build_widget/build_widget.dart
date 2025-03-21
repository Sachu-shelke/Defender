import 'package:flutter/material.dart';

class CustomWidgets {
  static Widget buildCard(String title, Color color, String imagePath) {
    return Container(
      height: 100,
      child: Card(
        color: color,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Center(
                child: Text(
                  title,
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 5),
              Image.asset(imagePath, height: 35, width: 40),
            ],
          ),
        ),
      ),
    );
  }

  static Widget buildSectionHeader(String title) {
    return Row(
      children: [
        Container(height: 15, width: 5, color: Colors.blue),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  static Widget buildListTile(IconData icon, String title, {VoidCallback? onTap}) {
    return ListTile(
      leading: Icon(icon),
      title: Text(
        title,
        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
      ),
      trailing: Icon(Icons.arrow_forward_ios_outlined, size: 15),
      onTap: onTap,
    );
  }

  static Widget buildListTileSection(List<Widget> items) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Column(children: items),
    );
  }
  static Widget buildListTileWithSwitch(
      IconData icon,
      String title,
      bool value,
      Function(bool) onChanged, {
        VoidCallback? onTap,
        Color iconColor = Colors.black,
        TextStyle titleStyle = const TextStyle(fontSize: 14,fontWeight: FontWeight.w700), // Default text style
      }) {
    return ListTile(
      leading: Icon(icon, color: iconColor),
      title: Text(
        title,
        style: titleStyle, // Apply the titleStyle here
      ),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
      ),
      onTap: onTap,
    );
  }

}
