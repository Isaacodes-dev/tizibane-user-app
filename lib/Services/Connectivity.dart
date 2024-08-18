import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService extends GetxController {
  var isConnected = true.obs;
  var hasShownSnackbar = false.obs;

  @override
  void onInit() {
    super.onInit();
    _subscribeToConnectivityChanges();
  }

  Future<bool> checkConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      _showNoConnectionSnackBar();
      isConnected.value = false;
      return false;
    } else {
      isConnected.value = true;
      return true;
    }
  }

  void _subscribeToConnectivityChanges() {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        _showNoConnectionSnackBar();
        isConnected.value = false;
      } else {
        isConnected.value = true;
        hasShownSnackbar.value = false; // Reset the flag when connectivity is restored
      }
    });
  }

  void _showNoConnectionSnackBar() {
    if (!hasShownSnackbar.value) {
      Get.snackbar(
        'Error',
        'No internet connection',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      hasShownSnackbar.value = true; // Set the flag to true after showing the Snackbar
    }
  }
}
