import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tizibane/constants/constants.dart';
import 'package:tizibane/models/User.dart';

class UserService extends GetxController {
  @override
  void initState() {
    getUser();
  }
  final isLoading = false.obs;
  var userObj =
      User(nrc: '', full_names: '', phone_number: '', email: '', password: '')
          .obs;
  final box = GetStorage();
  final nrcStorage = GetStorage();
  final url = baseUrl + tizibaneUser;

  Future<void> getUser() async {
    String accessToken = box.read('token');
    String storedNrc = nrcStorage.read('nrcNumber');

    if (storedNrc == null) {
      throw Exception("Stored 'nrcNumber' is null");
    }

    final response = await http.get(
      Uri.parse(url + "/$storedNrc"),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );
    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      if (responseData['user'] != null) {
        userObj.value = User.fromJson(responseData['user']);
      } else {
        throw Exception("User data is null");
      }
    } else {
      throw Exception('Failed to load user data: ${response.statusCode}');
    }
  }
}
