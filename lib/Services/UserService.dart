import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tizibane/Services/Connectivity.dart';
import 'package:tizibane/Services/localDb/localdb.dart';
import 'package:tizibane/components/bottommenu/BottomMenuBar.dart';
import 'package:tizibane/constants/constants.dart';
import 'package:tizibane/models/User.dart';


class UserService extends GetxService {
  final isLoading = false.obs;
  final isLoaded = false.obs;
  var userObj = <User>[].obs;
  ConnectivityService _connectivityService = Get.put(ConnectivityService());
  final box = GetStorage();
  final url = baseUrl + tizibaneUser;
  final DatabaseHelper _dbHelper = DatabaseHelper();

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
          await _dbHelper.insertUser(userObj.map((user) => user.toJson()).toList());

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

  Future<void> loadLocalData() async {
    try {
      List<Map<String, dynamic>> localData = await _dbHelper.getUsers();
      if (localData.isNotEmpty) {
        userObj.value = localData.map((e) => User.fromJson(e)).toList();
      }
    } catch (error) {
      print('Error loading local data: $error');
    }
  }

  Future<void> saveToLocal(List<Map<String, dynamic>> userData) async {
    await _dbHelper.insertUser(userData);
  }

  Future<String> getStoredToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token') ?? '';
  }

  Future<String> getStoredNrc() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('nrcNumber') ?? '';
  }
}