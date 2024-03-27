import 'package:http/http.dart' as http;
import 'dart:convert';
class User{
  final String nrc;
  final String full_names;
  final String phone_number;
  final String email;
  final String password;

  static const String defaultProfilePic = 'assets/images/user.jpg';

  const User({
    required this.nrc,
    required this.full_names,
    required this.phone_number,
    required this.email,
    required this.password
  });

factory User.fromJson(Map<String, dynamic> json) {
  return User(
    nrc: json['nrc'] ?? '',
    full_names: json['full_names'] ?? '',
    phone_number: json['phone_number'] ?? '',
    email: json['email'] ?? '',
    password: json['password'] ?? '',
  );
}
    Map<String, dynamic> toJson() {
    return {
      'nrc': nrc,
      'full_names': full_names,
      'phone_number': phone_number,
      'email': email,
      'password': password,
    };
  }
}

