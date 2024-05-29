// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tizibane/components/SubmitButton.dart';
import 'package:tizibane/screens/Jobs/JobApplication.dart';
import 'package:tizibane/screens/Jobs/JobWidget/BulletPoint.dart';

class JobDetails extends StatefulWidget {
  const JobDetails({super.key});

  @override
  State<JobDetails> createState() => _JobDetailsState();
}

class _JobDetailsState extends State<JobDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  "Tizibane Solutions",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ],
          ),
          SizedBox(),
          Positioned(
              top: 50,
              right: 0,
              left: 0,
              bottom: 0,
              child: Container(
                height: 50,
                padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(60),
                            child: Image.asset(
                              'assets/images/tizibaneicon.png',
                              height: 65,
                              width: 65,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Senior Software Developer",
                            style: GoogleFonts.lexendDeca(
                              textStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "House of Luanshya, Luanshya",
                            style: GoogleFonts.lexendDeca(
                              textStyle: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin: const EdgeInsets.all(5.0),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 6),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  'Hybrid',
                                  style: TextStyle(fontSize: 10),
                                ),
                              ),
                              SizedBox(
                                width: 2,
                              ),
                              Container(
                                margin: const EdgeInsets.all(5.0),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 6),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  'Hybrid',
                                  style: TextStyle(fontSize: 10),
                                ),
                              ),
                              SizedBox(
                                width: 2,
                              ),
                              Container(
                                margin: const EdgeInsets.all(5.0),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 6),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  'Hybrid',
                                  style: TextStyle(fontSize: 10),
                                ),
                              ),
                              SizedBox(
                                width: 2,
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 1.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Background",
                                  style: GoogleFonts.lexendDeca(
                                    textStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Text(
                                  "Job Purpose",
                                  style: GoogleFonts.lexendDeca(
                                    textStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Text(
                                  "Main Duties",
                                  style: GoogleFonts.lexendDeca(
                                    textStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Text(
                                  "Qualifications",
                                  style: GoogleFonts.lexendDeca(
                                    textStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            BulletPoint(
                              qualificationText:
                                  "Must Have a Bachelors Degree in any IT Realated Field",
                            ),
                            BulletPoint(
                              qualificationText:
                                  "Must Have a Bachelors Degree in any IT Realated Field",
                            ),
                            BulletPoint(
                              qualificationText:
                                  "Must Have a Bachelors Degree in any IT Realated Field",
                            ),
                            BulletPoint(
                              qualificationText:
                                  "Must Have a Bachelors Degree in any IT Realated Field",
                            ),
                            BulletPoint(
                              qualificationText:
                                  "Must Have a Bachelors Degree in any IT Realated Field",
                            ),
                            BulletPoint(
                              qualificationText:
                                  "Must Have a Bachelors Degree in any IT Realated Field",
                            ),
                            SizedBox(height: 20,),
                            SubmitButton(
                              text: 'Apply',
                              onTap: () => Get.to(JobApplication()),
                            ),
                            SizedBox(height: 20,),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
