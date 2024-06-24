// ignore_for_file: no_leading_underscores_for_local_identifiers, use_build_context_synchronously, invalid_use_of_protected_member, non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:get/get.dart';
import 'package:tizibane/Services/UserService.dart';

class ShareUrlLink extends StatelessWidget {
  const ShareUrlLink({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        // Get user details from UserService
        UserService userService = Get.put(UserService());
        await userService.getUser();

        if (userService.userObj.isNotEmpty) {
          var user = userService.userObj[0];

          // Prepare contact information as plain text
          String contactInfo = '''
          Name: ${user.first_name} ${user.last_name}
          Phone: ${user.phone_number}
          Company: ${user.company_name}
          Email: ${user.email}
          PS: Contact shared from Tizibane App
          ''';

          // Share the contact information
          await _shareContactInfo(contactInfo);
        } else {
          _showErrorDialog(context, 'Failed to retrieve user details.');
        }
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

  Future<void> _shareContactInfo(String contactInfo) async {
    try {
      // Share the contact information as plain text
      await Share.share(contactInfo, subject: 'Contact Information');
    } catch (e) {
      print('Failed to share contact information: $e');
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
