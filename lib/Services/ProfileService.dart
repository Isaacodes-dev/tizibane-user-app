import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:tizibane/constants/constants.dart';

class ProfileService extends GetxController {
  
  RxBool isLoading = false.obs;

  RxBool isVisible = false.obs;
  
  final url = baseUrl + uploadProfilePic;

  var imagePath = ''.obs;

  final box = GetStorage();
  final nrcStorage = GetStorage();
  late Uint8List imageData;

  Future<void> getImagePath() async {
    String accessToken = box.read('token');
    String storedNrc = nrcStorage.read('nrcNumber');

    final response = await http.get(
      Uri.parse(baseUrl + getImage + "/$storedNrc"),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);

      if (responseData['imagePath'] != null) {
        imagePath.value = responseData['imagePath'];
      } else {
        throw Exception("Image data is null");
      }
    } else {
      throw Exception('Failed to load image data: ${response.statusCode}');
    }
  }

}
