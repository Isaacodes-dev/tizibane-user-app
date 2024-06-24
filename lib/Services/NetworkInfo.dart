import 'dart:async';
import 'dart:io';
import 'dart:js';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
class NetworkInfo{
    final Connectivity? connectivity;
  NetworkInfo(this.connectivity);

   Future<bool> get isConnected async {
    ConnectivityResult result = await connectivity!.checkConnectivity();
    return result != ConnectivityResult.none;
  }
  static void checkConnectivity() {
    bool firstTime = true;
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) async {
      if(!firstTime) {
        //bool isNotConnected = result != ConnectivityResult.wifi && result != ConnectivityResult.mobile;
        bool isNotConnected;
        if(result == ConnectivityResult.none) {
          isNotConnected = true;
        }else {
          isNotConnected = !await (_updateConnectivityStatus() as FutureOr<bool>);
        }
        Get.snackbar(
        isNotConnected ? 'Error' : 'Sucess',
        isNotConnected ? 'Not Internet Connection' : 'Intenet Connection',
        snackPosition: SnackPosition.TOP,
        backgroundColor: isNotConnected ? Colors.red : Colors.green,
        colorText: Colors.white,
      );
      }
      firstTime = false;
    });
  }

    static Future<bool?> _updateConnectivityStatus() async {
     bool? isConnected;
     try {
       final List<InternetAddress> result = await InternetAddress.lookup('google.com');
       if(result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
         isConnected = true;
       }
     }catch(e) {
       isConnected = false;
     }
     return isConnected;
  }
}