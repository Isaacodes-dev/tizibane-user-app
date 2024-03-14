import 'package:flutter/material.dart';
import 'package:tizibane/Components/SubmitButton.dart';
import 'package:tizibane/screens/Login.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
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
                  width: width,
                  height: height * 0.35,
                  child: Image.asset(
                    'assets/images/Tizibane.png',
                    fit: BoxFit.fill,
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
                      controller: phoneController,
                      obscureText: false,
                      decoration: InputDecoration(
                        hintText: 'Phone Number',
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
                        hintText: 'Confirm Password',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                      ),
                    )
                  ],
                ),
              ),
              const Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SubmitButton(text: 'Sign Up'),
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
