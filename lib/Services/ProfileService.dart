import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:flutter/material.dart';
import 'package:tizibane/constants/constants.dart';

class ProfileService extends GetxController {
  
  RxBool isLoading = false.obs;

  RxBool isVisible = false.obs;
  
  final url = baseUrl + uploadProfilePic;

  var imagePath = ''.obs;

  XFile? _pickedFile;

  XFile? defaultPic;

  String? imagePathForWidget;

  XFile? get pickedFile => _pickedFile;

  final box = GetStorage();
  final nrcStorage = GetStorage();
  late Uint8List imageData;

Future<XFile?> assetToXFile(String assetName) async {
  ByteData assetByteData = await rootBundle.load(assetName);
  List<int> byteData = assetByteData.buffer.asUint8List();
  String tempPath = (await getTemporaryDirectory()).path;
  String filePath = path.join(tempPath, assetName.split('/').last);

  // Write the asset to the file
  await File(filePath).writeAsBytes(byteData);

  // Return the XFile
  return XFile(filePath);
}


Future<XFile?> convertAssetToXFile() async {
  String assetPath = 'assets/images/user.jpg'; // Replace with your asset path
  ByteData assetByteData = await rootBundle.load(assetPath);
  List<int> byteData = assetByteData.buffer.asUint8List();
  String tempPath = (await getTemporaryDirectory()).path;
  String filePath = path.join(tempPath, assetPath.split('/').last);

  // Write the asset to the file
  await File(filePath).writeAsBytes(byteData);

  // Return the XFile
  return XFile(filePath);
}

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
