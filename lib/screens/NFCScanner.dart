import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:tizibane/Services/ContactService.dart';

class NFCScanner extends StatefulWidget {
  const NFCScanner({super.key});

  @override
  State<NFCScanner> createState() => _NFCScannerState();
}

class _NFCScannerState extends State<NFCScanner> {
  final ContactService _contactService = Get.put(ContactService());

  ValueNotifier<dynamic> result = ValueNotifier(null);

  void _tagRead() {
    result.value = '';
    try {
      NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
        var payload =
            tag.data["ndef"]["cachedMessage"]["records"][0]["payload"];

        var stringPayload = String.fromCharCodes(payload);

        result.value = stringPayload;

        String resultString = result.value.toString();

        String resultSubString = resultString.substring(3);

        if (resultSubString.isNotEmpty) {
          loadUser(resultSubString);

          NfcManager.instance.stopSession();
        } else {
          NfcManager.instance
              .stopSession(errorMessage: "Error reading NFC tag");
        }
      });
    } catch (ex) {
      print("Error starting NFC session: $ex");
    }
  }

  loadUser(resultSubString) async {
    await _contactService.getContact(resultSubString);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tagRead();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
        ),
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Scan NFC Device',
                style: GoogleFonts.lexendDeca(
                  textStyle: const TextStyle(
                      fontSize: 25.0, fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/nfc.png',
                width: 200,
                height: 200,
              ),
            ],
          ),
        ]));
  }
}
