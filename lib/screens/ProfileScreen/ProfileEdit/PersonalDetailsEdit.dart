import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:tizibane/Components/SubmitButton.dart';
import 'package:tizibane/Services/UserService.dart';
class PersonalDetailsEdit extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String email;

  const PersonalDetailsEdit({
     Key? key,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.email,
  }) : super(key: key);

  @override
  State<PersonalDetailsEdit> createState() => _PersonalDetailsEditState();
}

class _PersonalDetailsEditState extends State<PersonalDetailsEdit> {
  TextEditingController firstNameText = TextEditingController();
  TextEditingController lastNameText = TextEditingController();
  TextEditingController phoneNumberText = TextEditingController();
  TextEditingController emailText = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Set initial values to text controllers
    firstNameText.text = widget.firstName;
    lastNameText.text = widget.lastName;
    phoneNumberText.text = widget.phoneNumber;
    emailText.text = widget.email;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: firstNameText,
              decoration: InputDecoration(
                hintText: widget.firstName,
                hintStyle: TextStyle(color: Colors.black),
                contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: lastNameText,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                hintText: widget.lastName,
                hintStyle: TextStyle(color: Colors.black),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: emailText,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                hintText: widget.email,
                hintStyle: TextStyle(color: Colors.black),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: phoneNumberText,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                hintText: widget.phoneNumber,
                hintStyle: TextStyle(color: Colors.black),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
            SizedBox(height: 10),
            SubmitButton(text: 'Update',onTap: () {
              
            },)
          ],
        ),
      ),
    );
  }
}
