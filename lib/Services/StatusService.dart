import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tizibane/Services/Connectivity.dart';
import 'package:tizibane/Services/localDb/localdb.dart';
import 'package:tizibane/constants/constants.dart';

class StatusService extends GetxController {
  RxBool isLoading = false.obs;
  final RxMap<String, String> jobStatuses = <String, String>{}.obs;
  final ConnectivityService _connectivityService = Get.put(ConnectivityService());
  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<void> getJobStatus(String jobListingId) async {
    isLoading.value = true;

    // Check connectivity
    if (_connectivityService.isConnected.value) {
      // Fetch status from remote server
      await _fetchJobStatusFromRemote(jobListingId);
    } else {
      // Fetch status from local database
      await _fetchJobStatusFromLocal(jobListingId);
    }

    isLoading.value = false;
  }

  Future<void> _fetchJobStatusFromRemote(String jobListingId) async {
    String accessToken = await _getStoredToken();
    String storedNrc = await _getStoredNrc();

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
        jobStatuses[jobListingId] = responseData['status'];
        await _dbHelper.insertJobStatus(jobListingId, responseData['status']);
        isLoading.value = false;
      } else {
        jobStatuses[jobListingId] = 'Not Applied';
        isLoading.value = false;
      }
    } else {
      isLoading.value = false;
      jobStatuses[jobListingId] = 'Not Applied';
    }
  }

  Future<void> _fetchJobStatusFromLocal(String jobListingId) async {
    String? localStatus = await _dbHelper.getJobStatus(jobListingId);
    jobStatuses[jobListingId] = localStatus ?? 'Not Applied';
    isLoading.value = false;
  }

  Future<String> _getStoredToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token') ?? '';
  }

  Future<String> _getStoredNrc() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('nrcNumber') ?? '';
  }
}
