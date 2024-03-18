import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:tizibane/Services/UserService.dart';
import 'package:tizibane/screens/Contact/NewContact.dart';

class NFC extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => NFCState();
}

class NFCState extends State<NFC> {
  ValueNotifier<dynamic> result = ValueNotifier(null);

    String? userNrc;

  loadUser(userNrc) async
  {
    final user = await UserService().getUser(userNrc);
    setState(() {
      Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => NewContact(full_names: user.full_names,phone_number: user.phone_number,email: user.email,)));
    });
      
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('NfcManager Plugin Example')),
        body: SafeArea(
          child: FutureBuilder<bool>(
            future: NfcManager.instance.isAvailable(),
            builder: (context, ss) => ss.data != true
                ? Center(child: Text('NfcManager.isAvailable(): ${ss.data}'))
                : Flex(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    direction: Axis.vertical,
                    children: [
                      Flexible(
                        flex: 2,
                        child: Container(
                          margin: EdgeInsets.all(4),
                          constraints: BoxConstraints.expand(),
                          decoration: BoxDecoration(border: Border.all()),
                          child: SingleChildScrollView(
                            child: ValueListenableBuilder<dynamic>(
                              valueListenable: result,
                              builder: (context, value, _) =>
                                  Text('${value ?? ''}'),
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 3,
                        child: GridView.count(
                          padding: EdgeInsets.all(4),
                          crossAxisCount: 2,
                          childAspectRatio: 4,
                          crossAxisSpacing: 4,
                          mainAxisSpacing: 4,
                          children: [
                            ElevatedButton(
                                child: Text('Tag Read'), onPressed: _tagRead),
                          ],
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  void _tagRead() {
    // NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
    //   var payload = tag.data["ndef"]["cachedMessage"]["records"][0]["payload"];
    //   var stringPayload = String.fromCharCodes(payload);
    //   result.value = stringPayload;
    //   print("Hello");
    //   print(result.value);
    //   NfcManager.instance.stopSession();
    // });
    print("hello");
  }

}