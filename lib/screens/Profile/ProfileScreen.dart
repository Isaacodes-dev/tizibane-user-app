// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tizibane/Services/ProfileService.dart';
import 'package:tizibane/Services/ProfileServices/IndividualProfileService.dart';
import 'package:tizibane/Services/UserService.dart';
import 'package:tizibane/constants/constants.dart';
import 'package:tizibane/models/Education.dart';
import 'package:tizibane/screens/Profile/EditBasicDetails.dart';
import 'package:tizibane/screens/Profile/EditProfileScreen.dart';
import 'package:tizibane/screens/Profile/EditScreens/AddEducation.dart';
import 'package:tizibane/screens/Profile/EditScreens/AddExperience.dart';
import 'package:tizibane/screens/Profile/EditScreens/AddProfessionalAffliations.dart';
import 'package:tizibane/screens/Profile/EditScreens/AddSkill.dart';
import 'package:tizibane/screens/Profile/EditScreens/EditEducation.dart';
import 'package:tizibane/screens/Profile/EditScreens/EditExperience.dart';
import 'package:tizibane/screens/Profile/EditScreens/EditProfessionalAffliations.dart';
import 'package:tizibane/screens/Profile/EditScreens/EditSkill.dart';
import 'package:tizibane/screens/Profile/EditScreens/EditUserProfile.dart';

class JobExperience {
  final String company;
  final String from;
  final String to;
  final String position;

  JobExperience({
    required this.company,
    required this.from,
    required this.to,
    required this.position,
  });
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileService _profileService = Get.put(ProfileService());
  final UserService _userService = Get.put(UserService());
  IndividualProfileService _individualProfileService =
      Get.put(IndividualProfileService());
  int currentStep = 0;

  @override
  void initState() {
    super.initState();
    _userService.getUser();
    _individualProfileService.getIndividualProfile();
  }

  void _updateStep(int index) {
    setState(() {
      currentStep = index;
    });
  }

