import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tizibane/components/bottommenu/BottomMenuBar.dart';
import 'package:tizibane/screens/Login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final box = GetStorage();

    final token = box.read('token');
    Future.delayed(Duration(seconds: 3), () {
      if (token == null) {
        Get.offAll(()=> Login());
      } else {
        Get.offAll(()=> BottomMenuBarItems(selectedIndex: 0));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        child: Center(
          child: Image.asset('assets/images/Tizibane.png'),
        ),
      ),
    );
  }
}
