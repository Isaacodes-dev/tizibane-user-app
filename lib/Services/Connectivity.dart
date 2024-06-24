import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:connectivity/connectivity.dart';

class ConnectivityService extends GetxController {
  @override
  void onInit() {
    super.onInit();

    // checkConnectivity();
  }

  
  Future<bool> checkConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
       
      // Get.snackbar(
      //   'Error',
      //   'No internet connection',
      //   snackPosition: SnackPosition.TOP,
      //   backgroundColor: Colors.red,
      //   colorText: Colors.white,
      // );
      return false;
    } else {
      return true;
    }
  }
}
