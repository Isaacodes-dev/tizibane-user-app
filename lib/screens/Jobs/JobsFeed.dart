import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tizibane/Services/JobsService.dart';
import 'package:tizibane/Services/ProfileService.dart';
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

  @override
  void initState() {
    super.initState();
       WidgetsBinding.instance!.addPostFrameCallback((_) {
      _jobsService.getJobsFeed();
      _jobsService.foundJobs.value = _jobsService.jobsFeedList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Image.asset(
            'assets/images/tizibaneicon.png',
            width: 50,
            height: 50,
          ),
        ),
      ),
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 32,
                      backgroundColor: Colors.white,
                      child: Obx(() => CircleAvatar(
                        radius: 29,
                        backgroundImage: Image.network(imageBaseUrl + _profileService.imagePath.value).image,
                      )),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Obx(() => Text(
                      'Hi, ${_userService.userObj.value.isNotEmpty ? _userService.userObj.value[0].first_name + ' ' + _userService.userObj.value[0].last_name : ''}',
                      style: GoogleFonts.lexendDeca(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.white),
                      ),
                    )),
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                TextField(
                  onChanged: (value) => _jobsService.filterJobs(value),
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
                )
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
                          return _jobsService.foundJobs.value.isEmpty ? Text("No Jobs To Display") : ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: _jobsService.foundJobs.value.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Get.to(JobDetails(
                                    id: _jobsService.foundJobs.value[index].id!.toString(),
                                  ));
                                },
                                child: JobCard(
                                  position: _jobsService.foundJobs.value[index].position!,
                                  company: _jobsService.foundJobs.value[index].companyName!,
                                  address: _jobsService.foundJobs.value[index].companyAddress!,
                                  closing: _jobsService.foundJobs.value[index].closed!,
                                  companyLogo: _jobsService.foundJobs.value[index].companyLogoUrl!,
                                ),
                              );
                            },
                          );
                        }
                      },
                    ),
                    SizedBox(height: 5,)
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
