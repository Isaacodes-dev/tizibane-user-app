import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tizibane/Services/ProfileServices/EducationService.dart';
import 'package:tizibane/components/SubmitButton.dart';
import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:file_picker/file_picker.dart';
import 'package:google_fonts/google_fonts.dart';

class EditEducation extends StatefulWidget {
  final int id;
  final String institution;
  final String degree;
  final String fieldOfStudy;
  final String startDate;
  final String endDate;
  final String grade;

  const EditEducation({
    super.key,
    required this.id,
    required this.institution,
    required this.degree,
    required this.fieldOfStudy,
    required this.startDate,
    required this.endDate,
    required this.grade,
  });

  @override
  State<EditEducation> createState() => _EditEducationState();
}

class _EditEducationState extends State<EditEducation> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _institutionController;
  late TextEditingController _degreeController;
  late TextEditingController _fieldOfStudyController;
  late TextEditingController _startDateController;
  late TextEditingController _endDateController;
  late TextEditingController _gradeController;
  File? _file;
  EducationService _educationService = Get.put(EducationService());
  @override
  void initState() {
    super.initState();
    _institutionController = TextEditingController(text: widget.institution);
    _degreeController = TextEditingController(text: widget.degree);
    _fieldOfStudyController = TextEditingController(text: widget.fieldOfStudy);
    _startDateController = TextEditingController(text: widget.startDate);
    _endDateController = TextEditingController(text: widget.endDate);
    _gradeController = TextEditingController(text: widget.grade);
  }

  @override
  void dispose() {
    _institutionController.dispose();
    _degreeController.dispose();
    _fieldOfStudyController.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
    _gradeController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        controller.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Education',
                      style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _institutionController,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 15.0,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(40.0),
                    ),
                    suffixIcon: const Icon(
                      Icons.apartment,
                      color: Colors.black,
                    ),
                    hintText: 'Institution Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the institution name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _degreeController,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 15.0,
                    ),
                    suffixIcon: const Icon(
                      Icons.school,
                      color: Colors.black,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(40.0),
                    ),
                    hintText: 'Degree',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the degree';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _fieldOfStudyController,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 15.0,
                    ),
                    suffixIcon: const Icon(
                      Icons.work,
                      color: Colors.black,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(40.0),
                    ),
                    hintText: 'Field of Study',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the field of study';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _startDateController,
                  cursorColor: Colors.black,
                  readOnly: true,
                  onTap: () => _selectDate(context, _startDateController),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 15.0,
                    ),
                    suffixIcon: const Icon(
                      Icons.calendar_today,
                      color: Colors.black,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(40.0),
                    ),
                    hintText: 'Start Date',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select the start date';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _endDateController,
                  cursorColor: Colors.black,
                  readOnly: true,
                  onTap: () => _selectDate(context, _endDateController),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 15.0,
                    ),
                    suffixIcon: const Icon(
                      Icons.calendar_today,
                      color: Colors.black,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(40.0),
                    ),
                    hintText: 'End Date',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select the end date';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _gradeController,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 15.0,
                    ),
                    suffixIcon: const Icon(
                      Icons.school,
                      color: Colors.black,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(40.0),
                    ),
                    hintText: 'Grade',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the grade';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  onTap: () {
                    _pickFile();
                  },
                  showCursor: false,
                  readOnly: true,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 15.0,
                    ),
                    suffixIcon: const Icon(
                      Icons.upload_file,
                      color: Colors.black,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(40.0),
                    ),
                    hintText: 'Upload Certificate',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                  ),
                ),
                const SizedBox(height: 30),
                Obx(() {
                  return _educationService.isLoading.value
                      ? CircularProgressIndicator()
                      : SubmitButton(
                          text: 'Submit',
                          onTap: () async {
                            final prefs = await SharedPreferences.getInstance();
                            int individualProfileId =
                                prefs.getInt('individualProfileId') ?? 0;
                            var education = {
                              'id': widget.id,
                              'institution_name': _institutionController.text,
                              'degree': _degreeController.text,
                              'field_of_study': _fieldOfStudyController.text,
                              'start_date': _startDateController.text,
                              'end_date': _endDateController.text,
                              'grade': _gradeController.text,
                              'individual_profile_id': individualProfileId,
                            };
                            await _educationService.updateEducation(
                                education, widget.id, _file);
                          },
                        );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