  Widget buildStepIndicator(bool isActive) {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        color: isActive ? Colors.black : Colors.grey,
        shape: BoxShape.circle,
      ),
    );
  }

  Widget buildVerticalLine(bool isActive) {
    return Container(
      width: 2,
      height: 50,
      color: isActive ? Colors.black : Colors.grey,
    );
  }

  Widget buildStepDetails(
      JobExperience jobExperience, bool isActive, int index) {
    return GestureDetector(
      onTap: () => _updateStep(index),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                jobExperience.position,
                style: TextStyle(
                  color: isActive ? Colors.black : Colors.grey,
                  fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              Text(
                jobExperience.company,
                style: TextStyle(
                  color: isActive ? Colors.black : Colors.grey,
                  fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              Text(
                '${jobExperience.from} - ${jobExperience.to}',
                style: TextStyle(
                  color: isActive ? Colors.black : Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // Check if the profile data is loading
      if (_individualProfileService.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      // Check if the profile data is available
      final profileData =
          _individualProfileService.individualProfileObject.value;
      if (profileData == null) {
        return Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('No profile data available'),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () => Get.to(EditBasicDetails()),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Text(
                  'Create Profile',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          ],
        ));
      }
      // Check if education data is available
      final educationList = profileData.education ?? [];

      // Check if job experience data is available
      final jobExperiences = profileData.experience ?? [];

      final professionalAffiliationsList =
          profileData.professionalAffiliations ?? [];

      final skillsList = profileData.skills ?? [];

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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Profile',
                        style: GoogleFonts.lexendDeca(
                          textStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.white),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.to(EditUserProfile(
                            selectedTitle: profileData.title!,
                            selectedStatus: profileData.openToWork!.toString(),
                            about: profileData.about!,
                            gender: profileData.gender!,
                            imagePath: profileData.profilePicture!,
                            phoneNumber: profileData.phoneNumber!,
                            address: profileData.address!,
                          ));
                        },
                        child:
                            const Icon(Icons.edit_square, color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              top: 95,
              right: 0,
              left: 0,
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.only(top: 75, left: 15, right: 15),
                height: 220,
                decoration: const BoxDecoration(
                  color: Color(0xFFEFFFFC),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 55,
              left: 20,
              child: ClipOval(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    child: CachedNetworkImage(
                      imageUrl: imageBaseUrl + profileData.profilePicture!,
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          Image.asset('assets/images/user.jpg'),
                      fit: BoxFit.cover,
                      width: 90,
                      height: 90,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 155,
              left: 20,
              right: 0,
              bottom: 0,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  double containerWidth = constraints.maxWidth * 0.9;

                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Text(
                              _userService.userObj.value[0].name,
                              style: GoogleFonts.lexendDeca(
                                textStyle: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Text(
                              _individualProfileService
                                  .individualProfileObject.value!.phoneNumber!,
                              style: GoogleFonts.lexendDeca(
                                textStyle: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Text(
                              _userService.userObj.value[0].email,
                              style: GoogleFonts.lexendDeca(
                                textStyle: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Text(
                              _individualProfileService
                                  .individualProfileObject.value!.address!,
                              style: GoogleFonts.lexendDeca(
                                textStyle: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Text(
                          'About',
                          style: GoogleFonts.lexendDeca(
                            textStyle: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.black),
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          padding: EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(color: Colors.black),
                          ),
                          width: containerWidth,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                profileData.about!,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.only(right: 40.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Education',
                                style: GoogleFonts.lexendDeca(
                                  textStyle: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.black),
                                ),
                              ),
                              Container(
                                width: 25.0,
                                height: 25.0,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: FittedBox(
                                    child: IconButton(
                                      iconSize: 40.0,
                                      icon: Icon(Icons.add),
                                      color: Colors.white,
                                      onPressed: () {
                                        Get.to(AddEducation());
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        // Horizontal scrolling for education cards
                        educationList.isEmpty
                            ? Text('No education data available')
                            : Container(
                                height:
                                    150, // Set height for horizontal list view
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: educationList.length,
                                  itemBuilder: (context, index) {
                                    final educationItem = educationList[index];
                                    return GestureDetector(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text('Education Details'),
                                              content: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Icon(Icons.school),
                                                      SizedBox(width: 10),
                                                      Flexible(
                                                        child: Text(
                                                          educationItem.degree!,
                                                          softWrap: true,
                                                          overflow: TextOverflow
                                                              .visible,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 10),
                                                  Row(
                                                    children: [
                                                      Icon(Icons.apartment),
                                                      SizedBox(width: 10),
                                                      Flexible(
                                                        child: Text(
                                                          educationItem
                                                              .institutionName!,
                                                          softWrap: true,
                                                          overflow: TextOverflow
                                                              .visible,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 10),
                                                  Row(
                                                    children: [
                                                      Icon(Icons.date_range),
                                                      SizedBox(width: 10),
                                                      Flexible(
                                                        child: Text(
                                                          'Graduated: ' +
                                                              educationItem
                                                                  .endDate
                                                                  .toLocal()
                                                                  .toString()
                                                                  .substring(
                                                                      0, 10),
                                                          softWrap: true,
                                                          overflow: TextOverflow
                                                              .visible,
                                                        ),
                                                      ),
                                                      SizedBox(height: 10),
                                                    ],
                                                  ),
                                                  SizedBox(height: 20),
                                                  ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                            primary:
                                                                Colors.black),
                                                    onPressed: () {
                                                      Get.to(EditEducation(
                                                        id: educationItem.id,
                                                        institution: educationItem
                                                            .institutionName!,
                                                        degree: educationItem
                                                            .degree!,
                                                        fieldOfStudy:
                                                            educationItem
                                                                .fieldOfStudy!,
                                                        grade: educationItem
                                                            .grade!,
                                                        startDate: educationItem
                                                            .startDate
                                                            .toLocal()
                                                            .toString()
                                                            .substring(0, 10),
                                                        endDate: educationItem
                                                            .endDate!
                                                            .toLocal()
                                                            .toString()
                                                            .substring(0, 10),
                                                      ));
                                                    },
                                                    child: Text('Edit'),
                                                  ),
                                                ],
                                              ),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text('Close'),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                            width: 1.5,
                                            color: Colors.black,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Container(
                                          padding: EdgeInsets.all(16.0),
                                          width: containerWidth *
                                              1, // Adjust width
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const SizedBox(height: 10),
                                              Row(
                                                children: [
                                                  Icon(Icons.school),
                                                  SizedBox(width: 10),
                                                  Flexible(
                                                    child: Text(
                                                      educationItem.degree!,
                                                      softWrap: true,
                                                      overflow:
                                                          TextOverflow.visible,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 10),
                                              Row(
                                                children: [
                                                  Icon(Icons.apartment),
                                                  SizedBox(width: 10),
                                                  Flexible(
                                                    child: Text(
                                                      educationItem
                                                          .institutionName!,
                                                      softWrap: true,
                                                      overflow:
                                                          TextOverflow.visible,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 10),
                                              Row(
                                                children: [
                                                  Icon(Icons.date_range),
                                                  SizedBox(width: 10),
                                                  Flexible(
                                                    child: Text(
                                                      'Graduated: ' +
                                                          educationItem.endDate
                                                              .toLocal()
                                                              .toString()
                                                              .substring(0, 10),
                                                      softWrap: true,
                                                      overflow:
                                                          TextOverflow.visible,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                        SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.only(right: 40.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Skills',
                                style: GoogleFonts.lexendDeca(
                                  textStyle: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.black),
                                ),
                              ),
                              Container(
                                width: 25.0,
                                height: 25.0,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: FittedBox(
                                    child: IconButton(
                                      iconSize: 40.0,
                                      icon: Icon(Icons.add),
                                      color: Colors.white,
                                      onPressed: () {
                                        Get.to(AddSkill());
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        skillsList.isEmpty
                            ? Text('No skills data available')
                            : Container(
                                height: 150,
                                width: containerWidth * 1,
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      width: 1.5,
                                      color: Colors.black,
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(
                                        8.0), // Padding around the skill boxes
                                    child: Wrap(
                                      spacing:
                                          8.0, // Horizontal space between skill boxes
                                      runSpacing:
                                          8.0, // Vertical space between skill boxes
                                      children: skillsList.isEmpty
                                          ? [
                                              Text('No skills data available',
                                                  style:
                                                      TextStyle(fontSize: 16))
                                            ]
                                          : skillsList.map((skill) {
                                              return GestureDetector(
                                                onTap: () {
                                                  showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                        title: Text(
                                                            'Skill Details'),
                                                        content: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Icon(Icons
                                                                    .label),
                                                                SizedBox(
                                                                    width: 10),
                                                                Flexible(
                                                                  child: Text(
                                                                    skill
                                                                        .skillName!,
                                                                    softWrap:
                                                                        true,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .visible,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                                height: 10),
                                                            Row(
                                                              children: [
                                                                Icon(Icons
                                                                    .bar_chart),
                                                                SizedBox(
                                                                    width: 10),
                                                                Flexible(
                                                                  child: Text(
                                                                    'Proficiency Level: ' +
                                                                        skill
                                                                            .proficiencyLevel!,
                                                                    softWrap:
                                                                        true,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .visible,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                                height: 20),
                                                            ElevatedButton(
                                                              style: ElevatedButton
                                                                  .styleFrom(
                                                                      primary:
                                                                          Colors
                                                                              .black),
                                                              onPressed: () {
                                                                Get.to(
                                                                    EditSkill(
                                                                  skillName: skill
                                                                      .skillName!,
                                                                  proficiencyLevel:
                                                                      skill
                                                                          .proficiencyLevel!,
                                                                  skillId:
                                                                      skill.id,
                                                                ));
                                                              },
                                                              child:
                                                                  Text('Edit'),
                                                            ),
                                                          ],
                                                        ),
                                                        actions: [
                                                          TextButton(
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                            child:
                                                                Text('Close'),
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  );
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 10.0,
                                                      vertical:
                                                          5.0), // Adjust padding as needed
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: Colors.black,
                                                      width: 1.5,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  child: Text(
                                                    skill.skillName!,
                                                    style: TextStyle(
                                                      fontSize:
                                                          14.0, // Adjust font size as needed
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }).toList(),
                                    ),
                                  ),
                                ),
                              ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 40.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Job Experiences',
                                style: GoogleFonts.lexendDeca(
                                  textStyle: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.black),
                                ),
                              ),
                              Container(
                                width: 25.0,
                                height: 25.0,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: FittedBox(
                                    child: IconButton(
                                      iconSize: 40.0,
                                      icon: Icon(Icons.add),
                                      color: Colors.white,
                                      onPressed: () {
                                        Get.to(AddExperience());
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        // Horizontal scrolling for job experience cards
                        jobExperiences.isEmpty
                            ? Text('No job experiences available')
                            : Container(
                                height:
                                    150, // Set height for horizontal list view
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: jobExperiences.length,
                                  itemBuilder: (context, index) {
                                    final jobExperience = jobExperiences[index];
                                    return GestureDetector(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text(
                                                  'Job Experience Details'),
                                              content: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Icon(Icons.apartment),
                                                      SizedBox(width: 10),
                                                      Flexible(
                                                        child: Text(
                                                          jobExperience
                                                              .companyName!,
                                                          softWrap: true,
                                                          overflow: TextOverflow
                                                              .visible,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 10),
                                                  Row(
                                                    children: [
                                                      Icon(Icons.work),
                                                      SizedBox(width: 10),
                                                      Flexible(
                                                        child: Text(
                                                          jobExperience
                                                              .jobTitle!,
                                                          softWrap: true,
                                                          overflow: TextOverflow
                                                              .visible,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 10),
                                                  Row(
                                                    children: [
                                                      Icon(Icons.description),
                                                      SizedBox(width: 10),
                                                      Flexible(
                                                        child: Text(
                                                          jobExperience
                                                              .responsibilities!,
                                                          softWrap: true,
                                                          overflow: TextOverflow
                                                              .visible,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 10),
                                                  Row(
                                                    children: [
                                                      Icon(Icons.date_range),
                                                      SizedBox(width: 10),
                                                      Flexible(
                                                        child: Text(
                                                          jobExperience
                                                                  .startDate!
                                                                  .toLocal()
                                                                  .toString()
                                                                  .substring(
                                                                      0, 10) +
                                                              ' - ' +
                                                              jobExperience
                                                                  .endDate!
                                                                  .toLocal()
                                                                  .toString()
                                                                  .substring(
                                                                      0, 10),
                                                          softWrap: true,
                                                          overflow: TextOverflow
                                                              .visible,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 20),
                                                  ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                            primary:
                                                                Colors.black),
                                                    onPressed: () {
                                                      Get.to(EditExperience(
                                                        id: jobExperience.id,
                                                        companyName:
                                                            jobExperience
                                                                .companyName!,
                                                        jobTitle: jobExperience
                                                            .jobTitle!,
                                                        responsibilities:
                                                            jobExperience
                                                                .responsibilities!,
                                                        startDate: jobExperience
                                                            .startDate!
                                                            .toLocal()
                                                            .toString()
                                                            .substring(0, 10),
                                                        endDate: jobExperience
                                                            .endDate!
                                                            .toLocal()
                                                            .toString()
                                                            .substring(0, 10),
                                                      ));
                                                    },
                                                    child: Text('Edit'),
                                                  ),
                                                ],
                                              ),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text('Close'),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                            width: 1.5,
                                            color: Colors.black,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Container(
                                          padding: EdgeInsets.all(16.0),
                                          width: containerWidth *
                                              1, // Adjust width
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const SizedBox(height: 10),
                                              Row(
                                                children: [
                                                  Icon(Icons.apartment),
                                                  SizedBox(width: 10),
                                                  Text(jobExperience
                                                      .companyName!),
                                                ],
                                              ),
                                              SizedBox(height: 10),
                                              Row(
                                                children: [
                                                  Icon(Icons.work),
                                                  SizedBox(width: 10),
                                                  Text(jobExperience.jobTitle!),
                                                ],
                                              ),
                                              SizedBox(height: 10),
                                              Row(
                                                children: [
                                                  Icon(Icons.date_range),
                                                  SizedBox(width: 10),
                                                  Text(jobExperience.startDate!
                                                          .toLocal()
                                                          .toString()
                                                          .substring(0, 10) +
                                                      ' - ' +
                                                      jobExperience.endDate!
                                                          .toLocal()
                                                          .toString()
                                                          .substring(0, 10)),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                        SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.only(right: 40.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Professional Affiliations',
                                style: GoogleFonts.lexendDeca(
                                  textStyle: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.black),
                                ),
                              ),
                              Container(
                                width: 25.0,
                                height: 25.0,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: FittedBox(
                                    child: IconButton(
                                      iconSize: 40.0,
                                      icon: Icon(Icons.add),
                                      color: Colors.white,
                                      onPressed: () {
                                        Get.to(AddProfessionalAffiliations());
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        // Horizontal scrolling for professional affiliations cards
                        professionalAffiliationsList.isEmpty
                            ? Text('No professional affiliations available')
                            : Container(
                                height:
                                    185, // Set height for horizontal list view
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount:
                                      professionalAffiliationsList.length,
                                  itemBuilder: (context, index) {
                                    final affiliation =
                                        professionalAffiliationsList[index];
                                    return GestureDetector(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text(
                                                  'Professional Affiliation Details'),
                                              content: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Icon(Icons.credit_card),
                                                      SizedBox(width: 10),
                                                      Flexible(
                                                        child: Text(
                                                          affiliation
                                                              .membershipId!,
                                                          softWrap: true,
                                                          overflow: TextOverflow
                                                              .visible,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 10),
                                                  Row(
                                                    children: [
                                                      Icon(Icons.apartment),
                                                      SizedBox(width: 10),
                                                      Flexible(
                                                        child: Text(
                                                          affiliation
                                                              .organizationName!,
                                                          softWrap: true,
                                                          overflow: TextOverflow
                                                              .visible,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 10),
                                                  Row(
                                                    children: [
                                                      Icon(Icons.person),
                                                      SizedBox(width: 10),
                                                      Flexible(
                                                        child: Text(
                                                          affiliation.role!,
                                                          softWrap: true,
                                                          overflow: TextOverflow
                                                              .visible,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 10),
                                                  Row(
                                                    children: [
                                                      Icon(Icons.date_range),
                                                      SizedBox(width: 10),
                                                      Text('Valid From: '),
                                                      Flexible(
                                                        child: Text(
                                                          affiliation.validFrom
                                                              .toLocal()
                                                              .toString()
                                                              .substring(0, 10),
                                                          softWrap: true,
                                                          overflow: TextOverflow
                                                              .visible,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 20),
                                                  Row(
                                                    children: [
                                                      Icon(Icons.date_range),
                                                      SizedBox(width: 10),
                                                      Text('Valid Till: '),
                                                      Flexible(
                                                        child: Text(
                                                          affiliation.validTo
                                                              .toLocal()
                                                              .toString()
                                                              .substring(0, 10),
                                                          softWrap: true,
                                                          overflow: TextOverflow
                                                              .visible,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 20),
                                                  ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                            primary:
                                                                Colors.black),
                                                    onPressed: () {
                                                      Get.to(EditProfessionalAffiliations(
                                                        id: affiliation.id,
                                                          organizationName:
                                                              affiliation
                                                                  .organizationName!,
                                                          membershipId:
                                                              affiliation
                                                                  .membershipId!,
                                                          role: affiliation
                                                              .role!,
                                                          validFromDate:
                                                              affiliation
                                                                  .validFrom!
                                                                  .toLocal()
                                                                  .toString()
                                                                  .substring(0,
                                                                      10),
                                                          validToDate:
                                                              affiliation
                                                                  .validTo!
                                                                  .toLocal()
                                                                  .toString()
                                                                  .substring(
                                                                      0, 10)));
                                                    },
                                                    child: Text('Edit'),
                                                  ),
                                                ],
                                              ),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text('Close'),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                            width: 1.5,
                                            color: Colors.black,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Container(
                                          padding: EdgeInsets.all(16.0),
                                          width: containerWidth *
                                              1, // Adjust width
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(height: 10),
                                              Row(
                                                children: [
                                                  Icon(Icons.credit_card),
                                                  SizedBox(width: 10),
                                                  Text(affiliation
                                                      .membershipId!),
                                                ],
                                              ),
                                              const SizedBox(height: 10),
                                              Row(
                                                children: [
                                                  Icon(Icons.apartment),
                                                  SizedBox(width: 10),
                                                  Text(affiliation
                                                      .organizationName!),
                                                ],
                                              ),
                                              SizedBox(height: 10),
                                              Row(
                                                children: [
                                                  Icon(Icons.person),
                                                  SizedBox(width: 10),
                                                  Text(affiliation.role!),
                                                ],
                                              ),
                                              SizedBox(height: 10),
                                              Row(
                                                children: [
                                                  Icon(Icons.date_range),
                                                  SizedBox(width: 10),
                                                  Text('Valid Till: '),
                                                  Text(
                                                    affiliation.validTo
                                                        .toLocal()
                                                        .toString()
                                                        .substring(0, 10),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                        SizedBox(height: 20),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      );
    });
  }
}
