import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:tizibane/screens/Login.dart';
import 'package:tizibane/screens/Notifications.dart';
import 'package:tizibane/screens/Settings.dart';

class More extends StatefulWidget {
  const More({super.key});

  @override
  State<More> createState() => _MoreState();
}

class _MoreState extends State<More> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 0, 52, 105),
      ),
      body: Column(
        children: [
          Container(
            color: Color.fromARGB(255, 0, 52, 105),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Container(
                    width: 140,
                    child: QrImageView(
                      data: '123456451',
                      size: 200,
                      foregroundColor: Colors.orange,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(child: getListView())
        ],
      ),
    );
  }

  Widget getListView() {
    var listView = ListView(
      children: <Widget>[
        ListTile(
          leading: Icon(Icons.notifications),
          title: Text('Notifications'),
          onTap: () => {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => Notifications()))
          },
        ),
        ListTile(
          leading: Icon(Icons.settings),
          title: Text('Settings'),
          onTap: () => {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => Settings()))
          },
        ),
        ListTile(
          leading: Icon(Icons.logout),
          title: Text('Logout'),
          onTap: () => {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => Login()))
          },
        ),
      ],
    );
    return listView;
  }
}
