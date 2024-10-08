import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tizibane/Components/SubmitButton.dart';
import 'package:tizibane/Services/Jobs/JobsService.dart';
import 'package:tizibane/Services/UserService.dart';
import 'package:tizibane/components/bottommenu/BottomMenuBar.dart';
import 'package:tizibane/constants/constants.dart';
import 'package:tizibane/screens/Jobs/uploadCv.dart';

class JobApplication extends StatefulWidget {
  final String position;
  final String company;
  final String companyLogo;
  final String jobId;
  const JobApplication({
    super.key,
    required this.position,
    required this.company,
    required this.companyLogo,
    required this.jobId,
  });

  @override
  State<JobApplication> createState() => _JobApplicationState();
}

final TextEditingController _applicationLetterController =
    TextEditingController();
final _formKey = GlobalKey<FormState>();
final JobsService _jobsService = Get.put(JobsService());
final UserService _userService = Get.put(UserService());

class _JobApplicationState extends State<JobApplication> {
  File? _file;
  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx'],
    );

    if (result != null) {
      setState(() {
        _file = File(result.files.single.path!);
      });
    } else {
      // User canceled the picker
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _applicationLetterController.text = 'Dear Sir/Madam,\n\n'
        'I am writing to apply for the position of ${widget.position} at ${widget.company}. '
        'With [number] years of experience in [field/industry], '
        'I am confident in my ability to contribute to your team.\n\n'
        'Sincerely,\n${_userService.userObj.value[0].name}';
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Submit Application Here",
                    style: GoogleFonts.lexendDeca(
                      textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                width: 400,
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 11, 40, 52),
                    borderRadius: BorderRadius.circular(60)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.position,
                              style: GoogleFonts.lexendDeca(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              widget.company,
                              style: GoogleFonts.lexendDeca(
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: 180,
            left: 0,
            right: 0,
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Form(
                      key: _formKey,
                      child: TextFormField(
                        controller: _applicationLetterController,
                        maxLines: 10,
                        decoration: InputDecoration(
                          labelText: 'Cover Letter',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Obx(() {
                      return _jobsService.isLoading.value
                          ? CircularProgressIndicator()
                          : SubmitButton(
                              text: 'Send Application',
                              onTap: () {
                                showCVDialog();
                              },
                            );
                    })
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showCVDialog() {
    Get.defaultDialog(
      title: '',
      contentPadding: const EdgeInsets.only(bottom: 20, right: 15, left: 15),
      content: const Text("Do you want to upload an updated CV?"),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Get.back();
                Get.to(UploadCv(
                    jobApplication: _applicationLetterController.text,
                    jobId: widget.jobId));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child: Text(
                "Yes",
                style: GoogleFonts.lexendDeca(
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(width: 20),
            ElevatedButton(
              onPressed: () {
                sendJobApplication();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child: Text(
                "No",
                style: GoogleFonts.lexendDeca(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void sendJobApplication() async {
    await _jobsService.sendApplication(
        jobApplicationLetter: _applicationLetterController.text,
        jobListingId: widget.jobId);
  }
}
