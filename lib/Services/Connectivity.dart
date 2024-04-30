import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:connectivity/connectivity.dart';

class ConnectivityService extends GetxController {
  var isConnected = true.obs;

  @override
  void onInit() {
    super.onInit();
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      checkConnectivity();
    });
  }

  Future<bool> checkConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      isConnected.value = false;
      Get.snackbar(
        'Error',
        'No internet connection',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } else {
      isConnected.value = true;
      if (isConnected.value) {
        Get.snackbar(
        'info',
        'Network has been restored',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      }
    }
    return isConnected.value;
  }
}
