import 'package:flutter/material.dart';
import 'package:tizibane/components/share/ShareUrlLink.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingState();
}

class _SettingState extends State<Settings> {
  bool _silentMode = false;
  bool _darkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
             ),
      body: SingleChildScrollView(
        child: Column(
          // 
          children: [
            Center(child: Text('Comming Soon')),
          ],
        ),
      ),
    );
  }
}
