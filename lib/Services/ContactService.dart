import 'dart:convert';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tizibane/Services/Connectivity.dart';
import 'package:tizibane/components/bottommenu/BottomMenuBar.dart';
import 'package:tizibane/constants/constants.dart';
import 'package:tizibane/models/Contact.dart';
import 'package:tizibane/screens/Contact/NewContact.dart';

class ContactService extends GetxController {
  final isLoading = false.obs;
  final box = GetStorage();
  final nrcStorage = GetStorage();
  ConnectivityService _connectivityService = Get.put(ConnectivityService()); 

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
    telephone: ''
  ).obs;

  RxList<ContactModel> contactsList = <ContactModel>[].obs;
  RxList<ContactModel> foundContacts = <ContactModel>[].obs;

  final contactStorage = GetStorage();

  @override
  void onInit() {
    super.onInit();
    foundContacts.value = contactsList;
  }

  Future<void> getContact(String nrc) async {
    String accessToken = await getStoredToken();
    bool isConnected = await _connectivityService.checkConnectivity();
    if (isConnected) {
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
          if (responseData['contact'] is List && responseData['contact'].isNotEmpty) {
            contactDetails.value = ContactModel.fromJson(responseData['contact'][0]);
          } else if (responseData['contact'] is Map) {
            contactDetails.value = ContactModel.fromJson(responseData['contact']);
          } else {
            contactDetails.value = ContactModel(
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
          telephone: ''
            );
            throw Exception('Unexpected response format');
          }
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
          throw Exception("Contact data is null");
        }
      } else {
        throw Exception('Failed to fetch contact details: ${response.statusCode}');
      }
    }
  }

  Future<void> getContacts() async {
    bool isConnected = await _connectivityService.checkConnectivity();
    if (isConnected) {
      String accessToken = await getStoredToken();
      String contactSaver = await getStoredNrc();
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
        foundContacts.value = contactsList;
        await saveContactsToLocal(contactsList.map((contact) => contact.toJson()).toList());
        isLoading.value = false;
        update();
      }
      else if(response.statusCode == 404){
        isLoading.value = false;
      } 
      else {
        isLoading.value = false;
        Get.snackbar(
          'Error',
          'Failed to Load Contacts',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    }
  }

Future<void> loadLocalContacts() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.containsKey('contacts')) {
    List<String> contactStrings = prefs.getStringList('contacts') ?? [];
    
    List<ContactModel> contacts = contactStrings.map((e) {
      var json = jsonDecode(e);
      print('Decoded JSON: $json');
      return ContactModel.fromJson(json);
    }).toList();
    foundContacts.value = contacts;
  } else {
    print('No contacts found in SharedPreferences');
  }
}

  Future<void> saveContactsToLocal(List<Map<String, dynamic>> contacts) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> contactStrings = contacts.map((e) => jsonEncode(e)).toList();
    await prefs.setStringList('contacts', contactStrings);
  }

  Future<void> saveContact(Map<String, dynamic> contactBody) async {
    isLoading.value = true;

    String accessToken = await getStoredToken();
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
      await saveContactToPhonebook();
      Get.to(const BottomMenuBarItems(selectedIndex: 1));
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

  Future<void> deleteContactFromApp(String contactNrc) async {
    isLoading.value = true;

    String accessToken = await getStoredToken();
    String contactSaverNrc = await getStoredNrc();

    final response = await http.delete(
      Uri.parse('$baseUrl$deleteContact/$contactSaverNrc/$contactNrc'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      isLoading.value = false;
      Get.snackbar(
        'Success',
        'Contact Deleted Successfully',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      await getContacts();
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
          phones: [Item(label: 'mobile', value: contactDetails.value.phoneNumber)],
          emails: [Item(label: 'work', value: contactDetails.value.email)],
        );

        await ContactsService.addContact(contact);
      } catch (e) {
        Get.snackbar(
          'Error',
          'Failed to save contact: $e',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } else {
      Get.snackbar(
        'Error',
        'Permission to access contacts is denied',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void filterContact(String contact) {
    List<ContactModel> results = [];

    if (contact.trim().isEmpty) {
      results = contactsList;
    } else {
      results = contactsList.where((element) {
        final trimmedContact = contact.toLowerCase().trim();
        final fullName = '${element.firstName.toLowerCase()} ${element.lastName.toLowerCase()}';
        return fullName.contains(trimmedContact);
      }).toList();
    }

    foundContacts.value = results;
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
