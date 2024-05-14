// ignore_for_file: no_leading_underscores_for_local_identifiers, use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tizibane/Services/UserService.dart';

class ShareUrlLink extends StatelessWidget {
  const ShareUrlLink({Key? key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        // Get the phone number from UserService
        String? phoneNumber = await _getUserPhoneNumber();

        // Append the phone number to the link
        String link = 'https://tizibane.com/';
        if (phoneNumber != null) {
          link += phoneNumber;
        }

        // Show the popup when button is clicked
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Share to Socials'),
              content: Text('Share this link with others: $link'),
              actions: <Widget>[
                TextButton(
                  onPressed: () async {
                    // Share the link
                    await Share.share(link);

                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: const Text('Share'),
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

  Future<String?> _getUserPhoneNumber() async {
    UserService _userService = UserService();
    await _userService.getUser();
    return _userService.userObj.value?[0].phone_number;
  }
}
