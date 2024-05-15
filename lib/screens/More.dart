import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:tizibane/Services/AuthService.dart';
import 'package:tizibane/screens/Notifications.dart';
import 'package:tizibane/screens/Settings.dart';
import 'package:get/get.dart';
import 'package:tizibane/screens/UpdateUserCredentials.dart';
import 'package:tizibane/components/share/ShareUrlLink.dart';

class More extends StatefulWidget {
  const More({super.key});

  @override
  State<More> createState() => _MoreState();
}

final AuthService _authService = Get.put(AuthService());

final nrcStorage = GetStorage();

late String nrcNumber;

class _MoreState extends State<More> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nrcNumber = nrcStorage.read('nrcNumber');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Image.asset(
            'assets/images/tizibaneicon.png',
            width: 50,
            height: 50,
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.black,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: SizedBox(
                    width: 140,
                    child: QrImageView(
                      data: nrcNumber,
                      size: 200,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(child: getListView())
        ],
      ),
      floatingActionButton: const ShareUrlLink(),
    );
  }

  Widget getListView() {
    var listView = ListView(
      children: <Widget>[
        ListTile(
          leading: const Icon(
            Icons.notifications,
            color: Colors.black,
          ),
          title: Text('Notifications', style: GoogleFonts.lexendDeca()),
          onTap: () => {Get.to(const Notifications())},
        ),
        ListTile(
          leading: const Icon(Icons.settings, color: Colors.black),
          title: Text('Settings', style: GoogleFonts.lexendDeca()),
          onTap: () => {Get.to(const Settings())},
        ),
        ListTile(
          leading: const Icon(Icons.lock, color: Colors.black),
          title: Text('Change Password', style: GoogleFonts.lexendDeca()),
          onTap: () => {Get.to(const UpdateUserCredentials())},
        ),
        Obx(() {
          return _authService.isLoading.value
              ? const Center(
                  child: Text(
                  'Please Wait...',
                  style: TextStyle(fontSize: 14),
                ))
              : ListTile(
                  leading: const Icon(Icons.logout, color: Colors.black),
                  title: Text('Logout', style: GoogleFonts.lexendDeca()),
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
