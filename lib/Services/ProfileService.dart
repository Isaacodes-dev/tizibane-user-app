import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:tizibane/constants/constants.dart';

class ProfileService extends GetxController {
  final url = baseUrl + uploadProfilePic;

  var imagePath = ''.obs;

  XFile? _pickedFile;

  String? imagePathForWidget;

  XFile? get pickedFile=> _pickedFile;

  final _picker = ImagePicker();
  
  

  final box = GetStorage();
  final nrcStorage = GetStorage();
  
  

    Future<void> changeProfilePicture() async {
    _pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    update();

  }

  Future<bool> upload() async
  {
    update();

    bool success = false;

    http.StreamedResponse response = await updateProfile(_pickedFile);
    if(response.statusCode == 200)
    {
      Map map = jsonDecode(await response.stream.bytesToString());
      String message = map['message'];
      success = true;
      Get.snackbar('Success','Image uploaded Successfully',          
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.green,
      colorText: Colors.white,);
      getImagePath();
    }else{
      print('Error uploading image');
      print(response.reasonPhrase);
    }
    update();

    return success;
  }
  
  Future<http.StreamedResponse> updateProfile(XFile? data) async{
    String storedNrc = nrcStorage.read('nrcNumber');
    String accessToken = box.read('token');
    http.MultipartRequest request = http.MultipartRequest('POST', Uri.parse(url + '/$storedNrc'));
    request.headers.addAll({
      'Accept': 'application/json',
      'Authorization': 'Bearer $accessToken',
    });

    if(GetPlatform.isMobile && data != null)
    {
      File _file = File(data.path);

      request.files.add(http.MultipartFile('image', _file.readAsBytes().asStream(), _file.lengthSync(),filename: _file.path.split('/').last));

    }

    http.StreamedResponse response = await request.send();

    return response;
  }

  Future<void> getImagePath() async{
    String accessToken = box.read('token');
    String storedNrc = nrcStorage.read('nrcNumber');

      final response = await http.get(
      Uri.parse(baseUrl+ getImage + "/$storedNrc"),
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
