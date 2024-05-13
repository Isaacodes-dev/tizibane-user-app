import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tizibane/components/SubmitButton.dart';
import 'package:tizibane/components/share/ShareUrlLink.dart';

class UpdateUserCredentials extends StatefulWidget {
  const UpdateUserCredentials({super.key});

  @override
  State<UpdateUserCredentials> createState() => _UpdateUserCredentialsState();
}

TextEditingController oldPasswordController = TextEditingController();

TextEditingController newPasswordController = TextEditingController();

TextEditingController confirmNewPasswordController = TextEditingController();

class _UpdateUserCredentialsState extends State<UpdateUserCredentials> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'Change Password',
                  style: GoogleFonts.lexendDeca(
                      textStyle:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                ),
              ],
            ),
            const SizedBox(height: 20),
            TextField(
              controller: oldPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                hintStyle: TextStyle(fontSize: 14),
                hintText: 'Current Password',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0)),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: newPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                hintText: 'New Password',
                hintStyle: TextStyle(fontSize: 14),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0)),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: confirmNewPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                hintText: 'New Password',
                hintStyle: TextStyle(fontSize: 14),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0)),
              ),
            ),
            const SizedBox(height: 20),
            const SubmitButton(text: 'Change Password' )
          ],
        ),
      ),
      floatingActionButton: ShareUrlLink(),
    );
  }
}
