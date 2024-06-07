import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tizibane/components/bottommenu/BottomMenuBar.dart';
import 'package:tizibane/constants/constants.dart';
import 'package:tizibane/models/User.dart';

class UserService extends GetxController {
    final isLoading = false.obs;
  final isLoaded = false.obs;
  var userObj =
      <User>[].obs;
          
  final box = GetStorage();
  final nrcStorage = GetStorage();
  final url = baseUrl + tizibaneUser;

  Future<void> getUser() async {
    String accessToken = box.read('token');
    String storedNrc = nrcStorage.read('nrcNumber');
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
         List<dynamic> data = jsonDecode(response.body)['user'];
        userObj.value = data.map((e) => User.fromJson(e)).toList();
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
    update();
  }

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
