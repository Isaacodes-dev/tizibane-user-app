import 'package:flutter/material.dart';
import 'package:tizibane/components/share/ShareUrlLink.dart';
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
          child: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.black,
        title: const Text('Settings'),
      ),
      body: const Column(
        children: [
          Text('Page Coming Soon'),
        ],
        
      ),
      floatingActionButton: const ShareUrlLink(),
    );
  }

}
