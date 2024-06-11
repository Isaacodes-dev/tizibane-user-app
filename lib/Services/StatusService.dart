import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:tizibane/constants/constants.dart';

class StatusService extends GetxController {
  RxBool isLoading = false.obs;

  RxBool isVisible = false.obs;

  final box = GetStorage();

  final nrcStorage = GetStorage();

  var status = ''.obs;

  Future<void> getJobStatus(String jobListingId) async {
    String accessToken = box.read('token');

    String storedNrc = nrcStorage.read('nrcNumber');
    status.value = '';
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
        status.value = responseData['status'];
      } else {
        status.value = '';
        throw Exception("Status data is null");
      }
    } else if (response.statusCode == 404) {
      status.value = '';
    } else {
      status.value = '';
      throw Exception('Failed to get Job status: ${response.statusCode}');
    }
  }
}
