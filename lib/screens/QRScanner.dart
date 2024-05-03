import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:tizibane/Services/ContactService.dart';
import 'package:tizibane/Services/UserService.dart';
import 'package:tizibane/components/bottommenu/BottomMenuBar.dart';
import 'package:tizibane/screens/Contact/NewContact.dart';

class QRScanner extends StatefulWidget {
  const QRScanner({super.key});

  @override
  State<QRScanner> createState() => _QRScannerState();
}

class _QRScannerState extends State<QRScanner> {
  final ContactService _contactService = Get.put(ContactService());

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  Barcode? result;

  QRViewController? controller;

  String? userNrc;

  loadUser(userNrc) async {
    await _contactService.getContact(userNrc);
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: (result != null) ? Text('') : Text('Scan a code'),
            ),
          )
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    reset();
    this.controller = controller;
    bool isUserLoaded = false;

    controller.scannedDataStream.listen((scanData) {
      if (!isUserLoaded) {
        setState(() {
          result = scanData;
          userNrc = result!.code.toString();
          loadUser(userNrc);
          isUserLoaded = true;
          controller.stopCamera();
        });
        controller.dispose();
        reset();
      } else {
        Get.offAll(BottomMenuBarItems(selectedIndex: 1));
        reset();
      }
    });
  }

  void reset() {
    setState(() {
      result = null;
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
