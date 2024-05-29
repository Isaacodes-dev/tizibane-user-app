import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tizibane/Services/ContactService.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:tizibane/constants/constants.dart';
import 'package:tizibane/models/Contact.dart';
import 'package:tizibane/screens/Contact/ContactEmploymentDetails.dart';
import 'package:tizibane/screens/QRScanner.dart';
import 'package:tizibane/components/share/ShareUrlLink.dart';

class Contacts extends StatefulWidget {
  const Contacts({super.key});

  //const Contacts({super.key});

  @override
  State<Contacts> createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {
  ValueNotifier<dynamic> result = ValueNotifier(null);
//final getContacts = Get.put<ContactService>(ContactService());
  final ContactService _contactService =
      Get.put(ContactService());

  final qrKey = GlobalKey(debugLabel: 'QR');

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

  void scanQR() {
    Get.to(const QRScanner());
  }

  void _tagRead() {
    try {
      NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
        var payload =
            tag.data["ndef"]["cachedMessage"]["records"][0]["payload"];
        var stringPayload = String.fromCharCodes(payload);
        result.value = stringPayload;
        String resultString = result.value.toString();

        String resultSubString = resultString.substring(3);

        if (resultSubString.isNotEmpty) {
          NfcManager.instance.stopSession();

          loadUser(resultSubString);
        } else {
          print("error");
        }
      });
    } catch (ex) {
      print("Error");
    }
  }

  loadUser(resultSubString) async {
    await _contactService.getContact(resultSubString);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //_contactService.getContacts();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _contactService.getContacts();
    });
  }

  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Image.asset('assets/images/tizibaneicon.png',width: 50,height: 50,),
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
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
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
                                        style: GoogleFonts.lexendDeca(textStyle: const TextStyle(color: Color(0xFF727272),fontWeight: FontWeight.bold))),
                                    subtitle: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(contact.positionName,
                                            style: GoogleFonts.lexendDeca()),
                                        Text(contact.companyName,
                                            style: GoogleFonts.lexendDeca(textStyle: const TextStyle(color: Colors.orange,fontWeight: FontWeight.bold))),
                                      ],
                                    ),
                                    leading: CircleAvatar(
                                      radius: 35,
                                      foregroundImage: NetworkImage(
                                        imageBaseUrl + contact.profilePicture,
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ContactEmploymentDetails(
                                                  nrc: contact.nrc,
                                                  phoneNumber:
                                                      contact.phoneNumber,
                                                  comapnyAddress:
                                                      contact.comapnyAddress,
                                                  comapnyWebsite:
                                                      contact.comapnyWebsite,
                                                  companyAssignedEmail: contact
                                                      .companyEmail,
                                                  companyLogo:
                                                      contact.companyLogo,
                                                  companyName:
                                                      contact.companyName,
                                                  email: contact.email,
                                                  telephone: contact.companyPhone,
                                                  firstName: contact.firstName,
                                                  lastName: contact.lastName,
                                                  positionName:
                                                      contact.positionName,
                                                  profile_path:
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
                _tagRead();
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
}
