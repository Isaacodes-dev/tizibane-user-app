import 'package:flutter/material.dart';
import 'package:tizibane/Services/AuthService.dart';
import 'package:tizibane/components/SubmitButton.dart';
import 'package:tizibane/components/bottommenu/BottomMenuBar.dart';
import 'package:tizibane/models/LoginUser.dart';
import 'package:tizibane/screens/Home.dart';
import 'package:tizibane/screens/Registration.dart';
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
              )),
              const Padding(
                padding: EdgeInsets.all(10.0),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(
                    'Login',
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
                        hintText: 'Nrc',
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 15.0),
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
                        hintText: 'Password',
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 15.0),
                        hintStyle: TextStyle(fontSize: 14),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // const SizedBox(height: 20),
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
                                    password: passwordController.text.trim());
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
                    Text('Dont have an account?'),
                    const SizedBox(
                      width: 4,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Registration()));
                      },
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.orange),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
