import 'package:flutter/material.dart';
import 'package:tizibane/components/bottommenu/BottomMenuBar.dart';
class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Color.fromARGB(255, 0, 52, 105),
        title: Text('Settings'),
      ),
      body: Column(
        children: [
          Text('Page Coming Soon'),
        ],
        
      ),
    );
  }

}
