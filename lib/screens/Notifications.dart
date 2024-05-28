import 'package:flutter/material.dart';
import 'package:tizibane/components/share/ShareUrlLink.dart';
import 'package:tizibane/components/bottommenu/BottomMenuBar.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
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
        backgroundColor: Colors.black,
        title: Text('Notifications'),
      ),
      body: Column(
        children: [Text('Page Coming Soon')],
      ),
      floatingActionButton: const ShareUrlLink(),
    );
  }
}
