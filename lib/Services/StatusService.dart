import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tizibane/constants/constants.dart';

class StatusService extends GetxController {
  RxBool isLoading = false.obs;
  final RxMap<String, String> jobStatuses = <String, String>{}.obs;

  Future<void> getJobStatus(String jobListingId) async {
    isLoading.value = true;
    String accessToken = await getStoredToken();
    String storedNrc = await getStoredNrc();

    final response = await http.get(
      Uri.parse("$baseUrl$applicationStatus/$jobListingId/$storedNrc"),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      if (responseData['status'] != null) {
        jobStatuses[jobListingId] = responseData['status'];
      } else {
        jobStatuses[jobListingId] = '';
        throw Exception("Status data is null");
      }
    } else if (response.statusCode == 404) {
      jobStatuses[jobListingId] = '';
    } else {
      jobStatuses[jobListingId] = '';
      throw Exception('Failed to get Job status: ${response.statusCode}');
    }

    isLoading.value = false;
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
