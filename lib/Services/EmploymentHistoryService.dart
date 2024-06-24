import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tizibane/constants/constants.dart';
import 'package:tizibane/models/EmploymentHistory.dart';

class EmployeeHistoryService extends GetxController {
  final isLoading = false.obs;
  final box = GetStorage();
  final nrcStorage = GetStorage();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  final employeeHistoryDetails = <EmploymentHistory>[].obs;

  final contactEmployeeHistoryDetails = <EmploymentHistory>[].obs;

  Future<void> getEmploymentHistory() async {
    
    String accessToken = await getStoredToken();

    String employeeHistory = await getStoredNrc();

    isLoading.value = true;
    final response = await http.get(
      Uri.parse("$baseUrl$getEmploymentHistoryDetails/$employeeHistory"),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );
    if (response.statusCode == 200) {
      isLoading.value = false;
      List<dynamic> data = jsonDecode(response.body)['employmentHistory'];
      employeeHistoryDetails.value = data.map((e) => EmploymentHistory.fromJson(e)).toList();
      await saveEmployeeHistoryToLocal(employeeHistoryDetails.map((e) => e.toJson()).toList());
      update();
    }else if (response.statusCode == 404) {
      isLoading.value = false;
    } else {
      isLoading.value = false;
      Get.snackbar(
        'Error',
        'Failed to Load Employment History',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      print('${response.statusCode} :${response.reasonPhrase}');
    }
  }

  Future<void> loadLocalEmployeeHistory() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.containsKey('employeeHistory')) {
    List<String> employeeHistoryStrings = prefs.getStringList('employeeHistory') ?? [];
    
    List<EmploymentHistory> employeeHistory = employeeHistoryStrings.map((e) {
      var json = jsonDecode(e);
      return EmploymentHistory.fromJson(json);
    }).toList();
    employeeHistoryDetails.value = employeeHistory;
  } else {
    print('No employee history found in SharedPreferences');
  }
}

  Future<void> saveEmployeeHistoryToLocal(List<Map<String, dynamic>> employeeHistory) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> employeeHistoryStrings = employeeHistory.map((e) => jsonEncode(e)).toList();
    await prefs.setStringList('employeeHistory', employeeHistoryStrings);
  }

  Future<void> getContactEmploymentHistory(String contactNrc) async {
    String accessToken = await getStoredToken();

    isLoading.value = true;

    final response = await http.get(
      Uri.parse("$baseUrl$getEmploymentHistoryDetails/$contactNrc"),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );
    if (response.statusCode == 200) {
      isLoading.value = false;
      List<dynamic> data = jsonDecode(response.body)['employmentHistory'];
      contactEmployeeHistoryDetails.value = data.map((e) => EmploymentHistory.fromJson(e)).toList();
      await saveContactEmployeeHistoryToLocal(contactEmployeeHistoryDetails.map((e) => e.toJson()).toList());
      update();
    }else if (response.statusCode == 404) {
      isLoading.value = false;
    } else {
      isLoading.value = false;
      Get.snackbar(
        'Error',
        'Failed to Load Employment History',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      print('${response.statusCode} :${response.reasonPhrase}');
    }
  }
    Future<void> loadLocalContactEmployeeHistory() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.containsKey('employeeContactHistory')) {
    List<String> employeeContactHistoryStrings = prefs.getStringList('employeeContactHistory') ?? [];
    
    List<EmploymentHistory> employeeContactHistory = employeeContactHistoryStrings.map((e) {
      var json = jsonDecode(e);
      return EmploymentHistory.fromJson(json);
    }).toList();
    contactEmployeeHistoryDetails.value = employeeContactHistory;
  } else {
    print('No employee history found in SharedPreferences');
  }
}

  Future<void> saveContactEmployeeHistoryToLocal(List<Map<String, dynamic>> employeeContactHistory) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> employeeContactHistoryStrings = employeeContactHistory.map((e) => jsonEncode(e)).toList();
    await prefs.setStringList('employeeContactHistory', employeeContactHistoryStrings);
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
