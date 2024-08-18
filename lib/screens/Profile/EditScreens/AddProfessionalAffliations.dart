// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tizibane/Services/ProfileServices/ProfessionalAffiliationsService.dart';
import 'package:tizibane/components/SubmitButton.dart';

class AddProfessionalAffiliations extends StatefulWidget {
  const AddProfessionalAffiliations({super.key});

  @override
  State<AddProfessionalAffiliations> createState() =>
      _AddProfessionalAffiliationsState();
}

class _AddProfessionalAffiliationsState
    extends State<AddProfessionalAffiliations> {
  ProfessionalAffiliationsService _affiliationsService =
      Get.put(ProfessionalAffiliationsService());
  final TextEditingController _organizationName = TextEditingController();
  final TextEditingController _membershipId = TextEditingController();
  final TextEditingController _role = TextEditingController();
  final TextEditingController _certificate = TextEditingController();
  final TextEditingController _validFromDateController =
      TextEditingController();
  final TextEditingController _validToController = TextEditingController();
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
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Professional Affiliation',
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _organizationName,
                cursorColor: Colors.black,
                obscureText: false,
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
                    Icons.person,
                    color: Colors.black,
                  ),
                  hintText: 'Oranization Name',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _membershipId,
                cursorColor: Colors.black,
                obscureText: false,
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
                  hintText: 'Membership Id',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _role,
                cursorColor: Colors.black,
                obscureText: false,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 15.0,
                  ),
                  suffixIcon: const Icon(
                    Icons.email,
                    color: Colors.black,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                  hintText: 'Role',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _validFromDateController,
                cursorColor: Colors.black,
                obscureText: false,
                readOnly: true,
                onTap: () => _selectDate(context, _validFromDateController),
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
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _validToController,
                cursorColor: Colors.black,
                obscureText: false,
                readOnly: true,
                onTap: () => _selectDate(context, _validToController),
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
              ),
              const SizedBox(height: 20),
              TextField(
                onTap: () {
                  _pickFile();
                },
                showCursor: false,
                readOnly: true,
                cursorColor: Colors.black,
                obscureText: false,
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
              ),
              const SizedBox(height: 20),
              Obx(() {
                return _affiliationsService.isLoading.value
                    ? CircularProgressIndicator()
                    : SubmitButton(
                        text: 'Add Professional Affiliation',
                        onTap: () async {
                          final prefs = await SharedPreferences.getInstance();
                          int individualProfileId =
                              prefs.getInt('individualProfileId') ?? 0;
                          var affiliation = {
                            'organization_name': _organizationName.text,
                            'membership_id': _membershipId.text,
                            'role': _role.text,
                            'valid_from': _validFromDateController.text,
                            'valid_to': _validToController.text,
                            'individual_profile_id': individualProfileId,
                          };
                          await _affiliationsService.addProfessionalAffiliation(
                              affiliation, _file);
                        },
                      );
              })
            ],
          ),
        ),
      ),
    );
  }
}
