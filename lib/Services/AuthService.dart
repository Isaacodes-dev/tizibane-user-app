import 'dart:ffi';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:tizibane/Services/ProfileService.dart';
import 'package:tizibane/Services/UserService.dart';
import 'package:tizibane/components/bottommenu/BottomMenuBar.dart';
import 'package:tizibane/models/LoginUser.dart';
import 'package:tizibane/constants/constants.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'dart:convert';
import 'package:tizibane/models/User.dart';
import 'package:tizibane/screens/Login.dart';

class AuthService extends GetxController {
  final UserService _userService = Get.put(UserService());

  final ProfileService _profileService = Get.put(ProfileService());
  final isLoading = false.obs;

  final token = ''.obs;

  final box = GetStorage();

  final nrcStorage = GetStorage();

  Future<void> createUser({
    required String nrc,
    required String full_names,
    required String phone_number,
    required String email,
    required String password,
  }) async {
    try {
      final url = baseUrl + register;
      isLoading.value = true;

      final data = {
        'nrc': nrc,
        'full_names': full_names,
        'phone_number': phone_number,
        'email': email,
        'password': password,
      };

      final response = await http.post(Uri.parse(url),
          headers: {'Accept': 'application/json'}, body: data);

      if (response.statusCode == 201) {
        isLoading.value = false;
        Get.snackbar(
          'Success',
          json.decode(response.body)['message'],
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        _profileService.setDefaultPicture(nrc);
        //Get.offAll(() => Login());
      } else {
        isLoading.value = false;
        print(json.decode(response.body)['message']);
        Get.snackbar(
          'Error',
          json.decode(response.body)['message'],
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      print('Error: $e');
      isLoading.value = false;
    }
  }

  Future<void> loginUser({
    required String nrc,
    required String password,
  }) async {
    try {
      final url = baseUrl + login;
      isLoading.value = true;

      final data = {
        'nrc': nrc,
        'password': password,
      };

      final response = await http.post(Uri.parse(url),
          headers: {
            'Accept': 'application/json',
          },
          body: data);

      if (response.statusCode == 200) {
        isLoading.value = false;
        token.value = json.decode(response.body)['token'];
        box.write('token', token.value);
        nrcStorage.write('nrcNumber', nrc);
        Get.offAll(() => BottomMenuBarItems());
      } else {
        isLoading.value = false;
        if (response.statusCode == 401) {
          Get.snackbar(
            'Unauthorized',
            'Please log in again',
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
          // Clear any existing authentication token
          box.remove('token');
          // Optionally, navigate the user to the login screen
          // Get.offAll(()=> LoginScreen());
        } else {
          // Handle other error codes
          Get.snackbar(
            'Error',
            json.decode(response.body)['message'],
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      }
    } catch (e) {
      print('Error: $e');
      isLoading.value = false;
    }
  }

  Future logOut() async {
    try {
      final url = baseUrl + logout;
      isLoading.value = true;
      String? accessToken = token.value;
      final response = await http.post(Uri.parse(url),
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $accessToken',
          },
          );

      if (response.statusCode == 200) {
        isLoading.value = false;
        box.remove('token');
        nrcStorage.remove('nrcNumber');
        _userService.userObj.value = User(nrc: '', full_names: '', phone_number: '', email: '', password: '');
        Get.snackbar(
          'Success',
          'You have logged out Successfully',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        Get.offAll(() => Login());
      } else {
        Get.snackbar(
          'Error',
          'logout not Successfull',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        isLoading.value = false;
      }
    } catch (e) {
      print('Error: $e');
      isLoading.value = false;
    }
  }
}
