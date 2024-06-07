import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:tizibane/constants/constants.dart';
import 'package:tizibane/models/Employee.dart';

class EmployeeService extends GetxController {
  final isLoading = false.obs;
  final box = GetStorage();

  final employeeDetails = Rxn<Employee>();

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> getEmployeeDetails(String employeeId) async {
    String? accessToken = box.read('token');

    isLoading.value = true;
    final response = await http.get(
      Uri.parse("$baseUrl/getEmployeeDetails/$employeeId"),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      isLoading.value = false;
      Map<String, dynamic> data = jsonDecode(response.body);
      employeeDetails.value = Employee.fromJson(data['employee']);
    } else {
      isLoading.value = false;
      Get.snackbar(
        'Error',
        'Failed to Load Employee Details',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      print('${response.statusCode} :${response.reasonPhrase}');
    }
  }

  Future<void> updateEmployeeDetails(Employee employee) async {
    String? accessToken = box.read('token');

    isLoading.value = true;
    final response = await http.put(
      Uri.parse("$baseUrl/updateEmployeeDetails"),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(employee.toJson()),
    );

    if (response.statusCode == 200) {
      isLoading.value = false;
      Get.snackbar(
        'Success',
        'Employee Details Updated Successfully',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } else {
      isLoading.value = false;
      Get.snackbar(
        'Error',
        'Failed to Update Employee Details',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      print('${response.statusCode} :${response.reasonPhrase}');
    }
  }
}
