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
import 'package:tizibane/models/JobDetails.dart';
import 'package:tizibane/screens/Jobs/JobWidget/JobCard.dart';

class WebScrappedJobs extends StatefulWidget {
  const WebScrappedJobs({super.key});

  @override
  State<WebScrappedJobs> createState() => _WebScrappedJobsState();
}

class _WebScrappedJobsState extends State<WebScrappedJobs> {
  final JobsService _jobsService = Get.put(JobsService());
  final UserService _userService = Get.put(UserService());
  final ProfileService _profileService = Get.put(ProfileService());
  final StatusService _statusService = Get.put(StatusService());
  IndividualProfileService _individualProfileService =
      Get.put(IndividualProfileService());
  final ConnectivityService _connectivityService =
      Get.put(ConnectivityService());
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      if (_connectivityService.isConnected.value) {
        await _jobsService.getJobsFeed();
        await _jobsService.getJobsFromLocalStorage();
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

  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.black,
      //   leading: Padding(
      //     padding: const EdgeInsets.only(left: 16.0),
      //     child: Image.asset(
      //       'assets/images/tizibaneicon.png',
      //       width: 50,
      //       height: 50,
      //     ),
      //   ),
      // ),
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
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
                    SizedBox(
                      width: 10,
                    ),
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
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 300, // Set the desired width here
                      child: TextField(
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelText: 'Search',
                          labelStyle: GoogleFonts.lexendDeca(
                            textStyle: TextStyle(color: Colors.white),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 15.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                          prefixIcon: Icon(Icons.search),
                          prefixIconColor: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      height: 48, // Set to match the height of the TextField
                      padding: EdgeInsets.symmetric(
                          horizontal: 15.0), // Adjust padding as needed
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: Colors.white), // Set border color
                        borderRadius: BorderRadius.circular(
                            10.0), // Adjust border radius if needed
                      ),
                      child: Center(
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.search, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            top: 160,
            right: 0,
            left: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
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
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Available Jobs",
                      style: GoogleFonts.lexendDeca(
                        textStyle: TextStyle(fontSize: 16),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Obx(
                      () {
                        if (_jobsService.isLoading.value) {
                          return Center(child: CircularProgressIndicator());
                        } else {
                          return _jobsService.foundJobs.value.isEmpty
                              ? Text("No Jobs To Display")
                              : ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount:
                                      _jobsService.foundJobs.value.length,
                                  itemBuilder: (context, index) {
                                    DateTime jobClosingDate = convertToDate(
                                        _jobsService
                                            .foundJobs.value[index].applicationDeadline.toLocal().toString());
                                    DateTime currentDate = DateTime.now();
                                    bool isJobStillOpen =
                                        jobClosingDate.isAfter(currentDate) ||
                                            jobClosingDate
                                                .isAtSameMomentAs(currentDate);

                                    return GestureDetector(
                                      onTap: () {
                                        if (isJobStillOpen ||
                                            _connectivityService
                                                .isConnected.value) {
                                          // Get.to(JobDetails(
                                          //   id: _jobsService
                                          //       .foundJobs.value[index].id
                                          //       .toString(),
                                          //   statusValue:
                                          //       _statusService.jobStatuses[
                                          //               _jobsService.foundJobs
                                          //                   .value[index].id
                                          //                   .toString()] ??
                                          //           'Not Applied',
                                          // ));
                                        } else {
                                          // showAlertDialog(
                                          //   context,
                                          //   _jobsService.foundJobs.value[index]
                                          //       .position!,
                                          //   _jobsService.foundJobs.value[index]
                                          //       .companyName!,
                                          //   _jobsService
                                          //       .foundJobs.value[index].closed!,
                                          // );
                                        }
                                      },
                                      // child: JobCard(
                                      //   jobListingId: _jobsService
                                      //       .foundJobs.value[index].id
                                      //       .toString(),
                                      //   position: _jobsService
                                      //       .foundJobs.value[index].position!,
                                      //   company: _jobsService.foundJobs
                                      //       .value[index].companyName!,
                                      //   address: _jobsService.foundJobs
                                      //       .value[index].companyAddress!,
                                      //   closing: _jobsService
                                      //       .foundJobs.value[index].closed!,
                                      //   companyLogo: _jobsService.foundJobs
                                      //       .value[index].companyLogoUrl!,
                                      // ),
                                    );
                                  },
                                );
                        }
                      },
                    ),
                    SizedBox(
                      height: 5,
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
