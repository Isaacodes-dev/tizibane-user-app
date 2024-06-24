import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tizibane/constants/constants.dart';
import 'package:tizibane/models/Employee.dart';

class EmployeeService extends GetxController {
  final isLoading = false.obs;
  final box = GetStorage();

  // Change employeeDetails to store a list of employees
  final employeeDetails = <Employee>[].obs;

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> getEmployeeDetails(String employeeId) async {
    String accessToken = await getStoredToken();
    print(employeeId);
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
      employeeDetails.add(Employee.fromJson(data['employee']));
    } else {
      isLoading.value = false;
      // Get.snackbar(
      //   'Error',
      //   'Failed to Load Employee Details',
      //   snackPosition: SnackPosition.TOP,
      //   backgroundColor: Colors.red,
      //   colorText: Colors.white,
      // );
      print('${response.statusCode} :${response.reasonPhrase}');
    }
  }

  Future<void> loadLocalEmployee() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('employee')) {
      List<String> employeeStrings = prefs.getStringList('employee') ?? [];

      List<Employee> employees = employeeStrings.map((e) {
        var json = jsonDecode(e);
        return Employee.fromJson(json);
      }).toList();
      employeeDetails.addAll(employees);
    } else {
      print('No employee found in SharedPreferences');
    }
  }

  Future<void> saveEmployeesToLocal(List<Employee> employees) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> employeeStrings = employees.map((e) => jsonEncode(e.toJson())).toList();
    await prefs.setStringList('employee', employeeStrings);
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
