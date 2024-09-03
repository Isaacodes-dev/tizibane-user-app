import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:tizibane/Components/SubmitButton.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:tizibane/Services/AuthService.dart';
import 'package:tizibane/Services/ProfileService.dart';
import 'package:tizibane/models/User.dart';
import 'package:tizibane/screens/Login.dart';
import 'package:get/get.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  late TextEditingController fullNameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;

  bool _obscureText = true;
  bool _obscureTextConfirmPassword = true;
  final AuthService _authService = Get.put(AuthService());
  final _formKey = GlobalKey<FormState>();
  bool _agreeToTerms = false;

  @override
  void initState() {
    super.initState();
    fullNameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  void _onAgreeToTerms(bool? value) {
    setState(() {
      _agreeToTerms = value ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    String? selectedProvider;
    final user = {
      'name': fullNameController.text,
      'email': emailController.text,
      'password': passwordController.text,
      'agreed_to_terms': _agreeToTerms ? 1 : 0,
    };
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 230, 230, 230),
      body: Container(
        width: width,
        height: height,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                SizedBox(
                  child: Image.asset(
                    'assets/images/Tizibane.png',
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Registration',
                        style: TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      TextFormField(
                        cursorColor: Colors.black,
                        controller: fullNameController,
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
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your full name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        cursorColor: Colors.black,
                        controller: emailController,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 10.0,
                            horizontal: 15.0,
                          ),
                          suffixIcon: const Icon(
                            Icons.email,
                            color: Colors.black,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(40.0),
                          ),
                          hintText: 'Email',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          } else if (!RegExp(
                                  r'^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$')
                              .hasMatch(value)) {
                            return 'Please enter a valid email address';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        cursorColor: Colors.black,
                        controller: passwordController,
                        obscureText: _obscureText,
                        decoration: InputDecoration(
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
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 10.0,
                            horizontal: 15.0,
                          ),
                          hintText: 'Password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          } else if (value.length < 6) {
                            return 'Password must be at least 6 characters long';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        cursorColor: Colors.black,
                        controller: confirmPasswordController,
                        obscureText: _obscureTextConfirmPassword,
                        decoration: InputDecoration(
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
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 15.0),
                          hintText: 'Confirm Password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please confirm your password';
                          } else if (value != passwordController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Checkbox(
                            activeColor: Colors.black,
                            checkColor: Colors.white,
                            value: _agreeToTerms,
                            onChanged: _onAgreeToTerms,
                          ),
                          Text('Agree to Terms',
                              style: GoogleFonts.lexendDeca())
                        ],
                      ),
                      const SizedBox(height: 20),
                      Obx(() {
                        return _authService.isLoading.value
                            ? const CircularProgressIndicator()
                            : SubmitButton(
                                text: 'Sign Up',
                                onTap: _agreeToTerms
                                    ? () async {
                                        if (_formKey.currentState!.validate()) {
                                          print(user);
                                          await _authService.createUser(user);
                                          clearFields();
                                        }
                                      }
                                    : null,
                              );
                      }),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Already have an account?',
                          style: GoogleFonts.lexendDeca()),
                      const SizedBox(
                        width: 4,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Login()));
                        },
                        child: Text(
                          'Login Now',
                          style: GoogleFonts.lexendDeca(
                              textStyle: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.orange)),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 25),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void clearFields() {
    fullNameController.text = '';
    emailController.text = '';
    passwordController.text = '';
    confirmPasswordController.text = '';
  }
}
