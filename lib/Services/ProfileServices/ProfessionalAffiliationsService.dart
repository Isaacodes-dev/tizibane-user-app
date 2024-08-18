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
import 'package:tizibane/models/ProfessionalAffiliation.dart';

class ProfessionalAffiliationsService extends GetxController {
  final RxBool isLoading = false.obs;

  var professionalAffiliationObj = <ProfessionalAffiliation>[].obs;

  final urlProfessionalAffiliation = baseUrl + professionalAffiliation;

  ConnectivityService _connectivityService = Get.put(ConnectivityService());

  Future<void> addProfessionalAffiliation(
      Map<String, dynamic> affiliation, File? _file) async {
    try {
      bool isConnected = await _connectivityService.checkConnectivity();
      print(affiliation);
      if (isConnected) {
        isLoading.value = true;

        final prefs = await SharedPreferences.getInstance();
        int? userId = prefs.getInt('userId');

        if (userId != null) {
          final url = '$urlProfessionalAffiliation/$userId';

          var request = http.MultipartRequest('POST', Uri.parse(url));

          // Add headers
          request.headers.addAll({
            'Content-Type': 'multipart/form-data',
          });

          // Add JSON data as fields
          affiliation.forEach((key, value) {
            request.fields[key] = value.toString();
          });

          // Add file if it exists
          if (_file != null) {
            request.files.add(await http.MultipartFile.fromPath(
              'certificate', // The field name for the file in the request
              _file.path,
              filename: basename(_file.path),
            ));
          }

          var streamedResponse = await request.send();
          var response = await http.Response.fromStream(streamedResponse);

          if (response.statusCode == 201) {
            isLoading.value = false;
            Get.snackbar(
              'Success',
              'Professional Affiliation Added Successfully',
              snackPosition: SnackPosition.TOP,
              backgroundColor: Colors.green,
              colorText: Colors.white,
            );
            Get.to(BottomMenuBarItems(selectedIndex: 0));
          } else {
            isLoading.value = false;
            Get.snackbar(
              'Error',
              'Professional Affiliation Not Added Successfully',
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
            'Professional Affiliation Not Added Successfully',
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
        'Professional Affiliation Not Added Successfully',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> updateProfessionalAffiliation(
      Map<String, dynamic> affiliation, File? _file) async {
    try {
      bool isConnected = await _connectivityService.checkConnectivity();
      print(affiliation);
      if (isConnected) {
        isLoading.value = true;

        final prefs = await SharedPreferences.getInstance();
        int? userId = prefs.getInt('userId');

        if (userId != null) {
          final url = '$urlProfessionalAffiliation/$userId';

          var request = http.MultipartRequest('POST', Uri.parse(url));

          // Add headers
          request.headers.addAll({
            'Content-Type': 'multipart/form-data',
          });

          // Add JSON data as fields
          affiliation.forEach((key, value) {
            request.fields[key] = value.toString();
          });

          // Add file if it exists
          if (_file != null) {
            request.files.add(await http.MultipartFile.fromPath(
              'certificate', // The field name for the file in the request
              _file.path,
              filename: basename(_file.path),
            ));
          }

          var streamedResponse = await request.send();
          var response = await http.Response.fromStream(streamedResponse);

          if (response.statusCode == 200 || response.statusCode == 201) {
            isLoading.value = false;
            Get.snackbar(
              'Success',
              'Professional Affiliation Added Successfully',
              snackPosition: SnackPosition.TOP,
              backgroundColor: Colors.green,
              colorText: Colors.white,
            );
            Get.to(BottomMenuBarItems(selectedIndex: 0));
          } else {
            isLoading.value = false;
            Get.snackbar(
              'Error',
              'Professional Affiliation Not Added Successfully',
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
            'Professional Affiliation Not Added Successfully',
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
        'Professional Affiliation Not Added Successfully',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
