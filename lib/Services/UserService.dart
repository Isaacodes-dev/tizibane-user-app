import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:tizibane/models/User.dart';


class UserService{

Future<User> getUser(String nrc) async {
  final response = await http.get(Uri.parse("http://192.168.0.109:8000/api/tizibaneuser/${nrc}"));

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);

    if (data['user'] != null) {
      return User.fromJson(data['user']);
    } else {
      throw Exception('User data is null');
    }
  } else {
    throw Exception('Failed to load user data: ${response.statusCode}');
  }
}

}