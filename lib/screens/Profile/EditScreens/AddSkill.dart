import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tizibane/Services/ProfileServices/SkillService.dart';
import 'package:tizibane/components/SubmitButton.dart';

class AddSkill extends StatefulWidget {
  const AddSkill({super.key});

  @override
  State<AddSkill> createState() => _AddSkillState();
}

class _AddSkillState extends State<AddSkill> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _skillName = TextEditingController();
  SkillService _skillService = Get.put(SkillService());
  String? _selectedProficiency;

  final List<String> _proficiencyLevels = [
    'Beginner',
    'Intermediate',
    'Advanced',
    'Expert'
  ];

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
                      'Skills',
                      style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _skillName,
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
                      Icons.person,
                      color: Colors.black,
                    ),
                    hintText: 'Skill',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the skill name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 15.0,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(40.0),
                    ),
                    hintText: 'Select Proficiency Level',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  value: _selectedProficiency,
                  items: _proficiencyLevels.map((String level) {
                    return DropdownMenuItem<String>(
                      value: level,
                      child: Text(level),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _selectedProficiency = newValue!;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Please select a proficiency level';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                Obx(() {
                  return _skillService.isLoading.value
                      ? CircularProgressIndicator()
                      : SubmitButton(
                          text: 'Add Skill',
                          onTap: () async {
                            if (_formKey.currentState!.validate()) {
                              final prefs =
                                  await SharedPreferences.getInstance();
                              int individualProfileId =
                                  prefs.getInt('individualProfileId') ?? 0;
                              var skill = {
                                'skill_name': _skillName.text,
                                'proficiency_level': _selectedProficiency,
                                'individual_profile_id': individualProfileId
                              };
                              await _skillService.addSkill(skill);
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
