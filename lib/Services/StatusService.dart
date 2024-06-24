import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tizibane/constants/constants.dart';

class StatusService extends GetxController {
  RxBool isLoading = false.obs;

  RxBool isVisible = false.obs;

  final box = GetStorage();

  final nrcStorage = GetStorage();

  RxString status = ''.obs;

  Future<void> getJobStatus(String jobListingId) async {
    isLoading.value = true;
      String accessToken = await getStoredToken();
      String storedNrc = await getStoredNrc();
      status.value = '';
    final response = await http.get(
      Uri.parse("$baseUrl$applicationStatus/$jobListingId/$storedNrc"),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      isLoading.value = false;
      var responseData = jsonDecode(response.body);
      if (responseData['status'] != null) {
        status.value = responseData['status'];
        isLoading.value = false;
        print(status.value );
      } else {
        status.value = '';
        isLoading.value = false;
        throw Exception("Status data is null");
      }
    } else if (response.statusCode == 404) {
      status.value = '';
      isLoading.value = false;
    } else {
      status.value = '';
      isLoading.value = false;
      throw Exception('Failed to get Job status: ${response.statusCode}');
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
}
