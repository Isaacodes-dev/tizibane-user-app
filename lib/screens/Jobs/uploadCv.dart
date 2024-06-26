import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tizibane/Components/SubmitButton.dart';
import 'package:path/path.dart' as p;
import 'package:tizibane/Services/JobsService.dart';

class UploadCv extends StatefulWidget {
  final String? jobId;
  final String? jobApplication; 
  const UploadCv({super.key, this.jobApplication,this.jobId,});

  @override
  State<UploadCv> createState() => _UploadCvState();
}

class _UploadCvState extends State<UploadCv> {
  File? _file;

  @override
  Widget build(BuildContext context) {
    final JobsService _jobsService = Get.put(JobsService());

    Future<void> _pickFile() async {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      if (result != null) {
        setState(() {
          _file = File(result.files.single.path!);
        });
        print(_file?.path);
      } else {
        // User canceled the picker
      }
    }

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
                    "Submit Curriculum Vitae Here",
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
                        child: Icon(Icons.upload_file,color: Colors.white,)),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Please Submit PDF Format',
                              style: GoogleFonts.lexendDeca(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Icon(
                        Icons.upload_file_rounded,
                        size: 60,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      onTap: () {
                        _pickFile();
                      },
                      showCursor: false,
                      readOnly: true,
                      decoration: InputDecoration(
                        hintText: _file == null
                            ? 'Upload Cv'
                            : p.basename(_file!.path),
                        hintStyle: GoogleFonts.lexendDeca(color: Colors.black),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        suffixIcon: Icon(
                          Icons.upload_file,
                          color: Colors.black,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Obx(
                      () {
                        return _jobsService.isLoading.value
                            ? CircularProgressIndicator()
                            : SubmitButton(
                                text: 'Upload Cv',
                                onTap: () async {
                                  if (_file != null) {
                                    await _jobsService.sendCv(
                                        curriculumVitaeUrl: _file,jobApplication: widget.jobApplication,jobId: widget.jobId);
                                  } else {
                                    Get.snackbar(
                                      'Error',
                                      'No file selected',
                                      snackPosition: SnackPosition.TOP,
                                      backgroundColor: Colors.red,
                                      colorText: Colors.white,
                                    );
                                  }
                                },
                              );
                      },
                    ),
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
