import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tizibane/Services/ProfileServices/SkillService.dart';
import 'package:tizibane/components/SubmitButton.dart';

class AddSkill extends StatefulWidget {
  const AddSkill({super.key});

  @override
  State<AddSkill> createState() => _AddSkillState();
}

class _AddSkillState extends State<AddSkill> {
  SkillService _skillService = Get.put(SkillService());
  final TextEditingController _skillName = TextEditingController();
  final TextEditingController _proficiencyLevel = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: EdgeInsets.all(15.0),
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
            TextField(
              controller: _skillName,
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
                hintText: 'Skill',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0)),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _proficiencyLevel,
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
                hintText: 'Expert Level',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0)),
              ),
            ),
            const SizedBox(height: 20),
            Obx(() {
              return _skillService.isLoading.value
                  ? CircularProgressIndicator()
                  : SubmitButton(
                      text: 'Add Skill',
                      onTap: () async{
                        var skill = {
                          'skill_name' : _skillName.text,
                          'proficiency_level': _proficiencyLevel.text 
                        };
                       await _skillService.addSkill(skill);
                      },
                    );
            })
          ],
        ),
      ),
    );
  }
}
