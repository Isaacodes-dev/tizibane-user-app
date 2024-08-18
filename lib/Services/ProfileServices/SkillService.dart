import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tizibane/Services/Connectivity.dart';
import 'package:tizibane/components/bottommenu/BottomMenuBar.dart';
import 'package:tizibane/constants/constants.dart';
import 'package:tizibane/models/Skill.dart';

class SkillService extends GetxController {
  final RxBool isLoading = false.obs;

  var edcuationObj = <Skill>[].obs;

  final urlSkill = baseUrl + skill;

  ConnectivityService _connectivityService = Get.put(ConnectivityService());

  Future<void> addSkill(Map<String, dynamic> skill) async {
    try {
      bool isConnected = await _connectivityService.checkConnectivity();

      if (isConnected) {
        isLoading.value = true;

        final prefs = await SharedPreferences.getInstance();
        int? userId = prefs.getInt('userId');

        if (userId != null) {
          final url = '$urlSkill';

          final response = await http.post(
            Uri.parse(url),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(skill),
          );
          if (response.statusCode == 201) {
            isLoading.value = false;
            Get.snackbar(
              'Success',
              'Skill Added Successfully',
              snackPosition: SnackPosition.TOP,
              backgroundColor: Colors.green,
              colorText: Colors.white,
            );
            Get.to(BottomMenuBarItems(selectedIndex: 0));
          } else {
            isLoading.value = false;
            Get.snackbar(
              'Error',
              'Skill Not Added Successfully',
              snackPosition: SnackPosition.TOP,
              backgroundColor: Colors.red,
              colorText: Colors.white,
            );
          }
        } else {
          isLoading.value = false;
          Get.snackbar(
            'Error',
            'Skill Not Added Successfully',
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      }
    } catch (ex) {
      isLoading.value = false;
      Get.snackbar(
        'Error',
        'Education Not Added Successfully',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> updateSkill(Map<String, dynamic> user, int skillId) async {
    try {
      bool isConnected = await _connectivityService.checkConnectivity();

      if (isConnected) {
        isLoading.value = true;

        final prefs = await SharedPreferences.getInstance();
        int? userId = prefs.getInt('userId');

        if (userId != null) {
          final url = '$urlSkill/$skillId';

          final response = await http.post(
            Uri.parse(url),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(user),
          );

          if (response.statusCode == 200 || response.statusCode == 201) {
            isLoading.value = false;
            Get.snackbar(
              'Success',
              'Skill Updated Successfully',
              snackPosition: SnackPosition.TOP,
              backgroundColor: Colors.green,
              colorText: Colors.white,
            );
            Get.to(BottomMenuBarItems(selectedIndex: 0));
          } else {
            isLoading.value = false;
            Get.snackbar(
              'Error',
              'Skill Updated Not Successfully',
              snackPosition: SnackPosition.TOP,
              backgroundColor: Colors.red,
              colorText: Colors.white,
            );
          }
        } else {
          isLoading.value = false;
          Get.snackbar(
            'Error',
            'Education Not Added Successfully',
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      }
    } catch (ex) {
      isLoading.value = false;
      Get.snackbar(
        'Error',
        'Education Not Added Successfully',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

}
