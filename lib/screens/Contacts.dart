import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tizibane/Services/UserService.dart';
import 'package:tizibane/components/Alerts/AlertDialog.dart';
import 'package:tizibane/components/NFC.dart';
import 'package:tizibane/components/drawer/sidemenu.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:tizibane/models/Contact.dart';
import 'package:tizibane/screens/Contact/NewContact.dart';
import 'package:tizibane/screens/Contact/ViewContact.dart';
import 'package:tizibane/screens/QRScanner.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class Contacts extends StatefulWidget {
  //const Contacts({super.key});

  @override
  State<Contacts> createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {
  
  ValueNotifier<dynamic> result = ValueNotifier(null);
  
  List<Contact> contacts = [];
  
  final qrKey = GlobalKey(debugLabel: 'QR');
  
  Barcode? resultQr;

  QRViewController? controller;

  @override
  void reassemble(){
    super.reassemble();
    if(Platform.isAndroid)
    {
      controller!.pauseCamera();
    }else if(Platform.isIOS){
      controller!.resumeCamera();
    }
  }

  void scanQR(){

      setState(() {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => QRScanner()));
      });
      
  }

    void _tagRead() {
      try{
            
            NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
            var payload = tag.data["ndef"]["cachedMessage"]["records"][0]["payload"];
            var stringPayload = String.fromCharCodes(payload);
            result.value = stringPayload;
            String resultString = result.value.toString();

            String resultSubString = resultString.substring(3);
            
            if(resultSubString.isNotEmpty)
            {
                NfcManager.instance.stopSession();
                
                // loadUser(resultSubString);

            }
            else
            {
              print("error");
            }
                  
        });
      }catch(ex)
      {
        print("Error");
      }
   
  }

  //   loadUser(userNrc) async
  // {
  //   final user = await UserService().getUser(userNrc);
  //   setState(() {
  //     Navigator.of(context).push(
  //           MaterialPageRoute(builder: (context) => NewContact(full_names: user.full_names,phone_number: user.phone_number,email: user.email,)));
  //   });
      
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 0, 52, 105),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(
                'Contacts',
                style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
              ),
              Container(
                decoration: const ShapeDecoration(
                    shape: CircleBorder(
                        side: BorderSide(
                      color: Color.fromARGB(255, 0, 52, 105),
                    )),
                    color: Color.fromARGB(255, 0, 52, 105)),
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
              decoration: InputDecoration(
                labelText: 'Search',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                prefixIcon: Icon(Icons.search),
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    title: Text('Isaac Mulenga'),
                    subtitle: Text('0973700796'),
                    leading: CircleAvatar(
                      child: Text('IM'),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ViewContact(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    title: Text('James Mulenga'),
                    subtitle: Text('0973700797'),
                    leading: CircleAvatar(child: Text('JM')),
                  ),
                  ListTile(
                    title: Text('Mutale Phiri'),
                    subtitle: Text('0973700596'),
                    leading: CircleAvatar(child: Text('MP')),
                  ),
                  ListTile(
                    title: Text('Banda Phiri'),
                    subtitle: Text('0973701798'),
                    leading: CircleAvatar(child: Text('BP')),
                  ),
                  ListTile(
                    title: Text('Kennedy Mulenga'),
                    subtitle: Text('0973704797'),
                    leading: CircleAvatar(child: Text('KM')),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future openDiaglog() => showDialog(
        context: context,
        builder: (context) => SimpleDialog(
          title: Text('Add Contact'),
          children: [
            SimpleDialogOption(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: Text(
                'Scan with NFC',
                style: TextStyle(fontSize: 16),
              ),
              onPressed: () {
                // setState(() {

                // });
                _tagRead();
              },
            ),
            SimpleDialogOption(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: Text(
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
