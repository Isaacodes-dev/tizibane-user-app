import 'package:http/http.dart' as http;
import 'dart:convert';
class User{
  final String nrc;
  final String first_name;
  final String last_name;
  final String phone_number;
  final String email;
  final String password;
  final String profilePicture;

  static const String defaultProfilePic = 'assets/images/user.jpg';

  const User({
    required this.nrc,
    required this.first_name,
    required this.last_name,
    required this.phone_number,
    required this.email,
    required this.password,
    required this.profilePicture
  });

factory User.fromJson(Map<String, dynamic> json) {
  return User(
    nrc: json['nrc'] ?? '',
    first_name: json['first_name'] ?? '',
    last_name: json['last_name'] ?? '',
    phone_number: json['phone_number'] ?? '',
    email: json['email'] ?? '',
    password: json['password'] ?? '',
    profilePicture: json['profilePicture'] ?? ''
  );
}
    Map<String, dynamic> toJson() {
    return {
      'nrc': nrc,
      'first_name': first_name,
      'last_name': last_name,
      'phone_number': phone_number,
      'email': email,
      'password': password,
      'profilePicture': profilePicture,
    };
  }
}

