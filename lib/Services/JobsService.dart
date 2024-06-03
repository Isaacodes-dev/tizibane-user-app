import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
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
    String? accessToken;
    accessToken = box.read('token');
    isLoading.value = true;
    final response = await http.put(
      Uri.parse(baseUrl + getJobs),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body)['data'];
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
    String? accessToken;
    accessToken = box.read('token');
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
    required String jobApplicationLetter,
    required String jobListingId,
  }) async {
    try {
      String accessToken = box.read('token');
      String nrc = nrcStorage.read('nrcNumber');
      final url = baseUrl + postApply;
      isLoading.value = true;

      final data = {
        'application_letter': jsonEncode(jobApplicationLetter),
        'nrc': nrc,
        'job_listing_id': jobListingId,
      };

      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: data, // Encode the entire body as JSON
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

        Get.defaultDialog(
          title: '',
          contentPadding:
              const EdgeInsets.only(bottom: 20, right: 15, left: 15),
          content: const Text("Do you want to upload an updated CV?"),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Get.back();
                    Get.to(const UploadCv());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  child: Text(
                    "Yes",
                    style: GoogleFonts.lexendDeca(
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                   Get.to(() => BottomMenuBarItems(selectedIndex: 2));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  child: Text(
                    "No",
                    style: GoogleFonts.lexendDeca(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
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
      print('Error: $e');
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
  }) async {
    try {
      String accessToken = box.read('token');
      String nrc = nrcStorage.read('nrcNumber');
      isLoading.value = true;
      final url = baseUrl + postCv;
      final request = http.MultipartRequest('POST', Uri.parse(url));

      // Add curriculum vitae file
      request.files.add(
        await http.MultipartFile.fromPath(
          'curriculum_vitae_file',
          curriculumVitaeUrl!.path,
        ),
      );

      // Add NRC
      request.fields['nrc'] = nrc;
      request.fields['curriculum_vitae_url'] =
          p.basename(curriculumVitaeUrl!.path);

      // Set headers
      request.headers.addAll({
        'Accept': 'application/json',
        'Authorization': 'Bearer $accessToken',
      });

      // Send request
      final streamedResponse = await request.send();

      // Get response
      final response = await http.Response.fromStream(streamedResponse);

      // Check response status code
      if (response.statusCode == 201) {
        isLoading.value = false;
        Get.snackbar(
          'Success',
          json.decode(response.body)['message'],
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
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
      print('Error: $e');
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
        final position =
            '${element.position?.toLowerCase()}';
        return position.contains(trimmedContact);
      }).toList();
    }

    foundJobs.value = results;
  }
}
