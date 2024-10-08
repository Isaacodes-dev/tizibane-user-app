import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'dart:io';
import 'package:tizibane/Services/ContactService.dart';
import 'package:tizibane/components/bottommenu/BottomMenuBar.dart';
import 'package:tizibane/components/share/ShareUrlLink.dart';

class QRScanner extends StatefulWidget {
  const QRScanner({super.key});

  @override
  State<QRScanner> createState() => _QRScannerState();
}

class _QRScannerState extends State<QRScanner> {
  //final ContactService _contactService = Get.put(ContactService());

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  Barcode? result;

  QRViewController? controller;

  String userNrc = '';

  // loadUser(userNrc) async {
  //   print(userNrc);
  //   await _contactService.getContact(userNrc);
  // }

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
              child: (result != null) ? const Text('') : const Text('Scan a code'),
            ),
          )
        ],
      ),
      // floatingActionButton: const ShareUrlLink(),
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
          print(result!.code.toString());
          userNrc = result!.code.toString();
          isUserLoaded = true;
        });
        controller.stopCamera();
        controller.dispose();
      } else {
        Get.offAll(const BottomMenuBarItems(selectedIndex: 1));
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
