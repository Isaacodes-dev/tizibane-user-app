// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tizibane/Services/JobsService.dart';
import 'package:tizibane/Services/StatusService.dart';
import 'package:tizibane/components/SubmitButton.dart';
import 'package:tizibane/constants/constants.dart';
import 'package:tizibane/screens/Jobs/JobApplication.dart';

class JobDetails extends StatefulWidget {
  final String id;
  const JobDetails({super.key, required this.id});

  @override
  State<JobDetails> createState() => _JobDetailsState();
}

class _JobDetailsState extends State<JobDetails> {

  final JobsService _jobsService = Get.put(JobsService());

  final StatusService _statusService = Get.put(StatusService());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _jobsService.getJobDetail(widget.id);
      _statusService.getJobStatus(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Obx(() {
        if (_jobsService.isLoading.value) {
          return Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          );
        } else if (_jobsService.jobDetails.value == null) {
          return Center(
            child: Text(
              'No job details available',
              style: TextStyle(color: Colors.white),
            ),
          );
        } else {
          final job = _jobsService.jobDetails.value!;
          final logoUrl = job.company?.companyLogoUrl ?? '';
          List<String> responsibilities =
              job.responsibilitiesAndDuties?.split('\n') ?? [];
          List<String> qualifications =
              job.qualificationsAndExperience?.split('\n') ?? [];
          List<String> additionalRequirements =
              job.otherComment?.split('\n') ?? [];
          
          return Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      job.company?.companyName ?? '',
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
                              child: Image.network(
                                companyLogoUrl + logoUrl,
                                height: 65,
                                width: 65,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              job.position?.positionName ?? '',
                              style: GoogleFonts.lexendDeca(
                                textStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              job.company?.companyAddress ?? '',
                              style: GoogleFonts.lexendDeca(
                                textStyle: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
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
                                job.description ?? '',
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
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4.0),
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
                              Text(
                                "Qualifications",
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
                                itemCount: qualifications.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4.0),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '\u2022',
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.black),
                                        ),
                                        SizedBox(width: 10),
                                        Expanded(
                                          child: Text(
                                            qualifications[index],
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
                              Text(
                                "Additional Requirements",
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
                                itemCount: additionalRequirements.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4.0),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '\u2022',
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.black),
                                        ),
                                        SizedBox(width: 10),
                                        Expanded(
                                          child: Text(
                                            additionalRequirements[index],
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
                              _statusService.status.value == '' ?
                              SubmitButton(
                                text: 'Apply',
                                onTap: () => Get.to(JobApplication(
                                  position: job.position?.positionName ?? '',
                                  company: job.company?.companyName ?? '',
                                  companyLogo: job.company?.companyLogoUrl ?? '',
                                  jobId: widget.id,
                                )),
                              ) : SubmitButton(
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
          );
        }
      }),
    );
  }
}
