import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tizibane/Services/ProfileServices/SkillService.dart';
import 'package:tizibane/components/SubmitButton.dart';

class EditSkill extends StatefulWidget {
  final int skillId;
  final String skillName;
  final String proficiencyLevel;
  const EditSkill({
    super.key,
    required this.skillId,
    required this.skillName,
    required this.proficiencyLevel,
  });

  @override
  State<EditSkill> createState() => _EditSkillState();
}

class _EditSkillState extends State<EditSkill> {
  late TextEditingController _skillNameController;
  String? _selectedProficiencyLevel;

  final List<String> _proficiencyLevels = [
    'beginner',
    'intermediate',
    'advanced',
    'expert',
  ];

  SkillService _skillService = Get.put(SkillService());

  @override
  void initState() {
    super.initState();
    _skillNameController = TextEditingController(text: widget.skillName);
    if (_proficiencyLevels.contains(widget.proficiencyLevel)) {
      setState(() {
        _selectedProficiencyLevel = widget.proficiencyLevel;
      });
    } else {
      _selectedProficiencyLevel = _proficiencyLevels.first;
    }
  }

  @override
  void dispose() {
    _skillNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Edit Skill',
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _skillNameController,
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
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: _selectedProficiencyLevel,
              items: _proficiencyLevels.map((level) {
                return DropdownMenuItem<String>(
                  value: level,
                  child: Text(level),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedProficiencyLevel = newValue;
                });
              },
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
            ),
            const SizedBox(height: 20),
            Obx(
              () {
                return _skillService.isLoading.value
                    ? Center(child: CircularProgressIndicator())
                    : SubmitButton(
                        text: 'Submit',
                        onTap: () async {
                          final prefs = await SharedPreferences.getInstance();
                          int individualProfileId =
                              prefs.getInt('individualProfileId') ?? 0;
                          var skill = {
                            'skill_name': _skillNameController.text,
                            'proficiency_level': _selectedProficiencyLevel,
                            'individual_profile_id': individualProfileId
                          };
                          await _skillService.updateSkill(
                              skill, widget.skillId);
                        },
                      );
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
