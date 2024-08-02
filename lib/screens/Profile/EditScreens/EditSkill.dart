import 'package:flutter/material.dart';
import 'package:tizibane/components/SubmitButton.dart';

class EditSkill extends StatefulWidget {
  const EditSkill({super.key});

  @override
  State<EditSkill> createState() => _EditSkillState();
}

class _EditSkillState extends State<EditSkill> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: Column(children: [
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
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          ),
        ),
        const SizedBox(height: 20),
        TextField(
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
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          ),
        ),
        const SizedBox(height: 20),
        SubmitButton(text: 'Edit Skill'),
        const SizedBox(height: 20),
      ]),
    );
  }
}
