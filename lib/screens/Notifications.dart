import 'package:flutter/material.dart';
import 'package:tizibane/components/share/ShareUrlLink.dart';

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
          child: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.black,
        title: const Text('Notifications'),
      ),
      body: const Column(
        children: [Text('Page Coming Soon')],
      ),
      floatingActionButton: const ShareUrlLink(),
    );
  }
}
