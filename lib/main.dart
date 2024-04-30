import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tizibane/Services/AuthService.dart';
import 'package:tizibane/components/bottommenu/BottomMenuBar.dart';
import 'package:tizibane/screens/Home.dart';
import 'Screens/Login.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
     final box = GetStorage();
    
     final token = box.read('token') ;
    
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: token == null ? Login() : const BottomMenuBarItems(selectedIndex: 0,),
    );
  }
}


