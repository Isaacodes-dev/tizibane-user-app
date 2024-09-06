import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tizibane/Services/localDb/localdb.dart';
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
  var jobsFeedList = <JobListing>[].obs;
  var jobDetails = Rxn<JobDetails>();
  var positionDetails = Rxn<Position>();
  var companyDetails = Rxn<Company>();
  Rx<List<JobListing>> foundJobs = Rx<List<JobListing>>([]);

  @override
  void onInit() {
    super.onInit();
    _initializeJobs();
  }

  Future<void> _initializeJobs() async {
    await getJobsFeed();
    await getJobsFromLocalStorage();
  }

  Future<void> getJobsFeed() async {
    String accessToken = await getStoredToken();
    isLoading.value = true;
    List<dynamic> data = [];
    final response = await http.get(
      Uri.parse(baseUrl + getJobs),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );
    if (response.statusCode == 200) {
      data = jsonDecode(response.body)['job_listings'];
      jobsFeedList.value = data.map((e) => JobListing.fromJson(e)).toList();
      // Insert fetched data into SQLite database
      // final dbHelper = DatabaseHelper();
      // await dbHelper.deleteJobFeeds(); // Clear existing data
      // for (var job in jobsFeedList.value) {
      //   await dbHelper.insertJobFeed(job.toJson());
      // }

      isLoading.value = false;
      update();
    } else {
      isLoading.value = false;
      handleError(response);
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
    } else {
      isLoading.value = false;
      handleError(response);
    }
    update();
  }

  Future<void> sendApplication(
      {String? jobApplicationLetter,
      String? jobListingId,
      String? individualProfileId,
      String? curriculumVitaeId}) async {
    try {
      String accessToken = await getStoredToken();
      // String storedNrc = await getStoredNrc();
      final url = baseUrl + postApply;
      isLoading.value = true;

      final data = {
        'cover_letter': jobApplicationLetter,
        'curriculum_vitae_id': curriculumVitaeId,
        'job_listing_id': jobListingId,
        'individual_profile_id': individualProfileId
      };
      print(data);
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
        Get.to(BottomMenuBarItems(
          selectedIndex: 1,
        ));
      } else {
        Get.snackbar(
          'Error',
          json.decode(response.body)['message'],
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        print(response.statusCode);
      }
    } catch (e) {
      isLoading.value = false;
      print(e);
      Get.snackbar(
        'Error',
        'An unexpected error occurred. Please try again.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> sendCv(
      {required File? curriculumVitaeUrl,
      required String? jobApplication,
      required String? jobId,
      required int userId,
      required int individualProfileId}) async {
    try {
      String accessToken = await getStoredToken();

      isLoading.value = true;

      const url = baseUrl + postCv;

      final request = http.MultipartRequest('POST', Uri.parse(url));

      request.files.add(
        await http.MultipartFile.fromPath(
          'curriculum_vitae_file',
          curriculumVitaeUrl!.path,
        ),
      );
      request.fields['user_id'] = userId.toString();
      request.fields['individual_profile_id'] = individualProfileId.toString();
      request.fields['curriculum_vitae_file'] =
          p.basename(curriculumVitaeUrl!.path);

      request.headers.addAll({
        'Accept': 'application/json',
        'Authorization': 'Bearer $accessToken',
      });

      final streamedResponse = await request.send();

      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        isLoading.value = false;
        Get.snackbar(
          'Success',
          json.decode(response.body)['message'],
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        print(jobId);
        if (jobId != null) {
          int id = json.decode(response.body)['data']['id'];
          await sendApplication(
              jobApplicationLetter: jobApplication,
              jobListingId: jobId,
              curriculumVitaeId: id.toString(),
              individualProfileId: individualProfileId.toString());
        } else {
          Get.to(BottomMenuBarItems(
            selectedIndex: 1,
          ));
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
        print(response.statusCode);
      }
    } catch (e) {
      isLoading.value = false;
    }
  }

  Future<void> getJobsFromLocalStorage() async {
    isLoading.value = true;
    final dbHelper = DatabaseHelper();
    List<Map<String, dynamic>> jobData = await dbHelper.getJobFeeds();
    jobsFeedList.value = jobData.map((e) => JobListing.fromJson(e)).toList();
    foundJobs.value = jobsFeedList.value;
    isLoading.value = false;
  }

  // void filterJobs(String query) {
  //   List<JobListing> filteredJobs = jobsFeedList.where((job) {
  //     return job.position!.toLowerCase().contains(query.toLowerCase()) ||
  //         job.companyName!.toLowerCase().contains(query.toLowerCase());
  //   }).toList();
  //   foundJobs.value = filteredJobs;
  // }

  Future<String> getStoredToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token') ?? '';
  }

  Future<String> getStoredNrc() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('nrcNumber') ?? '';
  }

  void handleError(http.Response response) {
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
