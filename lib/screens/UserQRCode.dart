import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:tizibane/Services/ProfileService.dart';
import 'package:tizibane/Services/UserService.dart';
import 'package:tizibane/constants/constants.dart';

class UserQRCode extends StatefulWidget {
  const UserQRCode({super.key});

  @override
  State<UserQRCode> createState() => _UserQRCodeState();
}

class _UserQRCodeState extends State<UserQRCode> {
  UserService _userService = Get.put(UserService());
  ProfileService _profileService = Get.put(ProfileService());
  @override
  Widget build(BuildContext context) {
    String vCard = generateVCard(
        _userService.userObj[0].first_name +
            ' ' +
            _userService.userObj[0].last_name,
        _userService.userObj[0].phone_number,
        _userService.userObj[0].companyEmail,
        _userService.userObj[0].comapny_phone,
        );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Scan QrCode',
                style: GoogleFonts.lexendDeca(
                  textStyle: TextStyle(
                      fontSize: 25.0, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          SizedBox(height: 20,),
          QrImageView(
            data: vCard,
            size: 200,
          ),
        ],
      ),
    );
  }

  String generateVCard(String name, String phoneNumber,
      String companyEmail, String companyPhoneNumber) {
    return 'BEGIN:VCARD\n'
        'VERSION:3.0\n'
        'FN:$name\n'
        'TEL:$phoneNumber\n'
        'TEL;TYPE=WORK:$companyPhoneNumber\n'
        'EMAIL;TYPE=WORK:$companyEmail\n'
        'END:VCARD';
  }

}
