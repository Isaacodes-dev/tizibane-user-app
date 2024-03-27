import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:tizibane/Services/AuthService.dart';
import 'package:tizibane/screens/Login.dart';
import 'package:tizibane/screens/Notifications.dart';
import 'package:tizibane/screens/Settings.dart';
import 'package:get/get.dart';

class More extends StatefulWidget {
  const More({super.key});

  @override
  State<More> createState() => _MoreState();
}

final AuthService _authService = Get.put(AuthService());

final nrcStorage = GetStorage();

String nrcNumber = nrcStorage.read('nrcNumber');

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
                      data: nrcNumber,
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
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Settings()))
          },
        ),
        Obx(() {
          return _authService.isLoading.value
              ? Center(child: Text('Please Wait...',style: TextStyle(fontSize: 14),))
              : ListTile(
                  leading: Icon(Icons.logout),
                  title: Text('Logout'),
                  onTap: () async {
                    await _authService.logOut();
                  },
                );
        })
      ],
    );
    return listView;
  }
}
