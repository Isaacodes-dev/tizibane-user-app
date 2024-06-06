// import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tizibane/Services/AuthService.dart';
import 'package:tizibane/components/SubmitButton.dart';
import 'package:get/get.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController nrcController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final AuthService _authService = Get.put(AuthService());

  final box = GetStorage();

  final nrcStorage = GetStorage();

  bool _obscureText = true;

  bool _rememberMe = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadRememberMe();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    nrcController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> loadRememberMe() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _rememberMe = prefs.getBool('remember_me') ?? false;
      if (_rememberMe) {
        nrcController.text = prefs.getString('nrcValue') ?? '';
        passwordController.text = prefs.getString('password') ?? '';
      }
    });
  }

  Future<void> saveRememberMe() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('remember_me', _rememberMe);
    if (_rememberMe) {
      prefs.setString('nrcValue', nrcController.text);
      prefs.setString('password', passwordController.text);
    } else {
      prefs.remove('nrcValue');
      prefs.remove('password');
    }
  }

  void _onRememberMeChanged(bool? value) {
    setState(() {
      _rememberMe = value ?? false;
    });
    saveRememberMe();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 230, 230, 230),
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
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Login',
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
                    TextField(
                      cursorColor: Colors.black,
                      controller: nrcController,
                      obscureText: false,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(40.0),
                        ),
                        suffixIcon: const Icon(
                          Icons.credit_card,
                          color: Colors.black,
                        ),
                        hintText: 'Nrc',
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 10.0,
                          horizontal: 15.0,
                        ),
                        hintStyle: const TextStyle(fontSize: 14),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
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
                        hintText: 'Password',
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 10.0,
                          horizontal: 15.0,
                        ),
                        hintStyle: const TextStyle(fontSize: 14),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Checkbox(
                          activeColor: Colors.black,
                          checkColor: Colors.white,
                          value: _rememberMe,
                          onChanged: _onRememberMeChanged,
                        ),
                        Text('Remember Me', style: GoogleFonts.lexendDeca())
                      ],
                    ),
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
                              text: 'Sign In',
                              onTap: () async {
                                await _authService.loginUser(
                                  nrc: nrcController.text.trim(),
                                  password: passwordController.text.trim(),
                                );
                                saveRememberMe();
                              },
                            );
                    }),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              // Center(
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       Text('Dont have an account?',style: GoogleFonts.lexendDeca()),
              //       SizedBox(width: 4),
              //       GestureDetector(
              //         onTap: () {
              //           Get.off(() => Registration());
              //         },
              //         child: Text(
              //           'Sign Up',
              //           style: GoogleFonts.lexendDeca(textStyle: TextStyle(fontWeight: FontWeight.bold,color: Colors.orange)),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
