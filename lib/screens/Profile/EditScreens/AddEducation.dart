import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tizibane/Services/ProfileServices/EducationService.dart';
import 'package:tizibane/components/SubmitButton.dart';
import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:file_picker/file_picker.dart';
import 'package:google_fonts/google_fonts.dart';

class AddEducation extends StatefulWidget {
  const AddEducation({super.key});

  @override
  State<AddEducation> createState() => _AddEducationState();
}

class _AddEducationState extends State<AddEducation> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _institutionName = TextEditingController();
  final TextEditingController _degree = TextEditingController();
  final TextEditingController _fieldOfStudy = TextEditingController();
  final TextEditingController _grade = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  EducationService _educationService = Get.put(EducationService());
  File? _file;

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
                  controller: _institutionName,
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
                    hintText: 'Institution',
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
                  controller: _degree,
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
                  controller: _fieldOfStudy,
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
                  controller: _grade,
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
                    hintText: _file == null
                        ? 'Upload Certificate'
                        : p.basename(_file!.path),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                  ),
                  validator: (value) {
                    if (_file == null) {
                      return 'Please upload a certificate';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                Obx(() {
                  return _educationService.isLoading.value
                      ? CircularProgressIndicator()
                      : SubmitButton(
                          text: 'Add Education',
                          onTap: () async {
                            if (_formKey.currentState!.validate()) {
                              final prefs =
                                  await SharedPreferences.getInstance();
                              int individualProfileId =
                                  prefs.getInt('individualProfileId') ?? 0;
                              var education = {
                                'institution_name': _institutionName.text,
                                'other': null,
                                'field_of_study': _fieldOfStudy.text,
                                'degree': _degree.text,
                                'start_date': _startDateController.text,
                                'end_date': _endDateController.text,
                                'grade': _grade.text,
                                'individual_profile_id': individualProfileId,
                              };
                              await _educationService.addEducation(
                                  education, _file);
                            }
                          },
                        );
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
