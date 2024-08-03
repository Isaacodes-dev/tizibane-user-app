import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tizibane/Services/AuthService.dart';
import 'package:tizibane/Services/ProfileService.dart';
import 'package:tizibane/components/SubmitButton.dart';

class EditBasicDetails extends StatefulWidget {
  const EditBasicDetails({super.key});

  @override
  State<EditBasicDetails> createState() => _EditBasicDetailsState();
}

class _EditBasicDetailsState extends State<EditBasicDetails> {
  bool _obscureText = true;
  bool _obscureTextConfirmPassword = true;
  final ImagePicker _picker = ImagePicker();
  XFile? _image;
  bool _showUploadButton = false;
  final AuthService _authService = Get.put(AuthService());
  ProfileService _profileService = Get.put(ProfileService());

  Future<void> _pickImage() async {
    final pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = pickedImage;
        _showUploadButton = true;
      });
    }
  }

  Future<void> _uploadImage() async {
    if (_image != null) {
      await _profileService.uploadImage(_image!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Column(
                children: [
                  Text('Upload Profile Picture',
                      style: GoogleFonts.lexendDeca()),
                  SizedBox(
                    height: 20,
                  ),
                  Stack(
                    children: [
                      Container(
                        width: 160,
                        height: 160,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 4,
                            ),
                          ],
                          border: Border.all(
                            color: Colors.orange,
                            width: 2.0,
                          ),
                        ),
                        child: ClipOval(
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              child: _image == null
                                  ? Image.asset(
                                      'assets/images/user.jpg',
                                      fit: BoxFit.cover,
                                      width: 150,
                                      height: 150,
                                    )
                                  : Image.file(
                                      File(_image!.path),
                                      fit: BoxFit.cover,
                                      width: 150,
                                      height: 150,
                                    ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 15,
                        child: InkWell(
                          onTap: _pickImage,
                          child: Icon(
                            Icons.camera_alt,
                            color: const Color.fromARGB(255, 171, 170, 170),
                            size: 30,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          if (_showUploadButton)
            Obx(() {
              return _profileService.isLoading.value
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black),
                      onPressed: _uploadImage,
                      child: Text("Upload Image"),
                    );
            }),
          Divider(
            color: Colors.black,
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(20.0),
              child: Column(
                children: [
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
                      hintText: 'Full Name',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0)),
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
                      hintText: 'Phone Number',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0)),
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
                        Icons.email,
                        color: Colors.black,
                      ),
                      hintText: 'Email',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    cursorColor: Colors.black,
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 15.0,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(40.0),
                      ),
                      suffixIcon: IconButton(
                        color: Colors.black,
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      ),
                      hintText: 'Password',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    cursorColor: Colors.black,
                    obscureText: _obscureTextConfirmPassword,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 15.0,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(40.0),
                      ),
                      suffixIcon: IconButton(
                        color: Colors.black,
                        icon: Icon(
                          _obscureTextConfirmPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureTextConfirmPassword =
                                !_obscureTextConfirmPassword;
                          });
                        },
                      ),
                      hintText: 'Confirm Password',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Obx(() {
                    return _authService.isLoading.value
                        ? const CircularProgressIndicator()
                        : SubmitButton(
                            text: 'Update',
                          );
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
