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
import 'package:tizibane/models/IndividualProfile.dart';
import 'package:tizibane/models/User.dart';

class UserService extends GetxService {
  final isLoading = false.obs;
  final isLoaded = false.obs;
  var userObj = <User>[].obs;
  var individualProfileOject = <IndividualProfile>[].obs;
  String? email;
  ConnectivityService _connectivityService = Get.put(ConnectivityService());
  final box = GetStorage();
  final url = baseUrl + userData;
  final urlIndividualProfile = baseUrl + individualProfile;
  final DatabaseHelper _dbHelper = DatabaseHelper();


Future<void> getUser() async {
  bool isConnected = await _connectivityService.checkConnectivity();
  if (isConnected) {
    // String accessToken = await getStoredToken();
    // String storedNrc = await getStoredNrc();
    final prefs = await SharedPreferences.getInstance();
    //int userId = prefs.getInt('userId') ?? 0;
    email = prefs.getString('email');
    isLoading.value = true;
    final response = await http.get(
      Uri.parse("$url/$email"),
      headers: {
        'Accept': 'application/json',
        // 'Authorization': 'Bearer $accessToken',
      },
    );
    
    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      if (responseData != null && responseData is Map<String, dynamic>) {
        User user = User.fromJson(responseData);
        int userId = user.id;
        userObj.value = [user];

        SharedPreferences preferences = await SharedPreferences.getInstance();
        await preferences.setInt('userId', userId );
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

  Future<void> getIndividualProfile() async {
    try {
      bool isConnected = await _connectivityService.checkConnectivity();
      if (isConnected) {
        final prefs = await SharedPreferences.getInstance();
        int? userId = prefs.getInt('userId');
        isLoading.value = true;
        final response = await http.get(
          Uri.parse("$urlIndividualProfile/$userId"),
          headers: {
            'Accept': 'application/json',
            // 'Authorization': 'Bearer $accessToken',
          },
        );
        if (response.statusCode == 200) {
          var responseData = jsonDecode(response.body);
          if (responseData != null) {
            List<dynamic> data = responseData;
            individualProfileOject.value = data.map((e) => IndividualProfile.fromJson(e)).toList();
          }else{
            print("Error Fecting User data");
          }
        }
      }
    } catch (error) {
      print('Error loading local data: $error');
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
