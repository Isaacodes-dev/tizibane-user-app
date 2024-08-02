import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tizibane/Services/ProfileService.dart';
import 'package:tizibane/constants/constants.dart';
import 'package:tizibane/screens/Profile/EditProfileScreen.dart';
import 'package:tizibane/screens/Profile/EditScreens/AddEducation.dart';
import 'package:tizibane/screens/Profile/EditScreens/AddSkill.dart';

class JobExperience {
  final String company;
  final String from;
  final String to;
  final String position;
  final String imagePath;

  JobExperience({
    required this.company,
    required this.from,
    required this.to,
    required this.position,
    required this.imagePath,
  });
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileService _profileService = Get.put(ProfileService());
  int currentStep = 0;

  final List<JobExperience> jobExperiences = [
    JobExperience(
        company: "Company A",
        position: "Software Developer",
        from: "Jan 2018",
        to: "Dec 2018",
        imagePath: "assets/images/insta-logo.png"),
    JobExperience(
        company: "Company B",
        position: "Software Developer",
        from: "Jan 2019",
        to: "Dec 2019",
        imagePath: "assets/images/insta-logo.png"),
    JobExperience(
        company: "Company C",
        position: "Software Developer",
        from: "Jan 2020",
        to: "Dec 2020",
        imagePath: "assets/images/insta-logo.png"),
    JobExperience(
        company: "Company D",
        position: "Software Developer",
        from: "Jan 2021",
        to: "Present",
        imagePath: "assets/images/insta-logo.png"),
  ];

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
          ClipOval(
            child: Image.asset(
              jobExperience.imagePath,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
          ),
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
                        Get.to(EditProfileScreen());
                      },
                      child: const Icon(Icons.edit_square, color: Colors.white),
                    )
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
                    imageUrl: imageBaseUrl + _profileService.imagePath.value,
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
                double containerWidth =
                    constraints.maxWidth * 0.9; // Store the width

                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            'James Banda',
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
                            'Software Developer',
                            style: GoogleFonts.lexendDeca(
                              textStyle: const TextStyle(
                                  fontWeight: FontWeight.bold,
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
                        width: containerWidth, // Apply the stored width
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'This is the about section. It contains information about the application or the user.',
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
                      Card(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            width: 1.5,
                            color: Colors.black,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Container(
                          padding: EdgeInsets.all(16.0),
                          width: containerWidth,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  Icon(Icons.school),
                                  SizedBox(width: 10),
                                  Text("Bachelor of Computer Science"),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 35.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Northrise University"),
                                        SizedBox(height: 10),
                                        Text("Graduated at 26 Jan, 2022"),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(right: 40.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Skills",
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
                      Padding(
                        padding: const EdgeInsets.only(right: 40.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Experience",
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
                                      // Add your onPressed code here!
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Column(
                        children: [
                          for (int i = 0; i < jobExperiences.length; i++) ...[
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  children: [
                                    buildStepIndicator(currentStep >= i),
                                    if (i < jobExperiences.length - 1)
                                      buildVerticalLine(currentStep > i),
                                  ],
                                ),
                                SizedBox(width: 10),
                                buildStepDetails(
                                    jobExperiences[i], currentStep >= i, i),
                              ],
                            ),
                            if (i < jobExperiences.length - 1)
                              SizedBox(height: 20),
                          ],
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
