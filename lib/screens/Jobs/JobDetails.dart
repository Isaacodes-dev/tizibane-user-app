// ignore_for_file: prefer_const_constructors
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tizibane/Services/Connectivity.dart';
import 'package:tizibane/Services/Jobs/JobsService.dart';
import 'package:tizibane/Services/StatusService.dart';
import 'package:tizibane/components/SubmitButton.dart';
import 'package:tizibane/constants/constants.dart';
import 'package:tizibane/screens/Jobs/JobApplication.dart';

class JobDetails extends StatefulWidget {
  final String statusValue;
  final String id;
  final int experience;
  final String employementType;
  final String companyName;
  final String responsobilities;
  final String title;
  final String description;
  final String companyLogo;
  final String companyAddress;

  const JobDetails(
      {super.key,
      required this.id,
      required this.statusValue,
      required this.title,
      required this.experience,
      required this.employementType,
      required this.companyAddress,
      required this.description,
      required this.responsobilities,
      required this.companyName,
      required this.companyLogo});

  @override
  State<JobDetails> createState() => _JobDetailsState();
}

class _JobDetailsState extends State<JobDetails> {
  final JobsService _jobsService = Get.put(JobsService());
  final StatusService _statusService = Get.put(StatusService());
  final ConnectivityService _connectivityService =
      Get.put(ConnectivityService());

  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance!.addPostFrameCallback((_) {
    //   if(_connectivityService.isConnected.value)
    //   {
    //      _jobsService.getJobDetail(widget.id);
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    final logoUrl = widget.companyLogo ?? '';
    List<String> responsibilities = widget.responsobilities.split('\n');
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
                    widget.companyName ?? '',
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
                            child: CachedNetworkImage(
                              imageUrl: companyLogoUrl + widget.companyLogo,
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  Image.asset('assets/images/samplelogo.png'),
                              height: 65,
                              width: 65,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.title,
                            style: GoogleFonts.lexendDeca(
                              textStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                widget.companyAddress ?? '',
                                style: GoogleFonts.lexendDeca(
                                  textStyle: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              Text(
                                widget.companyAddress ?? '',
                                style: GoogleFonts.lexendDeca(
                                  textStyle: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              Text(
                                widget.companyAddress ?? '',
                                style: GoogleFonts.lexendDeca(
                                  textStyle: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(left: 1.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Job Description",
                              style: GoogleFonts.lexendDeca(
                                textStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              widget.description ?? '',
                              style: GoogleFonts.lexendDeca(
                                textStyle: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300,
                                  height: 1.5,
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "Responsibilities",
                              style: GoogleFonts.lexendDeca(
                                textStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: responsibilities.length,
                              itemBuilder: (context, index) {
                                if (responsibilities[index].trim().isEmpty) {
                                  return SizedBox.shrink();
                                }
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 4.0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '\u2022',
                                        style: TextStyle(
                                          fontSize: 20,
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Expanded(
                                        child: Text(
                                          responsibilities[index],
                                          style: GoogleFonts.lexendDeca(
                                            textStyle: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w300,
                                              height: 1.5,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                            SizedBox(height: 10),
                            widget.statusValue == 'Not Applied'
                                ? SubmitButton(
                                    text: 'Apply',
                                    onTap: () => Get.to(JobApplication(
                                      position: widget.title,
                                      company: widget.companyName,
                                      companyLogo: widget.companyLogo,
                                      jobId: widget.id,
                                    )),
                                  )
                                : SubmitButton(
                                    text: 'Already Applied',
                                  ),
                            SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
