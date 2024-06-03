import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tizibane/Components/SubmitButton.dart';
import 'package:tizibane/Services/JobsService.dart';
import 'package:tizibane/constants/constants.dart';

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
    _applicationLetterController.text = 'Dear [Recipient Name],\n\n'
        'I am writing to apply for the position of [Position] at [Company]. '
        'With [number] years of experience in [field/industry], '
        'I am confident in my ability to contribute to your team.\n\n'
        'Sincerely,\n[Your Name]';
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
                      child: Image.network(
                        companyLogoUrl + widget.companyLogo,
                        height: 60,
                        width: 60,
                        fit: BoxFit.cover,
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
                              onTap: () async {
                                await _jobsService.sendApplication(
                                    jobApplicationLetter:
                                        _applicationLetterController.text,
                                    jobListingId: widget.jobId);
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
}
