import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tizibane/components/bottommenu/BottomMenuBar.dart';
import 'package:tizibane/constants/constants.dart';
import 'package:http/http.dart' as http;
import 'package:tizibane/Services/Connectivity.dart';
import 'package:tizibane/models/IndividualProfile.dart';

class IndividualProfileService extends GetxController {
  final RxBool isLoading = false.obs;

  ConnectivityService _connectivityService = Get.put(ConnectivityService());

  final urlIndividualProfile = baseUrl + individualProfile;

  var individualProfileObject = Rx<IndividualProfile?>(null);

  Future<void> createProfile(
      Map<String, dynamic> profileData, XFile? profileImage) async {
    try {
      bool isConnected = await _connectivityService.checkConnectivity();

      if (isConnected) {
        isLoading.value = true;

        final prefs = await SharedPreferences.getInstance();
        int? userId = prefs.getInt('userId');
        print(userId);
        if (userId != null) {
          final url = '$baseUrl$profile/$userId';

          var request = http.MultipartRequest('POST', Uri.parse(url));

          // Add headers
          request.headers.addAll({
            'Content-Type': 'multipart/form-data',
          });

          // Add JSON data as fields
          profileData.forEach((key, value) {
            request.fields[key] = value.toString();
          });

          // Add image if it exists
          if (profileImage != null) {
            request.files.add(await http.MultipartFile.fromPath(
              'profile_picture', // The field name for the image in the request
              profileImage.path,
              filename: basename(profileImage.path),
            ));
          }

          var streamedResponse = await request.send();
          var response = await http.Response.fromStream(streamedResponse);

          if (response.statusCode == 201) {
            isLoading.value = false;
            Get.snackbar(
              'Success',
              'Profile Created Successfully',
              snackPosition: SnackPosition.TOP,
              backgroundColor: Colors.green,
              colorText: Colors.white,
            );
            Get.offAll(() => const BottomMenuBarItems(
                  selectedIndex: 0,
                ));
          } else {
            isLoading.value = false;
            Get.snackbar(
              'Error',
              'Profile Not Created Successfully',
              snackPosition: SnackPosition.TOP,
              backgroundColor: Colors.red,
              colorText: Colors.white,
            );
            print(response.statusCode);
          }
        } else {
          print('Error: User ID not found');
          isLoading.value = false;
          Get.snackbar(
            'Error',
            'Profile Not Created Successfully',
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
        'Profile Not Created Successfully',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> getIndividualProfile() async {
    try {
      bool isConnected = await _connectivityService.checkConnectivity();
      if (isConnected) {
        final prefs = await SharedPreferences.getInstance();
        int? userId = prefs.getInt('returnedId');
        String accessToken = await getStoredToken();

        // Check if userId is null
        if (userId == null) {
          print("User ID is null");
          return;
        }

        print("$urlIndividualProfile/$userId");
        isLoading.value = true;

        final response = await http.get(
          Uri.parse("$urlIndividualProfile/$userId"),
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $accessToken',
          },
        );

        if (response.statusCode == 200) {
          isLoading.value = false;
          var responseData = jsonDecode(response.body);

          // Check if responseData is null
          if (responseData != null) {
            try {
              individualProfileObject.value =
                  IndividualProfile.fromJson(responseData);
              SharedPreferences preferences =
                  await SharedPreferences.getInstance();
              await preferences.setInt(
                  'individualProfileId', individualProfileObject.value!.id);
              // print("Education: ${individualProfileObject.value?.education}");
              // print("Experience: ${individualProfileObject.value?.experience}");
              // print("Experience: ${individualProfileObject.value?.skills}");
              // print("Experience: ${individualProfileObject.value?.identification}");
            } catch (e) {
              print('Error parsing JSON data here: $e');
            }
          } else {
            isLoading.value = false;
            print("Error Fetching User data: responseData is null");
          }
        } else {
          isLoading.value = false;
          print("Error Fetching User data: ${response.statusCode}");
        }
      } else {
        print("No internet connection");
      }
    } catch (error) {
      isLoading.value = false;
      print('Error loading local data: $error');
    }
  }
}

Future<String> getStoredToken() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('token') ?? '';
}
