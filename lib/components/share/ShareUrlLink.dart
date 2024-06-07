// ignore_for_file: no_leading_underscores_for_local_identifiers, use_build_context_synchronously, invalid_use_of_protected_member, non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tizibane/Services/UserService.dart';

class ShareUrlLink extends StatelessWidget {
  const ShareUrlLink({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        // Get the NRC from UserService
        String? Nrc = await _getUserNrc();

        String link = 'https://tizibane.com/api/share/';
        if (Nrc != null) {
          link += Nrc;
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

    if ((charCode >= 65 && charCode <= 90) || (charCode >= 48 && charCode <= 57)) {
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

}