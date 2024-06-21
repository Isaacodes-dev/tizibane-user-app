import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tizibane/components/bottommenu/BottomMenuBar.dart';
import 'package:tizibane/screens/Login.dart';

String? finalToken;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Load validation data and navigate after 2 seconds
    getValidationData().whenComplete(() {
      Timer(
        const Duration(seconds: 2),
        () => navigateToNextScreen(),
      );
    });
  }

  Future<void> getValidationData() async {
    try {
      final SharedPreferences preferences = await SharedPreferences.getInstance();
      final obtainedToken = preferences.getString('tokenValue');
      setState(() {
        finalToken = obtainedToken;
      });
      print(finalToken);
    } catch (e) {
      // Handle error fetching token
      print('Error fetching token: $e');
    }
  }

  void navigateToNextScreen() {
    if (finalToken == null) {
      Get.offAll(() => const Login());
    } else {
      Get.offAll(() => const BottomMenuBarItems(selectedIndex: 0));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Image.asset('assets/images/Tizibane.png'),
      ),
    );
  }
}
