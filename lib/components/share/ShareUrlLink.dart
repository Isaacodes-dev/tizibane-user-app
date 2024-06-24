// ignore_for_file: no_leading_underscores_for_local_identifiers, use_build_context_synchronously, invalid_use_of_protected_member, non_constant_identifier_names

import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tizibane/Services/UserService.dart';

class ShareUrlLink extends StatelessWidget {
  const ShareUrlLink({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        // Get the NRC from UserService
        String? nrc = await _getUserNrc();

        if (nrc != null) {
          // Prepare vCard data
          String vCardData = '''
          BEGIN:VCARD
          VERSION:3.0
          FN:User
          NOTE:$nrc
          URL:https://tizibane.com/api/share/$nrc
          END:VCARD
          ''';

          // Write the vCard data to a file and share it
          await _shareVCard(vCardData);
        }

        // Show the popup when button is clicked
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Share to Socials'),
              content: Text('Share this vCard with others.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: const Text('Close'),
                ),
              ],
            );
          },
        );
      },
      backgroundColor: Colors.black, // Customize button color
      elevation: 4.0,
      child: const CircleAvatar(
        backgroundColor: Colors.black, // Background color of the circle avatar
        child: Icon(
          CupertinoIcons.share,
          color: Colors.white, // Color of the icon
        ),
      ), // Customize button shadow
    );
  }

  Future<String?> _getUserNrc() async {
    UserService _userService = UserService();
    await _userService.getUser();
    String unformattedNrc = _userService.userObj.value[0].nrc;
    return encryptNrc(unformattedNrc);
  }

  Future<String?> encryptNrc(String? nrc) async {
    if (nrc == null) return null;

    int shift = 7;
    String formattedNrc = '';

    for (int i = 0; i < nrc.length; i++) {
      int charCode = nrc.codeUnitAt(i);

      if (charCode >= 97 && charCode <= 122) {
        charCode -= 32;
      }

      if ((charCode >= 65 && charCode <= 90) ||
          (charCode >= 48 && charCode <= 57)) {
        int shiftedCharCode = (charCode + shift);

        if (shiftedCharCode > 90 && charCode <= 90) {
          shiftedCharCode = 65 + (shiftedCharCode - 91);
        } else if (shiftedCharCode > 57) {
          shiftedCharCode = 48 + (shiftedCharCode - 58);
        }

        formattedNrc += String.fromCharCode(shiftedCharCode);
      }
    }

    return formattedNrc;
  }

  Future<void> _shareVCard(String vCardData) async {
    // Get the directory to save the file.
    final directory = await getApplicationDocumentsDirectory();

    // Define the file path.
    final filePath = '${directory.path}/contact.vcf';

    // Write the vCard data to the file.
    final file = File(filePath);
    await file.writeAsString(vCardData);

    // Share the file.
    await Share.shareFiles([filePath], text: 'Here is a contact file.');
  }
}
