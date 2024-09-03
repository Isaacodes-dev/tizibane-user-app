import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tizibane/Services/Connectivity.dart';
import 'package:tizibane/constants/constants.dart';

import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:tizibane/screens/Login.dart';

class ProfileService extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isVisible = false.obs;
  final uploadUrl = imageBaseUrl;
  var imagePath = ''.obs;
  RxList<dynamic> countries = <dynamic>[].obs; // Define as RxList
  final box = GetStorage();
  String? imagePathForWidget;
  XFile? _pickedFile;
  XFile? get pickedFile => _pickedFile;
  final _picker = ImagePicker();
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
    } else {
      final prefs = await SharedPreferences.getInstance();
      prefs.getString('imageValue');
      imagePath.value = prefs.getString('imageValue').toString();
      print(imagePath.value);
    }
  }

  // get countries
  Future<void> getCountries() async {
    String accessToken = await getStoredToken();
    bool isConnected = await _connectivityService.checkConnectivity();

    if (isConnected) {
      countries.clear(); // Clear the list before fetching new data

      final response = await http.get(
        Uri.parse("$baseUrl$getCountriesEndpoint"),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);

        if (responseData['status'] == 'success') {
          countries.value = responseData['data'];
        } else {
          throw Exception(
              "Failed to retrieve countries: ${responseData['message']}");
        }
      } else {
        throw Exception(
            'Failed to load countries data: ${response.statusCode}');
      }
    } else {
      throw Exception("No internet connection");
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

  Future<void> pickImage() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        _pickedFile = pickedFile;
        update();
      }
    } catch (e) {
      print("Image picking error: $e");
    }
  }

  Future<void> uploadImage(XFile pickedFile) async {
    if (pickedFile == null) {
      print("No image selected.");
      return;
    }

    isLoading.value = true;

    try {
      String storedNrc = nrcStorage.read('nrcNumber');
      var request = http.MultipartRequest(
          'POST', Uri.parse("$baseUrl$uploadProfilePic/$storedNrc"))
        ..fields['nrc'] = storedNrc
        ..headers['Accept'] = 'application/json'
        ..files
            .add(await http.MultipartFile.fromPath('image', pickedFile.path));

      var streamedResponse =
          await request.send().timeout(Duration(seconds: 30));
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        Get.snackbar(
          'Success',
          'Image uploaded Successfully',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        nrcStorage.remove('nrcNumber');
        Get.to(Login());
      } else {
        Get.snackbar(
          'Error',
          'Image upload failed',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        print("Image upload failed with status: ${response.statusCode}");
      }
    } on SocketException catch (e) {
      print("SocketException: $e");
    } on HttpException catch (e) {
      print("HttpException: $e");
    } on TimeoutException catch (e) {
      print("TimeoutException: $e");
    } catch (e) {
      print("Image upload error: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
