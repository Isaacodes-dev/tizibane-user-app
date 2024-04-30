import 'dart:ffi';

import 'package:contacts_service/contacts_service.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tizibane/Services/Connectivity.dart';
import 'package:tizibane/Services/ContactService.dart';
import 'package:tizibane/Services/EmploymentHistoryService.dart';
import 'package:tizibane/Services/ProfileService.dart';
import 'package:tizibane/Services/UserService.dart';
import 'package:tizibane/components/bottommenu/BottomMenuBar.dart';
import 'package:tizibane/models/Contact.dart';
import 'package:tizibane/models/EmploymentHistory.dart';
import 'package:tizibane/models/LoginUser.dart';
import 'package:tizibane/constants/constants.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'dart:convert';
import 'package:tizibane/models/User.dart';
import 'package:tizibane/screens/Login.dart';
import 'package:tizibane/screens/ProfileScreen/EmployeeHistory.dart';

class AuthService extends GetxController {
  final UserService _userService = Get.put(UserService());

  final ProfileService _profileService = Get.put(ProfileService());

  final ContactService _contactService = Get.put(ContactService());

  final EmployeeHistoryService _employeeHistory =
      Get.put(EmployeeHistoryService());

  final isLoading = false.obs;

  final token = ''.obs;

  final box = GetStorage();

  final nrcStorage = GetStorage();

  final rememberMeValue = GetStorage();

  final RxBool rememberMe = false.obs;

  ConnectivityService _connectivityService = Get.put(ConnectivityService());

  @override
  void onInit() {
    super.onInit();
    rememberMe.value = rememberMeValue.read('rememberMe') ?? false;
  }

  void toggleRememberMe(bool value) {
    rememberMe.value = value;
    rememberMeValue.write('rememberMe', value);
  }

  Future<void> createUser({
    required String nrc,
    required String first_name,
    required String last_name,
    required String phone_number,
    required String email,
    required String password,
  }) async {
    try {
      final url = baseUrl + register;
      isLoading.value = true;

      final data = {
        'nrc': nrc,
        'first_name': first_name,
        'last_name': last_name,
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

        Get.offAll(() => Login());
      } else {
        isLoading.value = false;
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
    if (_connectivityService.isConnected.value) {
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
          print(rememberMe.value);
          if (rememberMe.value) {
            box.write('password', password);
          }

          Get.offAll(() => BottomMenuBarItems(
                selectedIndex: 0,
              ));
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

            box.remove('token');
          } else {
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
  }

  Future<void> saveRememberMe(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('rememberMe', value);
  }

  Future<bool> getRememberMe() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('rememberMe') ?? false; 
  }

  Future<void> logOut() async {
    try {
      final url = baseUrl + logout;

      isLoading.value = true;

      String? accessToken = token.value;

      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        isLoading.value = false;

        box.remove('token');

        nrcStorage.remove('nrcNumber');

        rememberMeValue.remove('rememberMe');

        _userService.userObj.value = <User>[].obs;

        _contactService.contactsList.value = <ContactModel>[].obs;

        _contactService.foundContacts.value = <ContactModel>[].obs;

        _employeeHistory.contactEmployeeHistoryDetails.value =
            <EmploymentHistory>[].obs;

        _employeeHistory.employeeHistoryDetails.value =
            <EmploymentHistory>[].obs;

        Get.snackbar(
          'Success',
          'You have logged out Successfully',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        await Future.delayed(Duration(milliseconds: 500));

        Get.offAll(Login());
      } else {
        Get.snackbar(
          'Error',
          'Logout not successful',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        print(response.body);
        isLoading.value = false;
      }
    } catch (e) {
      print('Error: $e');
      isLoading.value = false;
    }
  }
}
