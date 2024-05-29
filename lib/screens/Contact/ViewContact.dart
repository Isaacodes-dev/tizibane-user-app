import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tizibane/constants/constants.dart';
import 'package:tizibane/screens/Contact/ViewCurrentEmployeeDetails.dart';
import 'package:url_launcher/url_launcher.dart';

class ViewContact extends StatefulWidget {
  final String contactNrc;
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String profilePicture;
  final String positionName;
  final String companyName;
  final String CompanyLogo;
  final String companyWebsite;
  final String telephone;
  final String companyAddress;
  final String companyAssignedEmail;

  ViewContact(
      {super.key,
      required this.contactNrc,
      required this.firstName,
      required this.lastName,
      required this.email,
      required this.phoneNumber,
      required this.profilePicture,
      required this.positionName,
      required this.companyName,
      required this.CompanyLogo,
      required this.companyWebsite,
      required this.telephone,
      required this.companyAddress,
      required this.companyAssignedEmail});

  @override
  State<ViewContact> createState() => _ViewContactState();
}

class _ViewContactState extends State<ViewContact> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.profilePicture == ''
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
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
                      child: ClipOval(
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                              child: Image.network(
                            imageBaseUrl + widget.profilePicture,
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
                      style: GoogleFonts.lexendDeca(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                    if (widget.positionName.isNotEmpty &&
                        widget.companyName.isNotEmpty)
                      SizedBox(
                        height: 5,
                      ),
                    if (widget.positionName.isNotEmpty &&
                        widget.companyName.isNotEmpty)
                      GestureDetector(
                        onTap: () {
                          Get.to(ViewCurrentEmployeeDetails(
                            profilePath: widget.profilePicture,
                            firstName: widget.firstName,
                            lastName: widget.lastName,
                            phoneNumber: widget.phoneNumber,
                            companyName: widget.companyName,
                            positionName: widget.positionName,
                            companyLogo: widget.CompanyLogo,
                            telephone: widget.telephone,
                            email: widget.email,
                            companyAddress: widget.companyAddress,
                            companyWebsite: widget.companyWebsite,
                            companyAssignedEmail: widget.companyAssignedEmail,
                          ));
                        },
                        child: Text(widget.positionName,
                            style: GoogleFonts.lexendDeca()),
                      ),
                    if (widget.positionName.isNotEmpty &&
                        widget.companyName.isNotEmpty)
                      SizedBox(
                        height: 3,
                      ),
                    if (widget.positionName.isNotEmpty &&
                        widget.companyName.isNotEmpty)
                      Text(widget.companyName, style: GoogleFonts.lexendDeca()),
                    SizedBox(
                      height: 3,
                    ),
                    SizedBox(
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
                        Text('Personal Details',
                            style: GoogleFonts.lexendDeca()),
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
                              child: GestureDetector(
                                onTap: () {
                                  _openDialPad(widget.phoneNumber);
                                },
                                child: Icon(
                                  CupertinoIcons.phone,
                                  color: Colors.white,
                                  size: 18,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
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
                              Text(widget.email,
                                  style: GoogleFonts.lexendDeca()),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.07,
                              height: MediaQuery.of(context).size.width * 0.07,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.black),
                              child: GestureDetector(
                                onTap: () {
                                  _openDefaultEmailClient(widget.email);
                                },
                                child: Icon(
                                  CupertinoIcons.mail,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Divider(
                      indent: MediaQuery.of(context).size.width * 0.1,
                      endIndent: MediaQuery.of(context).size.width * 0.1,
                      color: Colors.grey.shade400,
                      thickness: 1,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.12,
                          height: 20,
                        ),
                        Text('Groups', style: GoogleFonts.lexendDeca()),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Divider(
                      indent: MediaQuery.of(context).size.width * 0.1,
                      endIndent: MediaQuery.of(context).size.width * 0.1,
                      color: Colors.grey.shade400,
                      thickness: 1,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.12,
                          height: 20,
                        ),
                        Text('Social', style: GoogleFonts.lexendDeca()),
                      ],
                    ),
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
                    //           image: AssetImage('assets/images/fb1.png'),
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
                    SizedBox(
                      height: 20,
                    ),
                    Divider(
                      indent: MediaQuery.of(context).size.width * 0.1,
                      endIndent: MediaQuery.of(context).size.width * 0.1,
                      color: Colors.grey.shade400,
                      thickness: 1,
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  String formatNrc(String userNrc) {
    String formattedNrc = userNrc.substring(0, 6) +
        '/' +
        userNrc.substring(6, 8) +
        '/' +
        userNrc.substring(8);

    return formattedNrc;
  }

  void _openDialPad(String contactNumber) async {
    String phoneNumber =
        contactNumber; // Replace with the phone number you want to dial
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
}
