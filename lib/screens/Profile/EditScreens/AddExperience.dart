import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tizibane/Services/ProfileServices/ExperienceService.dart';
import 'package:tizibane/components/SubmitButton.dart';

class AddExperience extends StatefulWidget {
  const AddExperience({super.key});

  @override
  State<AddExperience> createState() => _AddExperienceState();
}

class _AddExperienceState extends State<AddExperience> {
  ExperienceService _experienceService = Get.put(ExperienceService());
  final TextEditingController _companyName = TextEditingController();
  final TextEditingController _jobTitle = TextEditingController();
  final TextEditingController _responsibilities = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
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
                controller: _companyName,
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
                  hintText: 'Company',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _jobTitle,
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
                  hintText: 'Job Title',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _responsibilities,
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
                  hintText: 'Responsibilities',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _startDateController,
                cursorColor: Colors.black,
                obscureText: false,
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
                obscureText: false,
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
                    ? CircularProgressIndicator()
                    : SubmitButton(
                        text: 'Add Experience',
                        onTap: () async {
                          final prefs = await SharedPreferences.getInstance();
                          int individualProfileId =
                              prefs.getInt('individualProfileId') ?? 0;
                          var experienceObj = {
                            'company_name': _companyName.text,
                            'job_title': _jobTitle.text,
                            'responsibilities': _responsibilities.text,
                            'start_date': _startDateController.text,
                            'end_date': _endDateController.text,
                            'individual_profile_id': individualProfileId,
                          };
                          await _experienceService.addExperience(experienceObj);
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
