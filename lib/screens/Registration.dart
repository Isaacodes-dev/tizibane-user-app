import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tizibane/Components/SubmitButton.dart';
import 'package:tizibane/Services/AuthService.dart';
import 'package:tizibane/models/User.dart';
import 'package:tizibane/screens/Login.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final TextEditingController nrcController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final AuthService _authService = Get.put(AuthService());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 230, 230, 230),
      body: SizedBox(
        width: width,
        height: height,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  child: Image.asset(
                'assets/images/Tizibane.png',
              )),
              const Padding(
                padding: EdgeInsets.all(10.0),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(
                    'Register',
                    style:
                        TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                  )
                ]),
              ),
              Padding(
                padding: EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    TextField(
                      controller: nrcController,
                      obscureText: false,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 15.0),
                        hintStyle: const TextStyle(fontSize: 14),
                        hintText: 'Nrc',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: firstNameController,
                      obscureText: false,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 15.0),
                        hintText: 'First Name',
                        hintStyle: TextStyle(fontSize: 14),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: lastNameController,
                      obscureText: false,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 15.0),
                        hintText: 'Last Name',
                        hintStyle: TextStyle(fontSize: 14),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: phoneController,
                      obscureText: false,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 15.0),
                        hintText: 'Phone Number',
                        hintStyle: TextStyle(fontSize: 14),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: emailController,
                      obscureText: false,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 15.0),
                        hintText: 'Email',
                        hintStyle: TextStyle(fontSize: 14),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 15.0),
                        hintText: 'Password',
                        hintStyle: TextStyle(fontSize: 14),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: confirmPasswordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 15.0),
                        hintText: 'Confirm Password',
                        hintStyle: TextStyle(fontSize: 14),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                      ),
                    )
                  ],
                ),
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Obx(() {
                      return _authService.isLoading.value
                          ? const CircularProgressIndicator()
                          : SubmitButton(
                              text: 'Sign Up',
                              onTap: () async {
                                if (isValid(
                                    nrcController.text.trim(),
                                    firstNameController.text.trim(),
                                    lastNameController.text.trim(),
                                    phoneController.text.trim(),
                                    emailController.text.trim())) {
                                  if (passwordController.text ==
                                      confirmPasswordController.text) {
                                    await _authService.createUser(
                                        nrc: nrcController.text.trim(),
                                        first_name:
                                            firstNameController.text.trim(),
                                        last_name:
                                            lastNameController.text.trim(),
                                        phone_number:
                                            phoneController.text.trim(),
                                        email: emailController.text.trim(),
                                        password:
                                            passwordController.text.trim());
                                  } else {
                                    Get.snackbar(
                                      'Info',
                                      'Passwords not Matching',
                                      snackPosition: SnackPosition.TOP,
                                      backgroundColor: const Color.fromARGB(
                                          255, 143, 173, 226),
                                      colorText: Colors.white,
                                    );
                                  }
                                } else {
                                  return;
                                }
                              },
                            );
                    }),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already have an account?'),
                    const SizedBox(
                      width: 4,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => Login()));
                      },
                      child: const Text(
                        'Login Now',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.orange),
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
    );
  }

  bool isValid(String nrcText, String firstName, String lastName,
      String phoneNumber, String emailText) {
    RegExp nrcRegex = RegExp(
      r'^[0-9.]+',
      caseSensitive: false,
    );

    RegExp emailRegex = RegExp(
      r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+.[a-zA-Z]+',
      caseSensitive: false,
    );

    RegExp firstNameRegex = RegExp(
      r'^[a-zA-Z.]+',
      caseSensitive: false,
    );

    RegExp lastNameRegex = RegExp(
      r'^[a-zA-Z.]+',
      caseSensitive: false,
    );

    RegExp phoneNumberRegex = RegExp(
      r'^[0-9.]+',
      caseSensitive: false,
    );

    if (!firstNameRegex.hasMatch(firstName)) {
      Get.snackbar(
        'Info',
        'Invalid First Name Format',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.blueAccent,
        colorText: Colors.white,
      );
      return false;
    } else if (!lastNameRegex.hasMatch(lastName)) {
      Get.snackbar(
        'Info',
        'Invalid Last Name Format',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.blueAccent,
        colorText: Colors.white,
      );
      return false;
    } else if (!emailRegex.hasMatch(emailText)) {
      Get.snackbar(
        'Info',
        'Invalid email Format',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.blueAccent,
        colorText: Colors.white,
      );
      return false;
    } else if (!phoneNumberRegex.hasMatch(phoneNumber)) {
      Get.snackbar(
        'Info',
        'Invalid phone Format',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.blueAccent,
        colorText: Colors.white,
      );
      return false;
    } else if (!nrcRegex.hasMatch(nrcText)) {
      Get.snackbar(
        'Info',
        'Invalid Nrc Format',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.blueAccent,
        colorText: Colors.white,
      );
      return false;
    } else {
      return true;
    }
  }
}
