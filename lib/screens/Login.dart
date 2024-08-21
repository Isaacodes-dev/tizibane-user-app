import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tizibane/Services/AuthService.dart';
import 'package:tizibane/components/SubmitButton.dart';
import 'package:get/get.dart';
import 'package:tizibane/components/bottommenu/BottomMenuBar.dart';
import 'package:tizibane/screens/Registration.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthService _authService = Get.put(AuthService());
  final box = GetStorage();
  final nrcStorage = GetStorage();
  final _formKey = GlobalKey<FormState>();

  bool _obscureText = true;
  bool _rememberMe = false;

  @override
  void initState() {
    super.initState();
    loadRememberMe();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> loadRememberMe() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _rememberMe = prefs.getBool('remember_me') ?? false;
      if (_rememberMe) {
        emailController.text = prefs.getString('emailValue') ?? '';
        passwordController.text = prefs.getString('password') ?? '';
      }
    });
  }

  Future<void> saveRememberMe() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('remember_me', _rememberMe);
    if (_rememberMe) {
      prefs.setString('emailValue', emailController.text);
      prefs.setString('password', passwordController.text);
    } else {
      prefs.remove('emailValue');
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
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        cursorColor: Colors.black,
                        controller: emailController,
                        obscureText: false,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(40.0),
                          ),
                          suffixIcon: const Icon(
                            Icons.email,
                            color: Colors.black,
                          ),
                          hintText: 'Email',
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 10.0,
                            horizontal: 15.0,
                          ),
                          hintStyle: const TextStyle(fontSize: 14),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                              .hasMatch(value)) {
                            return 'Please enter a valid email';
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
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          if (value.length < 6) {
                            return 'Password must be at least 6 characters long';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 5),
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
                      SizedBox(height: 5),
                      Obx(() {
                        return _authService.isLoading.value
                            ? const CircularProgressIndicator()
                            : SubmitButton(
                                text: 'Sign In',
                                onTap: () async {
                                  if (_formKey.currentState!.validate()) {
                                    await _authService.loginUser(
                                      email: emailController.text.trim(),
                                      password: passwordController.text.trim(),
                                    );
                                    saveRememberMe();
                                  }
                                },
                              );
                      }),
                      SizedBox(height: 25),
                    ],
                  ),
                ),
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Dont have an account?',
                        style: GoogleFonts.lexendDeca()),
                    SizedBox(width: 4),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => Registration());
                      },
                      child: Text(
                        'Sign Up',
                        style: GoogleFonts.lexendDeca(
                            textStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.orange)),
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
