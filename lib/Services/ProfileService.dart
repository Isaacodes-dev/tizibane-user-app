import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tizibane/Services/Connectivity.dart';
import 'package:tizibane/constants/constants.dart';

class ProfileService extends GetxController {
  RxBool isLoading = false.obs;

  RxBool isVisible = false.obs;

  final url = baseUrl + uploadProfilePic;

  var imagePath = ''.obs;

  final box = GetStorage();

  final nrcStorage = GetStorage();

  late Uint8List imageData;

  ConnectivityService _connectivityService = Get.put(ConnectivityService());

  Future<void> getImagePath() async {
    String accessToken = await getStoredToken();
    
    String storedNrc = await getStoredNrc();
    bool isConnected = await _connectivityService.checkConnectivity();
    
    if (isConnected) {

      imagePath.value = '';

      final response = await http.get(
        Uri.parse("$baseUrl$getImage/$storedNrc"),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);

        if (responseData['imagePath'] != null) {
          imagePath.value = responseData['imagePath'];
          final prefs = await SharedPreferences.getInstance();
          prefs.setString('imageValue', imagePath.value);
        } else {
          imagePath.value = '';

          throw Exception("Image data is null");
        }
      } else {
        throw Exception('Failed to load image data: ${response.statusCode}');
      }
    } else{
      final prefs = await SharedPreferences.getInstance();
      prefs.getString('imageValue');
      imagePath.value = prefs.getString('imageValue').toString(); 
      print(imagePath.value);
    }
  }
    Future<String> getStoredToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token') ?? '';
  }

  Future<String> getStoredNrc() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('nrcNumber') ?? '';
  }

}
