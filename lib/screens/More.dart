import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tizibane/Services/AuthService.dart';
import 'package:tizibane/Services/Connectivity.dart';
import 'package:tizibane/Services/UserService.dart';
import 'package:tizibane/screens/Jobs/uploadCv.dart';
import 'package:tizibane/screens/Login.dart';
import 'package:tizibane/screens/Notifications.dart';
import 'package:tizibane/screens/Settings.dart';
import 'package:get/get.dart';
import 'package:tizibane/components/share/ShareUrlLink.dart';
import 'package:tizibane/screens/UpdateUserCredentials.dart';
import 'package:tizibane/screens/UserQRCode.dart';

class More extends StatefulWidget {
  const More({super.key});

  @override
  State<More> createState() => _MoreState();
}

final AuthService _authService = Get.put(AuthService());

final UserService _userService = Get.put(UserService());

class _MoreState extends State<More> {
  var nrcNumber = ''.obs; // Use RxString for reactive state management

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  Future<void> loadUserData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString('token');
    nrcNumber.value = preferences.getString('nrcNumber') ?? '';

    if (token != null && nrcNumber.value.isNotEmpty) {
      print('Token: $token');
      print('NRC Number: ${nrcNumber.value}');
    } else {
      print('No user data found');
    }
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
                    child: Obx(() => QrImageView(
                          data: nrcNumber.value,
                          size: 200,
                          foregroundColor: Colors.white,
                        )),
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
        // ListTile(
        //   leading: Icon(Icons.upload_file_rounded, color: Colors.black),
        //   title: Text('Upload Cv', style: GoogleFonts.lexendDeca()),
        //   onTap: () => {Get.to(UploadCv())},
        // ),
        ListTile(
          leading: Icon(Icons.qr_code_2_outlined, color: Colors.black),
          title: Text('Offline QRCode', style: GoogleFonts.lexendDeca()),
          onTap: () => {Get.to(UserQRCode())},
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
