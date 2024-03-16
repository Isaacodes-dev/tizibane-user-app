import 'package:flutter/material.dart';
import 'package:tizibane/Services/AuthService.dart';
import 'package:tizibane/components/SubmitButton.dart';
import 'package:tizibane/components/bottommenu/BottomMenuBar.dart';
import 'package:tizibane/models/LoginUser.dart';
import 'package:tizibane/screens/Home.dart';
import 'package:tizibane/screens/Registration.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late TextEditingController nrcController;
  late TextEditingController passwordController;
  late LoginUser loginUser;

  @override
  void initState() {
    super.initState();
    nrcController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    loginUser = LoginUser(
      nrc: nrcController.text,
      password: passwordController.text,
    );
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
                ),
              ),
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
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SubmitButton(
                      text: 'Sign In',
                      onTap: () {
                        handleLogin(loginUser);
                      },
                    ),
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

  // Inside the function or method where you want to perform login and navigation
  void handleLogin(LoginUser loginUser) async {
    bool loginSuccessful = await AuthService().loginInUser(loginUser);
    if (loginSuccessful) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => BottomMenuBarItems(nrc: nrcController.text.trim(),),
        ),
      );
    } else {
      // Handle login failure, e.g., show an error message
    }
  }
}
