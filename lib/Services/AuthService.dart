import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:tizibane/components/bottommenu/BottomMenuBar.dart';
import 'package:tizibane/models/LoginUser.dart';
import 'dart:convert';
import 'package:tizibane/models/User.dart';

class AuthService {
  Future<void> createUser(User user) async {
    try {
      // Define the URL of your Laravel endpoint
      const String url = 'http://192.168.0.109:8000/api/registeruser';

      // Convert the user object to a JSON string
      final jsonString = jsonEncode(user.toJson());

      // Make the POST request
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonString,
      );

      // Check the response status code
      if (response.statusCode == 201) {
        print('User created successfully');
      } else {
        print('Failed to create user. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error creating user: $e');
    }
  }

Future<bool> loginInUser(LoginUser loginUser) async {
  try {
    // Define the URL of your Laravel endpoint
    const String url = 'http://192.168.0.109:8000/api/loginuser';

    // Convert the user object to a JSON string
    final jsonString = jsonEncode(loginUser.toJson());

    // Make the POST request
    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonString,
    );

    // Check the response status code
    if (response.statusCode == 200) {
      print('User logged in successfully');
      print('Response body: ${response.body}');
      return true; // Return true if login is successful
    } else {
      print('Failed to create user. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      return false; // Return false if login fails
    }
  } catch (e) {
    print('Error login user: $e');
    return false; // Return false if an error occurs
  }
}
}
