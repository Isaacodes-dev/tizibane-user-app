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
          firstName: '',
          lastName: '',
          phoneNumber: '',
          email: '',
          roleId: '',
          createdAt: '',
          updatedAt: '',
          profilePicture: '',
          positionName: '',
          companyName: '',
          companyLogo: '',
          companyAssignedEmail: '',
          companyEmail: '',
          companyPhone: '',
          comapnyWebsite: '',
          comapnyAddress: '',
          telephone: '')
      .obs;

  var contactsList = <ContactModel>[].obs;

  Rx<List<ContactModel>> foundContacts = Rx<List<ContactModel>>([]);

  final contactStorage = GetStorage();

  @override
  void onInit() {
    super.onInit();
    getContacts();
    foundContacts.value = contactsList;
  }

  Future<void> getContact(String nrc) async {
    String accessToken = box.read('token');

    final response = await http.get(
      Uri.parse("$baseUrl$getContactDetails/$nrc"),
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
          if (responseData['contact'].isNotEmpty) {
            contact = ContactModel.fromJson(responseData['contact'][0]);
            contactDetails.value = contact;
            Get.to(() => NewContact(
                  contactNrc: contactDetails.value.nrc,
                  firstName: contactDetails.value.firstName,
                  lastName: contactDetails.value.lastName,
                  email: contactDetails.value.email,
                  phoneNumber: contactDetails.value.phoneNumber,
                  profilePicture: contactDetails.value.profilePicture,
                  positionName: contactDetails.value.positionName,
                  companyName: contactDetails.value.companyName,
                ));
          } else {
            Get.snackbar(
              'Info',
              'Contact Does not Exit',
              snackPosition: SnackPosition.TOP,
              backgroundColor: Colors.blueAccent,
              colorText: Colors.white,
            );
          }
        } else if (responseData['contact'] is Map) {
          contact = ContactModel.fromJson(responseData['contact']);
        } else {
          throw Exception('Unexpected response format');
        }
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
      Uri.parse("$baseUrl$getContactsDetails/$contactSaver"),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body)['contacts'];
      contactsList.value = data.map((e) => ContactModel.fromJson(e)).toList();
      isLoading.value = false;
      update();
    } else if (response.statusCode == 404) {
      isLoading.value = false;
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
      Get.to(const BottomMenuBarItems(
        selectedIndex: 1,
      ));
    } else if (response.statusCode == 409) {
      isLoading.value = false;
      Get.snackbar(
        'Info',
        'You have already saved this contact',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.blueAccent,
        colorText: Colors.white,
      );
    } else {
      isLoading.value = false;
      Get.snackbar(
        'Error',
        jsonDecode(response.body)['message'],
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> saveContactToPhonebook() async {
    update();

    PermissionStatus permissionStatus = await Permission.contacts.request();
    if (permissionStatus.isGranted) {
      try {
        String combineNames = '${contactDetails.value.firstName} ${contactDetails.value.lastName}';
        Contact contact = Contact(
          givenName: combineNames,
          phones: [
            Item(label: 'mobile', value: contactDetails.value.phoneNumber)
          ],
          emails: [Item(label: 'work', value: contactDetails.value.email)],
        );

        await ContactsService.addContact(contact);
      } catch (e) {
        print('Failed to save contact: $e');
      }
    } else {
      print('Permission to access contacts is denied');
    }
  }

  void filterContact(String contact) {
    List<ContactModel> results = [];

    if (contact.trim().isEmpty) {
      results = contactsList;
    } else {
      results = contactsList.where((element) {
        final trimmedContact = contact.toLowerCase().trim();
        final fullName =
            '${element.firstName.toLowerCase()} ${element.lastName.toLowerCase()}';
        return fullName.contains(trimmedContact);
      }).toList();
    }

    foundContacts.value = results;
  }
}
