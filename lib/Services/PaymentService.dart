// ignore_for_file: prefer_const_declarations

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:tizibane/constants/constants.dart';

class PaymentService {
  Future<bool> makePayment({
    required String subscriberType,
    required String subscriberId,
  }) async {
    // const url = baseUrl + register; // Replace with your API endpoint
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode({
      'subscriber_type': subscriberType,
      'subscriber_id': subscriberId,
    });

    try {
      final response = await http.post(
        Uri.parse("$baseUrl/$initiatePayment"),
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        // Assuming API returns a JSON with a success flag
        final responseData = json.decode(response.body);
        return responseData['success'] ?? false;
      } else {
        return false;
      }
    } catch (e) {
      // Handle error
      print('Error making payment: $e');
      return false;
    }
  }
}
