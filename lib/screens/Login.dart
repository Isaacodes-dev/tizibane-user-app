import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tizibane/Services/AuthService.dart';
import 'package:tizibane/components/SubmitButton.dart';
import 'package:tizibane/screens/Home.dart';
import 'package:tizibane/screens/Registration.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController nrcController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final AuthService _authService = Get.put(AuthService());

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 230, 230, 230),
      body: Container(
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
              Padding(
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
                padding: EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    TextField(
                      controller: nrcController,
                      obscureText: false,
                      decoration: InputDecoration(
                        hintText: 'Nrc',
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0,
                          horizontal: 15.0,
                        ),
                        hintStyle: TextStyle(fontSize: 14),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0,
                          horizontal: 15.0,
                        ),
                        hintStyle: TextStyle(fontSize: 14),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Obx(
                          () => Checkbox(
                            activeColor: Colors.black,
                            checkColor: Colors.white,
                            value: _authService.rememberMe.value,
                            onChanged: (value) {
                              _authService.toggleRememberMe(value!);
                            },
                          ),
                        ),
                        Text('Remember Me',style: GoogleFonts.lexendDeca())
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
                          ? CircularProgressIndicator()
                          : SubmitButton(
                              text: 'Sign In',
                              onTap: () async {
                                await _authService.loginUser(
                                  nrc: nrcController.text.trim(),
                                  password: passwordController.text.trim(),
                                );
                              },
                            );
                    }),
                  ],
                ),
              ),
              SizedBox(height: 25),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Dont have an account?',style: GoogleFonts.lexendDeca()),
                    SizedBox(width: 4),
                    GestureDetector(
                      onTap: () {
                        Get.off(() => Registration());
                      },
                      child: Text(
                        'Sign Up',
                        style: GoogleFonts.lexendDeca(textStyle: TextStyle(fontWeight: FontWeight.bold,color: Colors.orange)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
