import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:tizibane/constants/constants.dart';
import 'package:tizibane/models/Group.dart';

class GroupsService extends GetxController {
  final isLoading = false.obs;

  final box = GetStorage();

  final nrcStorage = GetStorage();

  var groupsList = <Group>[].obs;

  var groupDetails = Group(
          group_id: '',
          group_logo: '',
          group_name: '',
          group_phone_number: '',
          group_email: '',
          )
      .obs;

  @override
  void onInit() {
    super.onInit();
    getGroups();
  }

  Future<void> getGroups() async {
    isLoading.value = true;

    String accessToken = box.read('token');

    String nrc = nrcStorage.read('nrcNumber');

    final response = await http.get(
      Uri.parse("$baseUrl$groupsdetails/$nrc"),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      isLoading.value = false;

      var responseData = jsonDecode(response.body);

      if (responseData['groups'] != null) {
        List<dynamic> data = jsonDecode(response.body)['groups'];
        groupsList.value = data.map((e) => Group.fromJson(e)).toList();
        update();
      } else {
        isLoading.value = false;
        throw Exception("Group data is null");
      }
    } else {
      isLoading.value = false;
      throw Exception('Failed to fetch group details: ${response.statusCode}');
    }
  }
}
