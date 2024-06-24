// ignore_for_file: no_leading_underscores_for_local_identifiers, use_build_context_synchronously, invalid_use_of_protected_member, non_constant_identifier_names

import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';

class ShareUrlLink extends StatelessWidget {
  const ShareUrlLink({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        // Prepare vCard data
        String vCardData = '''
        BEGIN:VCARD
        VERSION:3.0
        FN:John Doe
        TEL:+1234567890
        ORG:Example Company
        EMAIL:john.doe@example.com
        END:VCARD
        ''';

        // Write the vCard data to a file and share it
        await _shareVCard(context, vCardData);
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

  Future<void> _shareVCard(BuildContext context, String vCardData) async {
    try {
      // Get the directory to save the file.
      final directory = await getApplicationDocumentsDirectory();

      // Define the file path.
      final filePath = '${directory.path}/contact.vcf';

      // Write the vCard data to the file.
      final file = File(filePath);
      await file.writeAsString(vCardData);

      // Share the file.
      await Share.shareFiles([filePath], text: 'Here is a contact file.');
    } catch (e) {
      _showErrorDialog(context, 'Failed to share the vCard.');
    }
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
