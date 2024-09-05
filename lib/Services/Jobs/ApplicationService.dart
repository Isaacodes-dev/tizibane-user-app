import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tizibane/constants/constants.dart'; // Make sure to define your base URL here

class ApplicationService {
  Future<List<dynamic>> getApplicationsByProfileId(
      String individualProfileId) async {
    final String url = '$baseUrl/$getApplications/$individualProfileId';

    try {
      // Retrieve the token from SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      final String? token = prefs
          .getString('token'); // Adjust the key to match your stored token key

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token', // Add the token to the headers
        },
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData['status'] == 'success') {
          return responseData['data'];
        } else {
          throw Exception('Failed to load applications');
        }
      } else {
        throw Exception('Failed to load applications: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load applications: $e');
    }
  }
}
