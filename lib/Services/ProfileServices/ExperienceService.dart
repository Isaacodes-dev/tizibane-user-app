import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tizibane/Services/Connectivity.dart';
import 'package:tizibane/components/bottommenu/BottomMenuBar.dart';
import 'package:tizibane/constants/constants.dart';
import 'package:tizibane/models/Experience.dart';

class ExperienceService extends GetxController {
  final RxBool isLoading = false.obs;

  var experienceObj = <Experience>[].obs;

  final urlExperience = baseUrl + experience;

  ConnectivityService _connectivityService = Get.put(ConnectivityService());

  Future<void> getUser() async {
    bool isConnected = await _connectivityService.checkConnectivity();
    if (isConnected) {
      String accessToken = await getStoredToken();
      // String storedNrc = await getStoredNrc();
      final prefs = await SharedPreferences.getInstance();
      int userId = prefs.getInt('userId') ?? 0;
      isLoading.value = true;
      final response = await http.get(
        Uri.parse("$urlExperience/$userId"),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        if (responseData['user'] != null) {
          List<dynamic> data = responseData['user'];
          experienceObj.value =
              data.map((e) => Experience.fromJson(e)).toList();

          // Save the user object to local storage
          //await _dbHelper.insertUser(userObj.map((user) => user.toJson()).toList());

          isLoading.value = false;
        } else {
          isLoading.value = false;
          experienceObj.value = [];
          throw Exception("User data is null");
        }
      } else {
        isLoading.value = false;
        experienceObj.value = [];
        throw Exception('Failed to load user data: ${response.statusCode}');
      }
    } else {
      //loadLocalData();
    }
  }

  Future<void> addExperience(Map<String, dynamic> experience) async {
    try {
      bool isConnected = await _connectivityService.checkConnectivity();

      if (isConnected) {
        isLoading.value = true;

        final prefs = await SharedPreferences.getInstance();
        int? userId = prefs.getInt('userId');

        if (userId != null) {
          final url = '$urlExperience/$userId';

          final response = await http.post(
            Uri.parse(url),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(experience),
          );

          if (response.statusCode == 201) {
            isLoading.value = false;
            Get.snackbar(
              'Success',
              'Experience Added Successfully',
              snackPosition: SnackPosition.TOP,
              backgroundColor: Colors.green,
              colorText: Colors.white,
            );
            Get.to(BottomMenuBarItems(selectedIndex: 0));
          } else {
            print(response.statusCode);
            isLoading.value = false;
            Get.snackbar(
              'Error',
              'Experience Not Added Successfully',
              snackPosition: SnackPosition.TOP,
              backgroundColor: Colors.red,
              colorText: Colors.white,
            );
          }
        } else {
          isLoading.value = false;
          Get.snackbar(
            'Error',
            'Experience Not Added Successfully',
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
        'Experience Not Added Successfully',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> updateExperience(
      int id, Map<String, dynamic> experienceObj) async {
    try {
      bool isConnected = await _connectivityService.checkConnectivity();

      if (isConnected) {
        isLoading.value = true;

        final prefs = await SharedPreferences.getInstance();
        int? userId = prefs.getInt('userId');

        if (userId != null) {
          final url = '$baseUrl$experience/$id';
          print(url);
          final response = await http.post(
            Uri.parse(url),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(experienceObj),
          );

          if (response.statusCode == 200 || response.statusCode == 201) {
            isLoading.value = false;
            Get.snackbar(
              'Success',
              'Experience Updated Successfully',
              snackPosition: SnackPosition.TOP,
              backgroundColor: Colors.green,
              colorText: Colors.white,
            );
          } else {
            isLoading.value = false;
            Get.snackbar(
              'Error',
              'Experience Not Updated Successfully',
              snackPosition: SnackPosition.TOP,
              backgroundColor: Colors.red,
              colorText: Colors.white,
            );
            print(response.statusCode);
          }
        } else {
          isLoading.value = false;
          Get.snackbar(
            'Error',
            'Experience Not Updated Successfully',
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
        'Experience Not Updated Successfully',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}

Future<String> getStoredToken() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('token') ?? '';
}
