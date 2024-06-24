import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tizibane/Components/SubmitButton.dart';
import 'package:tizibane/Services/ContactService.dart';
import 'package:tizibane/components/ContactSaveButton.dart';
import 'package:tizibane/constants/constants.dart';
import 'package:tizibane/screens/More.dart';

class NewContact extends StatefulWidget {
  final String contactNrc;
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String profilePicture;
  final String positionName;
  final String companyName;

  const NewContact(
      {super.key,
      required this.contactNrc,
      required this.firstName,
      required this.lastName,
      required this.email,
      required this.phoneNumber,
      required this.profilePicture,
      required this.positionName,
      required this.companyName});

  @override
  State<NewContact> createState() => _NewContactState();
}

class _NewContactState extends State<NewContact> {
  String? contactSaverNrc = '';

  final ContactService _contactService = Get.put(ContactService());
  
//   Future<void> loadUserData() async {
//   SharedPreferences preferences = await SharedPreferences.getInstance();
//    contactSaverNrc = preferences.getString('nrcNumber');

// }

Future<String> getString() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  contactSaverNrc = preferences.getString('nrcNumber');
  print(contactSaverNrc);
  return contactSaverNrc ?? ''; // Return an empty string if the value is null
}
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getString();
  }
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          child: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.black,
        title: const Text('Add Contact'),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Container(
                width: 140,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 4,
                      ),
                    ],
                    border: Border.all(
                      color: Colors.orange,
                      width: 2.0,
                    )),
                child: ClipOval(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                        child: CachedNetworkImage(
                      imageUrl: imageBaseUrl + widget.profilePicture,
                      fit: BoxFit.cover,
                      width: 150,
                      height: 150,
                    )),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                widget.firstName + ' ' + widget.lastName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  letterSpacing: 1.15,
                ),
              ),
              if (widget.positionName.isNotEmpty &&
                  widget.companyName.isNotEmpty)
                const SizedBox(
                  height: 5,
                ),
              if (widget.positionName.isNotEmpty &&
                  widget.companyName.isNotEmpty)
                Text(widget.positionName, style: GoogleFonts.lexendDeca()),
              const SizedBox(
                height: 3,
              ),
              if (widget.positionName.isNotEmpty &&
                  widget.companyName.isNotEmpty)
                Text(widget.companyName, style: GoogleFonts.lexendDeca()),
              const SizedBox(
                height: 15,
              ),
              Divider(
                thickness: 1.15,
                indent: MediaQuery.of(context).size.width * 0.1,
                endIndent: MediaQuery.of(context).size.width * 0.1,
                color: Colors.grey.shade400,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.12,
                    height: 20,
                  ),
                  Text('Personal Details', style: GoogleFonts.lexendDeca()),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                padding: EdgeInsets.fromLTRB(20, 10, 1, 10),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  border: Border.all(color: Colors.grey.shade200),
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Phone', style: GoogleFonts.lexendDeca()),
                        SizedBox(
                          height: 3,
                        ),
                        Text(widget.phoneNumber,
                            style: GoogleFonts.lexendDeca())
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.07,
                        height: MediaQuery.of(context).size.width * 0.07,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black,
                        ),
                        child: Icon(
                          CupertinoIcons.phone,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  padding: EdgeInsets.fromLTRB(20, 10, 1, 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                    color: Colors.grey.shade100,
                    border: Border.all(
                      color: Colors.grey.shade200,
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Email', style: GoogleFonts.lexendDeca()),
                          SizedBox(
                            height: 3,
                          ),
                          Text(widget.email, style: GoogleFonts.lexendDeca()),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.07,
                          height: MediaQuery.of(context).size.width * 0.07,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.black),
                          child: Icon(
                            CupertinoIcons.mail,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(
                height: 10,
              ),
              // Divider(
              //   indent: MediaQuery.of(context).size.width * 0.1,
              //   endIndent: MediaQuery.of(context).size.width * 0.1,
              //   color: Colors.grey.shade400,
              //   thickness: 1,
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.start,
              //   children: [
              //     SizedBox(
              //       width: MediaQuery.of(context).size.width * 0.12,
              //       height: 20,
              //     ),
              //     Text('Groups', style: GoogleFonts.lexendDeca()),
              //   ],
              // ),
              // SizedBox(
              //   height: 10,
              // ),
              // Divider(
              //   indent: MediaQuery.of(context).size.width * 0.1,
              //   endIndent: MediaQuery.of(context).size.width * 0.1,
              //   color: Colors.grey.shade400,
              //   thickness: 1,
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.start,
              //   children: [
              //     SizedBox(
              //       width: MediaQuery.of(context).size.width * 0.12,
              //       height: 20,
              //     ),
              //     Text('Social', style: GoogleFonts.lexendDeca()),
              //   ],
              // ),
              // SizedBox(
              //   height: 15,
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //   children: [
              //     SizedBox(
              //       width: 0,
              //     ),
              //     GestureDetector(
              //       onTap: () {},
              //       child: Container(
              //         width: MediaQuery.of(context).size.width * 0.09,
              //         height: MediaQuery.of(context).size.width * 0.09,
              //         child: Image(
              //           image: AssetImage(
              //             'assets/images/fb1.png',
              //           ),
              //         ),
              //       ),
              //     ),
              //     GestureDetector(
              //       onTap: () {},
              //       child: Container(
              //         width: MediaQuery.of(context).size.width * 0.09,
              //         height: MediaQuery.of(context).size.width * 0.09,
              //         child: Image(
              //           image: AssetImage('assets/images/x.png'),
              //         ),
              //       ),
              //     ),
              //     GestureDetector(
              //       onTap: () {},
              //       child: Container(
              //         width: MediaQuery.of(context).size.width * 0.1,
              //         height: MediaQuery.of(context).size.width * 0.1,
              //         child: Image(
              //           image: AssetImage('assets/images/linkedIn.png'),
              //         ),
              //       ),
              //     ),
              //     GestureDetector(
              //       onTap: () {},
              //       child: Container(
              //         width: MediaQuery.of(context).size.width * 0.1,
              //         height: MediaQuery.of(context).size.width * 0.1,
              //         child: Image(
              //           image: AssetImage('assets/images/insta-logo.png'),
              //         ),
              //       ),
              //     ),
              //     GestureDetector(
              //       onTap: () {},
              //       child: Container(
              //         width: MediaQuery.of(context).size.width * 0.1,
              //         height: MediaQuery.of(context).size.width * 0.1,
              //         child: Image(
              //           image: AssetImage('assets/images/git.png'),
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
              // SizedBox(
              //   height: 20,
              // ),
              Divider(
                indent: MediaQuery.of(context).size.width * 0.1,
                endIndent: MediaQuery.of(context).size.width * 0.1,
                color: Colors.grey.shade400,
                thickness: 1,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(() {
                    return _contactService.isLoading.value
                        ? const CircularProgressIndicator()
                        : SaveButton(
                            text: 'Save',
                            onTap: () async {
                              Map<String, dynamic> contactBody = {
                                'contact_saver': contactSaverNrc,
                                'nrc': widget.contactNrc
                              };
                              await _contactService.saveContact(contactBody);
                              _contactService.contactDetails.refresh();
                            },
                          );
                  }),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  String formatNrc(String userNrc) {
    String formattedNrc =
        '${userNrc.substring(0, 6)}/${userNrc.substring(6, 8)}/${userNrc.substring(8)}';

    return formattedNrc;
  }
}
