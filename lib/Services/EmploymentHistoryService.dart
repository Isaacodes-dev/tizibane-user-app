import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
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
    getEmploymentHistory();
  }

  final employeeHistoryDetails = <EmploymentHistory>[].obs;

  final contactEmployeeHistoryDetails = <EmploymentHistory>[].obs;

  Future<void> getEmploymentHistory() async {
    String accessToken = box.read('token');

    String employeeHistory = nrcStorage.read('nrcNumber');

    isLoading.value = true;
    final response = await http.get(
      Uri.parse(baseUrl + getEmploymentHistoryDetails + "/$employeeHistory"),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );
    
    if (response.statusCode == 200) {
      isLoading.value = false;
      List<dynamic> data = jsonDecode(response.body)['employmentHistory'];
      employeeHistoryDetails.value = data.map((e) => EmploymentHistory.fromJson(e)).toList();
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

  Future<void> getContactEmploymentHistory(String contactNrc) async {
    String accessToken = box.read('token');

    isLoading.value = true;

    final response = await http.get(
      Uri.parse(baseUrl + getEmploymentHistoryDetails + "/$contactNrc"),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );
    if (response.statusCode == 200) {
      isLoading.value = false;
      List<dynamic> data = jsonDecode(response.body)['employmentHistory'];
      contactEmployeeHistoryDetails.value = data.map((e) => EmploymentHistory.fromJson(e)).toList();
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
}
