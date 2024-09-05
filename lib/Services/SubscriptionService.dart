import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:tizibane/constants/constants.dart';

class SubscriptionService {
  // API endpoint to get subscription data
  final String _subscriptionApiUrl = "$baseUrl/$getSubscriptions";

  // Fetch subscriptions for a given individual_profile_id
  Future<Map<String, dynamic>> getSubscriptionData(
      String individualProfileId) async {
    final String url = '$_subscriptionApiUrl/$individualProfileId';

    try {
      // Make the GET request
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Accept': 'application/json',
          // Add other necessary headers, e.g., authorization if needed
        },
      );

      // Check for a successful response
      if (response.statusCode == 200) {
        // Parse the JSON response
        return jsonDecode(response.body);
      } else {
        throw Exception(
            'Failed to load subscriptions. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching subscription data: $e');
    }
  }

  Future<Map<String, dynamic>?> getActiveSubscription(
      String individualProfileId) async {
    String apiUrl =
        "$baseUrl/$activeSubscription/$individualProfileId"; // Adjust baseUrl according to your setup

    try {
      final response = await http.get(Uri.parse(apiUrl), headers: {
        'Accept': 'application/json',
      });

      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);
        return responseData['data']; // Return the active subscription data
      } else {
        // Handle other status codes
        return null;
      }
    } catch (error) {
      print("Error fetching subscription: $error");
      return null;
    }
  }
}
