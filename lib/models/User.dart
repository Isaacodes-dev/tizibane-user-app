import 'package:http/http.dart' as http;
import 'dart:convert';
class User{
  final String nrc;
  final String fullNames;
  final String phoneNumbers;
  final String email;
  final String profilePic;
  final String password;

  const User({
    required this.nrc,
    required this.fullNames,
    required this.phoneNumbers,
    required this.email,
    required this.profilePic,
    required this.password
  });

  factory User.fromJson(Map<String, dynamic>json)
  {
    return User(
      nrc: json['nrc'],
      fullNames: json['fullNames'] as String,
      phoneNumbers: json['phoneNumbers'] as String,
      email: json['email'] as String,
      profilePic: json['profilePic'] as String,
      password: json['password'] as String
    );
  }

}