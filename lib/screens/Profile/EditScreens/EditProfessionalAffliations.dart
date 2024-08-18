import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as p;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tizibane/Services/ProfileServices/ProfessionalAffiliationsService.dart';
import 'package:tizibane/components/SubmitButton.dart';

class EditProfessionalAffiliations extends StatefulWidget {
  final int id; 
  final String organizationName;
  final String membershipId;
  final String role;
  final String validFromDate;
  final String validToDate;
  final File? existingFile; // Add this if you want to support file updates

  const EditProfessionalAffiliations({
    super.key,
    required this.id,
    required this.organizationName,
    required this.membershipId,
    required this.role,
    required this.validFromDate,
    required this.validToDate,
    this.existingFile,
  });

  @override
  State<EditProfessionalAffiliations> createState() =>
      _EditProfessionalAffiliationsState();
}

class _EditProfessionalAffiliationsState
    extends State<EditProfessionalAffiliations> {
  late TextEditingController _organizationName;
  late TextEditingController _membershipId;
  late TextEditingController _role;
  late TextEditingController _validFromDateController;
  late TextEditingController _validToController;
  File? _file;

  ProfessionalAffiliationsService _affiliationsService =
      Get.put(ProfessionalAffiliationsService());

  @override
  void initState() {
    super.initState();
    _organizationName = TextEditingController(text: widget.organizationName);
    _membershipId = TextEditingController(text: widget.membershipId);
    _role = TextEditingController(text: widget.role);
    _validFromDateController =
        TextEditingController(text: widget.validFromDate);
    _validToController = TextEditingController(text: widget.validToDate);
    _file = widget.existingFile; // Initialize with existing file if available
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
  void dispose() {
    _organizationName.dispose();
    _membershipId.dispose();
    _role.dispose();
    _validFromDateController.dispose();
    _validToController.dispose();
    super.dispose();
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
                    'Edit Professional Affiliation',
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
                    Icons.business,
                    color: Colors.black,
                  ),
                  hintText: 'Organization Name',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _membershipId,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 15.0,
                  ),
                  suffixIcon: const Icon(
                    Icons.card_membership,
                    color: Colors.black,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                  hintText: 'Membership ID',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _role,
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
                  hintText: 'Role',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _validFromDateController,
                cursorColor: Colors.black,
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
                        text: 'Submit',
                        onTap: () async {
                          final prefs = await SharedPreferences.getInstance();
                          int individualProfileId =
                              prefs.getInt('individualProfileId') ?? 0;
                          var affiliation = {
                            'id': widget.id,
                            'organization_name': _organizationName.text,
                            'membership_id': _membershipId.text,
                            'role': _role.text,
                            'valid_from': _validFromDateController.text,
                            'valid_to': _validToController.text,
                            'individual_profile_id': individualProfileId,
                          };
                          await _affiliationsService.updateProfessionalAffiliation(
                              affiliation, _file);
                        },
                      );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
