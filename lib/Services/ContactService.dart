import 'dart:convert';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:tizibane/components/bottommenu/BottomMenuBar.dart';
import 'package:tizibane/constants/constants.dart';
import 'package:tizibane/models/Contact.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tizibane/screens/Contact/NewContact.dart';

class ContactService extends GetxController {
  final isLoading = false.obs;
  final box = GetStorage();
  final nrcStorage = GetStorage();
  var contactDetails = ContactModel(
          nrc: '',
          fullNames: '',
          phoneNumber: '',
          email: '',
          roleId: '',
          createdAt: '',
          updatedAt: '',
          profilePicture: '')
      .obs;

  var contactsList = <ContactModel>[].obs;

  var recentContactsList = <ContactModel>[].obs;

  var getRecentContactsDetails = <ContactModel>[].obs;

  final contactStorage = GetStorage();

  @override
  void onInit() {
    super.onInit();
    getContacts();
    getRecentContacts();
  }

  Future<void> getContact(String nrc) async {
    String accessToken = box.read('token');

    final response = await http.get(
      Uri.parse(baseUrl + getContactDetails + "/$nrc"),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);

      if (responseData['contact'] != null) {
        ContactModel contact;
        if (responseData['contact'] is List) {
          // If responseData['contact'] is a list, assume the first element contains the contact
          contact = ContactModel.fromJson(responseData['contact'][0]);
        } else if (responseData['contact'] is Map) {
          // If responseData['contact'] is a map, assume it contains the contact directly
          contact = ContactModel.fromJson(responseData['contact']);
        } else {
          throw Exception('Unexpected response format');
        }

        contactDetails.value = contact;

        Get.offAll(() => NewContact(
              contactNrc: contactDetails.value.nrc,
              fullNames: contactDetails.value.fullNames,
              email: contactDetails.value.email,
              phoneNumber: contactDetails.value.phoneNumber,
              profilePicture: contactDetails.value.profilePicture,
            ));
      } else {
        throw Exception("Contact data is null");
      }
    } else {
      throw Exception(
          'Failed to fetch contact details: ${response.statusCode}');
    }
  }

Future<void> getContacts() async {
  String accessToken = box.read('token');
  String contactSaver = nrcStorage.read('nrcNumber');
  isLoading.value = true;
  final response = await http.get(
    Uri.parse(baseUrl + getContactsDetails + "/$contactSaver"),
    headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $accessToken',
    },
  );

  if (response.statusCode == 200) {
    List<dynamic> data = jsonDecode(response.body)['contacts'];
    contactsList.value = data.map((e) => ContactModel.fromJson(e)).toList();
    isLoading.value = false;
    update(); // Notify the UI that data has changed
  } else {
    isLoading.value = false;
    Get.snackbar(
      'Error',
      'Failed to Load Contacts',
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
    print('${response.statusCode} :${response.reasonPhrase}');
  }
}

Future<void> getRecentContacts() async {
  String accessToken = box.read('token');
  String contactSaver = nrcStorage.read('nrcNumber');
  isLoading.value = true;
  final response = await http.get(
    Uri.parse(baseUrl + getRecentAddedContacts + "/$contactSaver"),
    headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $accessToken',
    },
  );

  if (response.statusCode == 200) {
    List<dynamic> data = jsonDecode(response.body)['contacts'];
    recentContactsList.value = data.map((e) => ContactModel.fromJson(e)).toList();
    isLoading.value = false;
    update(); // Notify the UI that data has changed
  } else {
    isLoading.value = false;
    Get.snackbar(
      'Error',
      'Failed to Load Contacts',
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
    print('${response.statusCode} :${response.reasonPhrase}');
  }
}

  Future<void> saveContact(Map<String, dynamic> contactBody) async {
    isLoading.value = true;
    String contactSaverNrc = nrcStorage.read('nrcNumber');
    String accessToken = box.read('token');
    final response = await http.post(
      Uri.parse(baseUrl + saveContacDetails),
      body: contactBody,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );
    if (response.statusCode == 201) {
      isLoading.value = false;
      Get.snackbar(
        'Success',
        'Contact Saved Successfully',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      saveContactToPhonebook();
      contactDetails.value = ContactModel(
              nrc: '',
              fullNames: '',
              phoneNumber: '',
              email: '',
              roleId: '',
              createdAt: '',
              updatedAt: '',
              profilePicture: '')
          .obs as ContactModel;
      ;
    } else {
      isLoading.value = false;
      print('Data not posted ${response.body}');
    }
  }

  Future<void> saveContactToPhonebook() async {
    update();
    // Request permission to access contacts
    PermissionStatus permissionStatus = await Permission.contacts.request();
    if (permissionStatus.isGranted) {
      // Permission granted, proceed to save contact
      try {
        // Create a new contact
        Contact contact = Contact(
          givenName: contactDetails.value.fullNames,
          phones: [
            Item(label: 'mobile', value: contactDetails.value.phoneNumber)
          ],
          emails: [Item(label: 'work', value: contactDetails.value.email)],
        );
        // Save the contact
        await ContactsService.addContact(contact);
        print('Contact saved successfully');
        // Navigate to the desired screen
        Get.offAll(() => BottomMenuBarItems());
      } catch (e) {
        print('Failed to save contact: $e');
        // Handle the error as needed (e.g., show an error message to the user)
      }
    } else {
      // Permission to access contacts is denied
      print('Permission to access contacts is denied');
      // Handle the denied permission (e.g., show a dialog or request permission again)
    }
  }
}
