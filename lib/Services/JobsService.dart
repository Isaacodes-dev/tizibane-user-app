import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tizibane/components/bottommenu/BottomMenuBar.dart';
import 'package:tizibane/constants/constants.dart';
import 'package:tizibane/models/Company.dart';
import 'package:tizibane/models/JobDetails.dart';
import 'package:tizibane/models/JobFeed.dart';
import 'package:tizibane/models/Position.dart';
import 'package:tizibane/screens/Jobs/uploadCv.dart';
import 'package:path/path.dart' as p;

class JobsService extends GetxController {
  final isLoading = false.obs;

  final box = GetStorage();

  final nrcStorage = GetStorage();

  var jobsFeedList = <JobsFeed>[].obs;

  var jobDetails = Rxn<JobDetails>();

  var positionDetails = Rxn<Position>();

  var companyDetails = Rxn<Company>();

  Rx<List<JobsFeed>> foundJobs = Rx<List<JobsFeed>>([]);

  Future<void> getJobsFeed() async {
    String accessToken = await getStoredToken();
    isLoading.value = true;
    List<dynamic> data = [];
    final response = await http.put(
      Uri.parse(baseUrl + getJobs),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );
    if (response.statusCode == 200) {
      data = jsonDecode(response.body)['data'];
      jobsFeedList.value = data.map((e) => JobsFeed.fromJson(e)).toList();
      isLoading.value = false;
      update();
    } else if (response.statusCode == 401) {
      isLoading.value = false;
    } else if (response.statusCode == 404) {
      isLoading.value = false;
    } else {
      isLoading.value = false;
      Get.snackbar(
        'Error',
        'Failed to Load Jobs',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      print('${response.statusCode} :${response.reasonPhrase}');
    }
  }

  Future<void> getJobDetail(String id) async {
    update();
   String accessToken = await getStoredToken();
    isLoading.value = true;
    final response = await http.put(
      Uri.parse(baseUrl + getJobDetails + id),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['data'];

      jobDetails.value = JobDetails.fromJson(data);
      isLoading.value = false;
    } else if (response.statusCode == 401) {
      isLoading.value = false;
    } else if (response.statusCode == 404) {
      isLoading.value = false;
    } else {
      isLoading.value = false;
      Get.snackbar(
        'Error',
        'Failed to Load Job Details',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      print('${response.statusCode} :${response.reasonPhrase}');
    }
    update();
  }

  Future<void> sendApplication({
     String? jobApplicationLetter,
    String? jobListingId,
  }) async {
    try {
      String accessToken = await getStoredToken();
      String storedNrc = await getStoredNrc();
      final url = baseUrl + postApply;
      isLoading.value = true;

      final data = {
        'application_letter': jobApplicationLetter,
        'nrc': storedNrc,
        'job_listing_id': jobListingId,
      };

      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: data,
      );

      isLoading.value = false;

      if (response.statusCode == 201) {
        Get.snackbar(
          'Success',
          json.decode(response.body)['message'],
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        Get.to(BottomMenuBarItems(selectedIndex: 2,));
      } else {
        Get.snackbar(
          'Error',
          json.decode(response.body)['message'],
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar(
        'Error',
        'An unexpected error occurred. Please try again.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> sendCv({
    required File? curriculumVitaeUrl,
    required String? jobApplication,
    required String? jobId,
  }) async {
    try {
      
      String accessToken = await getStoredToken();
      String storedNrc = await getStoredNrc();
      
      isLoading.value = true;
      
      const url = baseUrl + postCv;

      final request = http.MultipartRequest('POST', Uri.parse(url));

      request.files.add(
        await http.MultipartFile.fromPath(
          'curriculumn_vitae_url',
          curriculumVitaeUrl!.path,
        ),
      );

      request.fields['nrc'] = storedNrc;
      request.fields['curriculumn_vitae_url'] =
          p.basename(curriculumVitaeUrl!.path);

      request.headers.addAll({
        'Accept': 'application/json',
        'Authorization': 'Bearer $accessToken',
      });

      final streamedResponse = await request.send();

      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        isLoading.value = false;
        Get.snackbar(
          'Success',
          json.decode(response.body)['message'],
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        if(jobId != null){
          await sendApplication(jobApplicationLetter: jobApplication, jobListingId: jobId);
        }else{
          Get.to(BottomMenuBarItems(selectedIndex: 3,));
        }
        
      }
      else if (response.statusCode == 201) {
        isLoading.value = false;
        Get.snackbar(
          'Success',
          json.decode(response.body)['message'],
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        if(jobId != null){
          await sendApplication(jobApplicationLetter: jobApplication, jobListingId: jobId);
        }else{
          Get.to(BottomMenuBarItems(selectedIndex: 3,));
        }
      } else {
        isLoading.value = false;
        Get.snackbar(
          'Error',
          json.decode(response.body)['message'],
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      isLoading.value = false;
    }
  }

  void filterJobs(String positionTitle) {
    
    List<JobsFeed> results = [];

    if (positionTitle.trim().isEmpty) {
      results = jobsFeedList;
    } else {
      results = jobsFeedList.where((element) {
        final trimmedContact = positionTitle.toLowerCase().trim();
        final position = '${element.position?.toLowerCase()}';
        return position.contains(trimmedContact);
      }).toList();
    }

    foundJobs.value = results;
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
