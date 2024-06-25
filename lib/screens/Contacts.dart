import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tizibane/Services/Connectivity.dart';
import 'package:tizibane/Services/ContactService.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:tizibane/constants/constants.dart';
import 'package:tizibane/models/Contact.dart';
import 'package:tizibane/screens/Contact/ContactEmploymentDetails.dart';
import 'package:tizibane/screens/NFCScanner.dart';
import 'package:tizibane/screens/QRScanner.dart';
import 'package:tizibane/components/share/ShareUrlLink.dart';

class Contacts extends StatefulWidget {
  const Contacts({super.key});

  @override
  State<Contacts> createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {
  ValueNotifier<dynamic> result = ValueNotifier(null);
  final ContactService _contactService = Get.put(ContactService());
  final qrKey = GlobalKey(debugLabel: 'QR');
  final box = GetStorage();
  ConnectivityService _connectivityService = Get.put(ConnectivityService());
  Barcode? resultQr;
  QRViewController? controller;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller?.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _initializeAsync();
    });
  }

  // Future<void> _loadLocalData() async {
  //   if (box.hasData('contacts_data')) {
  //     _contactService.foundContacts.value = box.read('contacts_data');

  //     setState(() {});
  //   }
  // }

  // Future<void> _fetchContactData() async {
  //   try {
  //     await _contactService.getContacts();

  //     setState(() {});

  //     _refreshIfDataChanged();
  //   } catch (error) {
  //     print('Error fetching contacts data: $error');
  //   }
  // }

  void _initializeAsync() {
    _checkConnectivityAndFetchData();
  }

  Future<void> _checkConnectivityAndFetchData() async {
    bool isConnected = await _connectivityService.checkConnectivity();
    if (isConnected) {
      _contactService.getContacts();
    } else {
      _contactService.loadLocalContacts();
    }
  }

  Future<void> _refreshIfDataChanged() async {
    try {
      await _contactService.getContacts();
      if (_contactService.foundContacts.value != box.read('contacts_data')) {
        box.write('contacts_data', _contactService.foundContacts.value);
        setState(() {});
      }
    } catch (error) {
      print('Error checking for data changes: $error');
    }
  }

  void scanQR() {
    Get.to(const QRScanner());
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Image.asset(
            'assets/images/tizibaneicon.png',
            width: 50,
            height: 50,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              const Text(
                'Contacts',
                style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
              ),
              Container(
                decoration: const ShapeDecoration(
                    shape: CircleBorder(
                        side: BorderSide(
                      color: Colors.black,
                    )),
                    color: Colors.black),
                child: IconButton(
                  icon: const Icon(Icons.add),
                  color: Colors.white,
                  iconSize: 30,
                  onPressed: () {
                    openDiaglog();
                  },
                ),
              ),
            ]),
            const SizedBox(height: 20),
            TextField(
              onChanged: (value) => _contactService.filterContact(value),
              decoration: InputDecoration(
                labelText: 'Search',
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 15.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                prefixIcon: const Icon(Icons.search),
              ),
            ),
            const SizedBox(height: 15),
            Obx(() {
              return _contactService.isLoading.value
                  ? const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: CircularProgressIndicator(),
                        ),
                      ],
                    )
                  : Expanded(
                      child: _contactService.foundContacts.value.isNotEmpty
                          ? ListView.builder(
                              itemCount:
                                  _contactService.foundContacts.value.length,
                              itemBuilder: (context, index) {
                                ContactModel contact =
                                    _contactService.foundContacts.value[index];
                                return Card(
                                  shadowColor: Colors.black,
                                  elevation: 3,
                                  child: ListTile(
                                    title: Text(
                                        '${contact.firstName.trim()} ${contact.lastName.trim()}',
                                        style: GoogleFonts.lexendDeca(
                                            textStyle: const TextStyle(
                                                color: Color(0xFF727272),
                                                fontWeight: FontWeight.bold))),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(contact.positionName,
                                            style: GoogleFonts.lexendDeca()),
                                        Text(
                                          contact.companyName,
                                          style: GoogleFonts.lexendDeca(
                                            textStyle: const TextStyle(
                                                color: Colors.orange,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                    leading: CircleAvatar(
                                      radius: 35,
                                      backgroundColor: Colors.grey[
                                          200], // Optional: add a background color
                                      child: ClipOval(
                                        child: CachedNetworkImage(
                                          imageUrl: imageBaseUrl +
                                              contact.profilePicture,
                                          placeholder: (context, url) =>
                                              CircularProgressIndicator(),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error),
                                          fit: BoxFit
                                              .cover, 
                                          width:
                                              60, 
                                          height:
                                              60, 
                                        ),
                                      ),
                                    ),
                                    onLongPress: () {
                                      openDeleteDiaglog(contact.nrc);
                                    },
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ContactEmploymentDetails(
                                                  nrc: contact.nrc,
                                                  phoneNumber:
                                                      contact.phoneNumber,
                                                  companyAddress:
                                                      contact.comapnyAddress,
                                                  companyWebsite:
                                                      contact.comapnyWebsite,
                                                  companyAssignedEmail:
                                                      contact.companyEmail,
                                                  companyLogo:
                                                      contact.companyLogo,
                                                  companyName:
                                                      contact.companyName,
                                                  email: contact.email,
                                                  telephone:
                                                      contact.companyPhone,
                                                  firstName: contact.firstName,
                                                  lastName: contact.lastName,
                                                  positionName:
                                                      contact.positionName,
                                                  profilePath:
                                                      contact.profilePicture,
                                                )),
                                      );
                                    },
                                  ),
                                );
                              },
                            )
                          : Padding(
                              padding: const EdgeInsets.all(30),
                              child: Text('No Contacts to display',
                                  style: GoogleFonts.lexendDeca()),
                            ),
                    );
            }),
          ],
        ),
      ),
      floatingActionButton: const ShareUrlLink(),
    );
  }

  Future openDiaglog() => showDialog(
        context: context,
        builder: (context) => SimpleDialog(
          title: const Text('Add Contact'),
          children: [
            SimpleDialogOption(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: const Text(
                'Scan with NFC',
                style: TextStyle(fontSize: 16),
              ),
              onPressed: () {
                Get.to(NFCScanner());
              },
            ),
            SimpleDialogOption(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: const Text(
                'Scan QR Code',
                style: TextStyle(fontSize: 16),
              ),
              onPressed: () {
                scanQR();
              },
            ),
          ],
        ),
      );
  Future openDeleteDiaglog(String contactNrc) => showDialog(
        context: context,
        builder: (context) => SimpleDialog(
          title: Center(child: const Text('Delete Contact')),
          children: [
            SimpleDialogOption(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Get.back();
                      _contactService.deleteContactFromApp(contactNrc);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: Text(
                      "Yes",
                      style: GoogleFonts.lexendDeca(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: Text(
                      "No",
                      style: GoogleFonts.lexendDeca(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
