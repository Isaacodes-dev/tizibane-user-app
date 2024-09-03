import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tizibane/Services/Connectivity.dart';
import 'package:tizibane/components/bottommenu/BottomMenuBar.dart';
import 'package:tizibane/constants/constants.dart';
import 'package:tizibane/models/Education.dart';

class EducationService extends GetxController {
  final RxBool isLoading = false.obs;

  var edcuationObj = <Education>[].obs;

  final urlEducation = baseUrl + educationUpload;

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
        Uri.parse("$urlEducation/$userId"),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        if (responseData['user'] != null) {
          List<dynamic> data = responseData['user'];
          edcuationObj.value = data.map((e) => Education.fromJson(e)).toList();

          // Save the user object to local storage
          //await _dbHelper.insertUser(userObj.map((user) => user.toJson()).toList());

          isLoading.value = false;
        } else {
          isLoading.value = false;
          edcuationObj.value = [];
          throw Exception("User data is null");
        }
      } else {
        isLoading.value = false;
        edcuationObj.value = [];
        throw Exception('Failed to load user data: ${response.statusCode}');
      }
    } else {
      //loadLocalData();
    }
  }

  Future<void> addEducation(
      Map<String, dynamic> education, File? certificateFile) async {
    try {
      bool isConnected = await _connectivityService.checkConnectivity();

      if (isConnected) {
        isLoading.value = true;

        final prefs = await SharedPreferences.getInstance();
        int? userId = prefs.getInt('userId');

        if (userId != null) {
          final url = '$baseUrl$educationUpload/$userId';

          var request = http.MultipartRequest('POST', Uri.parse(url));

          // Add headers
          request.headers.addAll({
            'Content-Type': 'multipart/form-data',
          });

          // Add JSON data as fields
          education.forEach((key, value) {
            request.fields[key] = value.toString();
          });

          // Add file if it exists
          if (certificateFile != null) {
            request.files.add(await http.MultipartFile.fromPath(
              'certificate', // The field name for the file in the request
              certificateFile.path,
              filename: basename(certificateFile.path),
            ));
          }

          var streamedResponse = await request.send();
          var response = await http.Response.fromStream(streamedResponse);

          if (response.statusCode == 201) {
            isLoading.value = false;
            Get.snackbar(
              'Success',
              'Education Added Successfully',
              snackPosition: SnackPosition.TOP,
              backgroundColor: Colors.green,
              colorText: Colors.white,
            );
            Get.to(BottomMenuBarItems(selectedIndex: 0));
          } else {
            isLoading.value = false;
            Get.snackbar(
              'Error',
              'Education Not Added Successfully',
              snackPosition: SnackPosition.TOP,
              backgroundColor: Colors.red,
              colorText: Colors.white,
            );
            print(response.statusCode);
          }
        } else {
          print('error');
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
      print(ex);
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

  Future<void> updateEducation(
      Map<String, dynamic> education, int id, File? certificateFile) async {
    print(id);
    print(education);
    print(certificateFile);
    try {
      bool isConnected = await _connectivityService.checkConnectivity();
      if (isConnected) {
        isLoading.value = true;

        final prefs = await SharedPreferences.getInstance();
        int? userId = prefs.getInt('userId');

        if (userId != null) {
          final url = '$baseUrl$educationUpload/$id';

          var request = http.MultipartRequest('POST', Uri.parse(url));

          // Add headers
          request.headers.addAll({
            'Content-Type': 'multipart/form-data',
          });

          // Add JSON data as fields
          education.forEach((key, value) {
            request.fields[key] = value.toString();
          });

          // Add file if it exists
          if (certificateFile != null) {
            request.files.add(await http.MultipartFile.fromPath(
              'certificate', // The field name for the file in the request
              certificateFile.path,
              filename: basename(certificateFile.path),
            ));
          }

          var streamedResponse = await request.send();
          var response = await http.Response.fromStream(streamedResponse);

          if (response.statusCode == 200 || response.statusCode == 201) {
            isLoading.value = false;
            Get.snackbar(
              'Success',
              'Education Updated Successfully',
              snackPosition: SnackPosition.TOP,
              backgroundColor: Colors.green,
              colorText: Colors.white,
            );
            Get.to(BottomMenuBarItems(selectedIndex: 0));
          } else {
            isLoading.value = false;
            Get.snackbar(
              'Error',
              'Education Not Updated Successfully',
              snackPosition: SnackPosition.TOP,
              backgroundColor: Colors.red,
              colorText: Colors.white,
            );
            print(response.statusCode);
          }
        } else {
          print('error');
          isLoading.value = false;
          Get.snackbar(
            'Error',
            'Education Not Updated Successfully',
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      }
    } catch (ex) {
      print(ex);
      isLoading.value = false;
      Get.snackbar(
        'Error',
        'Education Not Updated Successfully',
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
