import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tizibane/constants/constants.dart';
import 'package:tizibane/screens/Jobs/JobDetails.dart';
import 'package:tizibane/screens/Jobs/JobWidget/JobCard.dart';

class JobsFeed extends StatefulWidget {
  const JobsFeed({super.key});

  @override
  State<JobsFeed> createState() => _JobsFeedState();
}

class _JobsFeedState extends State<JobsFeed> {
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
                      child: CircleAvatar(
                        radius: 29,
                        backgroundImage:
                            Image.asset('assets/images/user (5).jpg').image,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      'Hi, John Doe',
                      style: GoogleFonts.lexendDeca(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.white),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                TextField(
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
                    GestureDetector(
                      onTap: (){
                        Get.to(JobDetails());
                      },
                      child: JobCard(position: 'Senior React Software Developer',company: 'Tizibane Solutions',address: 'Kafubu House, Luanshya',salary: 'K40000',jobType: 'Hybrid',jobTime: 'Fulltime',experience: '2 Year Exp',)),
                    JobCard(position: 'Backend Software Developer',company: 'Tizibane Solutions',address: 'Kafubu House, Luanshya',salary: 'K20000',jobType: 'Remote',jobTime: 'Fulltime',experience: '2 Year Exp',),
                    JobCard(position: 'Frontend Software Developer',company: 'Tizibane Solutions',address: 'Kafubu House, Luanshya',salary: 'K20000',jobType: 'Remote',jobTime: 'Fulltime',experience: '2 Year Exp',),
                    
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

