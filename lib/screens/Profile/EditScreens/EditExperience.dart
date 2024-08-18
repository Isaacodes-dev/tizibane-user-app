import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tizibane/Services/ProfileServices/ExperienceService.dart';
import 'package:tizibane/components/SubmitButton.dart';

class EditExperience extends StatefulWidget {
  final int id;
  final String companyName;
  final String jobTitle;
  final String responsibilities;
  final String startDate;
  final String endDate;

  const EditExperience({
    super.key,
    required this.id,
    required this.companyName,
    required this.jobTitle,
    required this.responsibilities,
    required this.startDate,
    required this.endDate,
  });

  @override
  State<EditExperience> createState() => _EditExperienceState();
}

class _EditExperienceState extends State<EditExperience> {
  late TextEditingController _companyNameController;
  late TextEditingController _jobTitleController;
  late TextEditingController _responsibilitiesController;
  late TextEditingController _startDateController;
  late TextEditingController _endDateController;
  ExperienceService _experienceService = Get.put(ExperienceService());

  @override
  void initState() {
    super.initState();
    _companyNameController = TextEditingController(text: widget.companyName);
    _jobTitleController = TextEditingController(text: widget.jobTitle);
    _responsibilitiesController =
        TextEditingController(text: widget.responsibilities);
    _startDateController = TextEditingController(text: widget.startDate);
    _endDateController = TextEditingController(text: widget.endDate);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Edit Experience'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Experience',
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _companyNameController,
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
                  hintText: 'Company',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _jobTitleController,
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
                    Icons.work,
                    color: Colors.black,
                  ),
                  hintText: 'Job Title',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _responsibilitiesController,
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
                    Icons.description,
                    color: Colors.black,
                  ),
                  hintText: 'Responsibilities',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
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
              ),
              const SizedBox(height: 20),
              TextField(
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
              ),
              const SizedBox(height: 20),
              Obx(() {
                return _experienceService.isLoading.value
                    ? Center(child: CircularProgressIndicator())
                    : SubmitButton(
                        text: 'Submit',
                        onTap: () async {
                          final prefs = await SharedPreferences.getInstance();
                          int individualProfileId =
                              prefs.getInt('individualProfileId') ?? 0;
                          var experienceData = {
                            'id': widget.id,
                            'company_name': _companyNameController.text,
                            'job_title': _jobTitleController.text,
                            'responsibilities':
                                _responsibilitiesController.text,
                            'start_date': _startDateController.text,
                            'end_date': _endDateController.text,
                            'individual_profile_id': individualProfileId,
                          };
                          await _experienceService.updateExperience(
                              widget.id, experienceData);
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
