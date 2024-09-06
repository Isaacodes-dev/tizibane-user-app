import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:tizibane/Services/Connectivity.dart';
import 'package:tizibane/Services/Jobs/JobsService.dart';
import 'package:tizibane/Services/ProfileService.dart';
import 'package:tizibane/Services/ProfileServices/IndividualProfileService.dart';
import 'package:tizibane/Services/StatusService.dart';
import 'package:tizibane/Services/UserService.dart';
import 'package:tizibane/constants/constants.dart';
import 'package:tizibane/screens/Jobs/JobDetails.dart';
import 'package:tizibane/screens/Jobs/JobWidget/JobCard.dart';

class JobsFeed extends StatefulWidget {
  const JobsFeed({super.key});

  @override
  State<JobsFeed> createState() => _JobsFeedState();
}

class _JobsFeedState extends State<JobsFeed> {
  final JobsService _jobsService = Get.put(JobsService());
  final UserService _userService = Get.put(UserService());
  final ProfileService _profileService = Get.put(ProfileService());
  final StatusService _statusService = Get.put(StatusService());
  final ConnectivityService _connectivityService =
      Get.put(ConnectivityService());
  IndividualProfileService _individualProfileService =
      Get.put(IndividualProfileService());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      if (_connectivityService.isConnected.value) {
        await _userService.getUser();
        await _jobsService.getJobsFeed();
        _jobsService.foundJobs.value = _jobsService.jobsFeedList;
      } else {
        await _jobsService.getJobsFromLocalStorage();
        _jobsService.foundJobs.value = _jobsService.jobsFeedList;
      }
      for (var job in _jobsService.foundJobs.value) {
        await _statusService.getJobStatus(job.id.toString());
      }
    });
  }

  DateTime convertToDate(String dateString) {
    try {
      return DateFormat('yyyy-MM-dd').parse(dateString);
    } catch (e) {
      print('Error parsing date: $e');
      return DateTime.now(); // Default to current date in case of error
    }
  }

  void showAlertDialog(BuildContext context, String position, String company,
      String closingDate) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Job Closed"),
          content: Text(
              "The job you are trying to apply for is closed.\n\nPosition: $position\nCompany: $company\nClosing Date: $closingDate"),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Column(
              children: [
                SizedBox(height: 10),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 32,
                      backgroundColor: Colors.white,
                      child: Obx(() => CircleAvatar(
                            radius: 29,
                            backgroundImage: CachedNetworkImageProvider(
                              imageBaseUrl +
                                  _individualProfileService
                                      .individualProfileObject
                                      .value!
                                      .profilePicture!,
                            ),
                          )),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Obx(() => Text(
                                'Hi, ${_userService.userObj.value.isNotEmpty ? _userService.userObj.value[0].name : ''}',
                                style: GoogleFonts.lexendDeca(
                                  textStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.white),
                                ),
                              )),
                          GestureDetector(
                            onTap: () {
                              if (_connectivityService.isConnected.value) {
                                _jobsService.getJobsFeed();
                                for (var job in _jobsService.foundJobs.value) {
                                  _statusService
                                      .getJobStatus(job.id.toString());
                                }
                              }
                            },
                            child: Icon(
                              Icons.replay_circle_filled_rounded,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                TextField(
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Search',
                    labelStyle: GoogleFonts.lexendDeca(
                      textStyle: TextStyle(color: Colors.white),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    prefixIcon: Icon(Icons.search),
                    prefixIconColor: Colors.white,
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding:
                        const EdgeInsets.only(top: 15, left: 15, right: 15),
                    height: 220,
                    decoration: const BoxDecoration(
                      color: Color(0xFFEFFFFC),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Text(
                            "Available Jobs",
                            style: GoogleFonts.lexendDeca(
                              textStyle: TextStyle(fontSize: 16),
                            ),
                          ),
                          SizedBox(height: 20),
                          Obx(
                            () {
                              if (_jobsService.isLoading.value) {
                                return Center(
                                    child: CircularProgressIndicator());
                              } else {
                                return _jobsService.foundJobs.value.isEmpty
                                    ? Text("No Jobs To Display")
                                    : ListView.builder(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount:
                                            _jobsService.foundJobs.value.length,
                                        itemBuilder: (context, index) {
                                          DateTime jobClosingDate =
                                              convertToDate(_jobsService
                                                  .foundJobs
                                                  .value[index]
                                                  .applicationDeadline
                                                  .toLocal()
                                                  .toString()
                                                  .substring(0, 10));
                                          DateTime currentDate = DateTime.now();
                                          bool isJobStillOpen = jobClosingDate
                                                  .isAfter(currentDate) ||
                                              jobClosingDate.isAtSameMomentAs(
                                                  currentDate);

                                          return GestureDetector(
                                            onTap: () {
                                              if (isJobStillOpen ||
                                                  _connectivityService
                                                      .isConnected.value) {
                                                Get.to(JobDetails(
                                                  id: _jobsService
                                                      .foundJobs.value[index].id
                                                      .toString(),
                                                  experience: _jobsService
                                                      .foundJobs
                                                      .value[index]
                                                      .experience,
                                                  employementType: _jobsService
                                                      .foundJobs
                                                      .value[index]
                                                      .employmentType,
                                                  title: _jobsService.foundJobs
                                                      .value[index].title,
                                                  companyName: _jobsService
                                                      .foundJobs
                                                      .value[index]
                                                      .company
                                                      .companyName,
                                                  responsobilities: _jobsService
                                                      .foundJobs
                                                      .value[index]
                                                      .responsibilities,
                                                  companyAddress: _jobsService
                                                      .foundJobs
                                                      .value[index]
                                                      .company
                                                      .companyAddress,
                                                  description: _jobsService
                                                      .foundJobs
                                                      .value[index]
                                                      .description,
                                                  companyLogo: _jobsService
                                                      .foundJobs
                                                      .value[index]
                                                      .company
                                                      .companyLogoUrl,
                                                  statusValue: _statusService
                                                              .jobStatuses[
                                                          _jobsService.foundJobs
                                                              .value[index].id
                                                              .toString()] ??
                                                      'Not Applied',
                                                ));
                                              } else {
                                                showAlertDialog(
                                                  context,
                                                  _jobsService.foundJobs
                                                      .value[index].title,
                                                  _jobsService
                                                      .foundJobs
                                                      .value[index]
                                                      .company
                                                      .companyName,
                                                  _jobsService
                                                      .foundJobs
                                                      .value[index]
                                                      .applicationDeadline
                                                      .toLocal()
                                                      .toString()
                                                      .substring(0, 10),
                                                );
                                              }
                                            },
                                            child: JobCard(
                                              jobListingId: _jobsService
                                                  .foundJobs.value[index].id
                                                  .toString(),
                                              position: _jobsService
                                                  .foundJobs.value[index].title,
                                              company: _jobsService
                                                  .foundJobs
                                                  .value[index]
                                                  .company
                                                  .companyName,
                                              address: _jobsService
                                                  .foundJobs
                                                  .value[index]
                                                  .company
                                                  .companyAddress,
                                              closing: 'Deadline: ' +
                                                  _jobsService
                                                      .foundJobs
                                                      .value[index]
                                                      .applicationDeadline
                                                      .toLocal()
                                                      .toString()
                                                      .substring(0, 10),
                                              companyLogo: _jobsService
                                                  .foundJobs
                                                  .value[index]
                                                  .company
                                                  .companyLogoUrl,
                                            ),
                                          );
                                        },
                                      );
                              }
                            },
                          ),
                          SizedBox(height: 5),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding:
                        const EdgeInsets.only(top: 15, left: 15, right: 15),
                    height: 220,
                    decoration: const BoxDecoration(
                      color: Color(0xFFEFFFFC),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Text(
                            "Other Jobs",
                            style: GoogleFonts.lexendDeca(
                              textStyle: TextStyle(fontSize: 16),
                            ),
                          ),
                          SizedBox(height: 20),
                          Obx(
                            () {
                              if (_jobsService.isLoading.value) {
                                return Center(
                                    child: CircularProgressIndicator());
                              } else {
                                return _jobsService.foundJobs.value.isEmpty
                                    ? Text("No Jobs To Display")
                                    : ListView.builder(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount:
                                            _jobsService.foundJobs.value.length,
                                        itemBuilder: (context, index) {
                                          DateTime jobClosingDate =
                                              convertToDate(_jobsService
                                                  .foundJobs
                                                  .value[index]
                                                  .applicationDeadline
                                                  .toLocal()
                                                  .toString()
                                                  .substring(0, 10));
                                          DateTime currentDate = DateTime.now();
                                          bool isJobStillOpen = jobClosingDate
                                                  .isAfter(currentDate) ||
                                              jobClosingDate.isAtSameMomentAs(
                                                  currentDate);

                                          return GestureDetector(
                                            onTap: () {
                                              if (isJobStillOpen ||
                                                  _connectivityService
                                                      .isConnected.value) {
                                                Get.to(JobDetails(
                                                  id: _jobsService
                                                      .foundJobs.value[index].id
                                                      .toString(),
                                                  experience: _jobsService
                                                      .foundJobs
                                                      .value[index]
                                                      .experience,
                                                  employementType: _jobsService
                                                      .foundJobs
                                                      .value[index]
                                                      .employmentType,
                                                  title: _jobsService.foundJobs
                                                      .value[index].title,
                                                  companyName: _jobsService
                                                      .foundJobs
                                                      .value[index]
                                                      .company
                                                      .companyName,
                                                  responsobilities: _jobsService
                                                      .foundJobs
                                                      .value[index]
                                                      .responsibilities,
                                                  companyAddress: _jobsService
                                                      .foundJobs
                                                      .value[index]
                                                      .company
                                                      .companyAddress,
                                                  description: _jobsService
                                                      .foundJobs
                                                      .value[index]
                                                      .description,
                                                  companyLogo: _jobsService
                                                      .foundJobs
                                                      .value[index]
                                                      .company
                                                      .companyLogoUrl,
                                                  statusValue: _statusService
                                                              .jobStatuses[
                                                          _jobsService.foundJobs
                                                              .value[index].id
                                                              .toString()] ??
                                                      'Not Applied',
                                                ));
                                              } else {
                                                showAlertDialog(
                                                  context,
                                                  _jobsService.foundJobs
                                                      .value[index].title,
                                                  _jobsService
                                                      .foundJobs
                                                      .value[index]
                                                      .company
                                                      .companyName,
                                                  _jobsService
                                                      .foundJobs
                                                      .value[index]
                                                      .applicationDeadline
                                                      .toLocal()
                                                      .toString()
                                                      .substring(0, 10),
                                                );
                                              }
                                            },
                                            child: JobCard(
                                              jobListingId: _jobsService
                                                  .foundJobs.value[index].id
                                                  .toString(),
                                              position: _jobsService
                                                  .foundJobs.value[index].title,
                                              company: _jobsService
                                                  .foundJobs
                                                  .value[index]
                                                  .company
                                                  .companyName,
                                              address: _jobsService
                                                  .foundJobs
                                                  .value[index]
                                                  .company
                                                  .companyAddress,
                                              closing: 'Deadline: ' +
                                                  _jobsService
                                                      .foundJobs
                                                      .value[index]
                                                      .applicationDeadline
                                                      .toLocal()
                                                      .toString()
                                                      .substring(0, 10),
                                              companyLogo: _jobsService
                                                  .foundJobs
                                                  .value[index]
                                                  .company
                                                  .companyLogoUrl,
                                            ),
                                          );
                                        },
                                      );
                              }
                            },
                          ),
                          SizedBox(height: 5),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
