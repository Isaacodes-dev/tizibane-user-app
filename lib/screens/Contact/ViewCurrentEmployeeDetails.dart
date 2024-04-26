import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tizibane/constants/constants.dart';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

class ViewCurrentEmployeeDetails extends StatefulWidget {
  final String profile_path;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String positionName;
  final String companyName;
  final String companyLogo;
  final String telephone;
  final String companyAssignedEmail;
  final String email;
  final String companyWebsite;
  final String comapnyAddress;
  const ViewCurrentEmployeeDetails(
      {super.key,
      required this.profile_path,
      required this.firstName,
      required this.lastName,
      required this.phoneNumber,
      required this.companyName,
      required this.positionName,
      required this.companyLogo,
      required this.telephone,
      required this.companyWebsite,
      required this.companyAssignedEmail,
      required this.email,
      required this.comapnyAddress});

  @override
  State<ViewCurrentEmployeeDetails> createState() =>
      _ViewCurrentEmployeeDetailsState();
}

class _ViewCurrentEmployeeDetailsState
    extends State<ViewCurrentEmployeeDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.companyLogo == ''
          ? Center(
              child:
                  Text('No Employee Details', style: GoogleFonts.lexendDeca()))
          : Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: SizedBox(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.width / 2,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.network(
                          companyLogoUrl + widget.companyLogo,
                          fit: BoxFit.cover,
                        ),
                        Container(
                          color: Colors.black.withOpacity(0.3),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 315,
                  left: 0,
                  right: 0,
                  child: Container(
                    child: Column(
                      children: [
                        Center(
                          child: Column(
                            children: [
                              Text(
                                widget.firstName + ' ' + widget.lastName,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 3),
                              Text(widget.positionName,
                                  style: GoogleFonts.lexendDeca()),
                              SizedBox(height: 3),
                              Text(widget.companyName,
                                  style: GoogleFonts.lexendDeca()),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 335,
                  left: 0,
                  right: 0,
                  bottom: 10,
                  child: SingleChildScrollView(
                    child: Container(
                      child: Column(
                        children: [
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
                              Text(
                                'Corporate Details',
                                style: GoogleFonts.lexendDeca(
                                    textStyle:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              _openDialPad(widget.telephone);
                            },
                            child: Container(
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Telephone',
                                          style: GoogleFonts.lexendDeca()),
                                      SizedBox(height: 3),
                                      Text(widget.telephone,
                                          style: GoogleFonts.lexendDeca())
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.07,
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.07,
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
                          ),
                          SizedBox(height: 10),
                          GestureDetector(
                            onTap: () {
                              _openDialPad(widget.phoneNumber);
                            },
                            child: Container(
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Cell',
                                          style: GoogleFonts.lexendDeca()),
                                      SizedBox(height: 3),
                                      Text(widget.phoneNumber,
                                          style: GoogleFonts.lexendDeca())
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.07,
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.07,
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
                          ),
                          SizedBox(height: 10),
                          GestureDetector(
                            onTap: () {
                              _openDefaultEmailClient(
                                  widget.companyAssignedEmail);
                            },
                            child: Container(
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Corporate Email',
                                          style: GoogleFonts.lexendDeca()),
                                      SizedBox(height: 3),
                                      Text(widget.companyAssignedEmail,
                                          style: GoogleFonts.lexendDeca())
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.07,
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.07,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.black,
                                      ),
                                      child: Icon(
                                        CupertinoIcons.mail,
                                        color: Colors.white,
                                        size: 18,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          GestureDetector(
                            onTap: () {
                              _openDefaultEmailClient(
                                  widget.email);
                            },
                            child: Container(
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Email',
                                          style: GoogleFonts.lexendDeca()),
                                      SizedBox(height: 3),
                                      Text(widget.email,
                                          style: GoogleFonts.lexendDeca())
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.07,
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.07,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.black,
                                      ),
                                      child: Icon(
                                        CupertinoIcons.mail,
                                        color: Colors.white,
                                        size: 18,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
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
                                    Text('Address',
                                        style: GoogleFonts.lexendDeca()),
                                    SizedBox(height: 3),
                                    Text(widget.comapnyAddress,
                                        style: GoogleFonts.lexendDeca())
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.07,
                                    height: MediaQuery.of(context).size.width *
                                        0.07,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.black,
                                    ),
                                    child: Icon(
                                      CupertinoIcons.home,
                                      color: Colors.white,
                                      size: 18,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
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
                                    Text('Company Website',
                                        style: GoogleFonts.lexendDeca()),
                                    SizedBox(height: 3),
                                    Text(widget.companyWebsite,
                                        style: GoogleFonts.lexendDeca())
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.07,
                                    height: MediaQuery.of(context).size.width *
                                        0.07,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.black,
                                    ),
                                    child: Icon(
                                      CupertinoIcons.globe,
                                      color: Colors.white,
                                      size: 18,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 390,
                  left: 0,
                  right: 0,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white, // Change as needed
                          width: 2,
                        ),
                      ),
                      child: ClipOval(
                        child: Image.network(
                          imageBaseUrl + widget.profile_path, // User image path
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

void _openDialPad(String contactNumber) async {
  String phoneNumber = contactNumber;
  final url = 'tel:$phoneNumber';

  if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse(url));
  } else {
    throw 'Could not launch $url';
  }
}

void _openDefaultEmailClient(String contactEmail) async {
  String emailUrl = 'mailto:$contactEmail';
  if (await canLaunchUrl(Uri.parse(emailUrl))) {
    await launchUrl(Uri.parse(emailUrl));
  } else {
    throw 'Could not launch $emailUrl';
  }
}
