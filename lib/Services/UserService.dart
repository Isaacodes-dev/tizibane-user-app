import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tizibane/Services/Connectivity.dart';
import 'package:tizibane/components/bottommenu/BottomMenuBar.dart';
import 'package:tizibane/constants/constants.dart';
import 'package:tizibane/models/User.dart';

class UserService extends GetxController {
  final isLoading = false.obs;
  final isLoaded = false.obs;
  var userObj =
      <User>[].obs;
  ConnectivityService _connectivityService = Get.put(ConnectivityService());        
  final box = GetStorage();
  final nrcStorage = GetStorage();
  final url = baseUrl + tizibaneUser;

  Future<void> getUser() async {
    bool isConnected = await _connectivityService.checkConnectivity();
    if (isConnected) {
      String accessToken = await getStoredToken();
      String storedNrc = await getStoredNrc();

      isLoading.value = true;
      final response = await http.get(
        Uri.parse("$url/$storedNrc"),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        if (responseData['user'] != null) {
          List<dynamic> data = responseData['user'];
          userObj.value = data.map((e) => User.fromJson(e)).toList();

          // Save the user object to local storage
          await saveToLocal(userObj.map((user) => user.toJson()).toList());

          isLoading.value = false;
          isLoaded.value = true;
        } else {
          isLoading.value = false;
          userObj.value = [];
          throw Exception("User data is null");
        }
      } else {
        isLoading.value = false;
        userObj.value = [];
        throw Exception('Failed to load user data: ${response.statusCode}');
      }
    } else {
      loadLocalData();
    }
  }

  Future<void> saveToLocal(List<Map<String, dynamic>> userData) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user', jsonEncode(userData));
  }

  Future<void> loadLocalData() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('user')) {
      String? userDataString = prefs.getString('user');
      if (userDataString != null) {
        List<dynamic> userData = jsonDecode(userDataString);
        userObj.value = userData.map((e) => User.fromJson(e)).toList();
      }
      else{
        print('No Local Storage');
      }
    }
  }

  Future<String> getStoredToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token') ?? '';
  }

  Future<String> getStoredNrc() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('nrcNumber') ?? '';
  }


  // Future<User> getLocalStorage() async
  // {
  //   final userDetails = box.read('userProfile');
  //   final user = userDetails != null ? User.fromJson(userDetails) : '';
  //   return Future.value(user);
  // }

  Future<void> updateUserDetails({
    required String first_name,
    required String last_name,
    required String phone_number,
    required String email,
  }) async {
    try {
      String accessToken = box.read('token');
      String storedNrc = nrcStorage.read('nrcNumber');
      final url = '$baseUrl$updateUser$storedNrc';
      isLoading.value = true;
       
      final data = {
        'first_name': first_name,
        'last_name': last_name,
        'phone_number': phone_number,
        'email': email,
      };

      final response = await http.put(Uri.parse(url),
          headers: {'Accept': 'application/json','Authorization': 'Bearer $accessToken',}, body: data);

      if (response.statusCode == 200) {
        isLoading.value = false;
        Get.snackbar(
          'Success',
          json.decode(response.body)['message'],
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );        
        await getUser();
        Get.offAll(const BottomMenuBarItems(selectedIndex: 0,));
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

}
