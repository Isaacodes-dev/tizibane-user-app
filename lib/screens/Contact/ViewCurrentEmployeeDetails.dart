import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tizibane/constants/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

class ViewCurrentEmployeeDetails extends StatefulWidget {
  final String profilePath;
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
  final String companyAddress;

  const ViewCurrentEmployeeDetails({
    super.key,
    required this.profilePath,
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
    required this.companyAddress,
  });

  @override
  State<ViewCurrentEmployeeDetails> createState() =>
      _ViewCurrentEmployeeDetailsState();
}

class _ViewCurrentEmployeeDetailsState
    extends State<ViewCurrentEmployeeDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.companyLogo.isEmpty
          ? Center(
              child:
                  Text('No Employee Details', style: GoogleFonts.lexendDeca()))
          : LayoutBuilder(
              builder: (context, constraints) {
                double width = constraints.maxWidth;
                double height = constraints.maxHeight;
                return Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: SizedBox(
                        width: double.infinity,
                        height: width / 2,
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
                      top: width / 3,
                      left: 0,
                      right: 0,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          width: width * 0.25,
                          height: width * 0.25,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white,
                              width: 2,
                            ),
                          ),
                          child: ClipOval(
                            child: Image.network(
                              imageBaseUrl + widget.profilePath,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: width / 1.6,
                      left: 0,
                      right: 0,
                      child: Container(
                        width: width,
                        child: Column(
                          children: [
                            Text(
                              '${widget.firstName} ${widget.lastName}',
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
                    ),
                    Positioned(
                      top: width / 1.2,
                      left: 0,
                      right: 0,
                      bottom: 10,
                      child: SingleChildScrollView(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: width * 0.1, vertical: 10),
                          child: Column(
                            children: [
<<<<<<< HEAD
                              Text(
                                '${widget.firstName} ${widget.lastName}',
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 3),
                              Text(widget.positionName,
                                  style: GoogleFonts.lexendDeca()),
                              const SizedBox(height: 3),
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
                                        const TextStyle(fontWeight: FontWeight.bold)),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              _openDialPad(widget.telephone);
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.8,
                              padding: const EdgeInsets.fromLTRB(20, 10, 1, 10),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                border: Border.all(color: Colors.grey.shade200),
                                borderRadius: const BorderRadius.all(
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
                                      const SizedBox(height: 3),
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
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.black,
                                      ),
                                      child: const Icon(
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
                          const SizedBox(height: 10),
                          GestureDetector(
                            onTap: () {
                              _openDialPad(widget.phoneNumber);
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.8,
                              padding: const EdgeInsets.fromLTRB(20, 10, 1, 10),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                border: Border.all(color: Colors.grey.shade200),
                                borderRadius: const BorderRadius.all(
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
                                      const SizedBox(height: 3),
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
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.black,
                                      ),
                                      child: const Icon(
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
                          const SizedBox(height: 10),
                          GestureDetector(
                            onTap: () {
                              _openDefaultEmailClient(
                                  widget.companyAssignedEmail);
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.8,
                              padding: const EdgeInsets.fromLTRB(20, 10, 1, 10),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                border: Border.all(color: Colors.grey.shade200),
                                borderRadius: const BorderRadius.all(
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
                                      const SizedBox(height: 3),
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
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.black,
                                      ),
                                      child: const Icon(
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
                          const SizedBox(height: 10),
                          GestureDetector(
                            onTap: () {
                              _openDefaultEmailClient(
                                  widget.email);
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.8,
                              padding: const EdgeInsets.fromLTRB(20, 10, 1, 10),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                border: Border.all(color: Colors.grey.shade200),
                                borderRadius: const BorderRadius.all(
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
                                      const SizedBox(height: 3),
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
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.black,
                                      ),
                                      child: const Icon(
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
                          const SizedBox(height: 10),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            padding: const EdgeInsets.fromLTRB(20, 10, 1, 10),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              border: Border.all(color: Colors.grey.shade200),
                              borderRadius: const BorderRadius.all(
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
                                    const SizedBox(height: 3),
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
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.black,
                                    ),
                                    child: const Icon(
                                      CupertinoIcons.home,
                                      color: Colors.white,
                                      size: 18,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            padding: const EdgeInsets.fromLTRB(20, 10, 1, 10),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              border: Border.all(color: Colors.grey.shade200),
                              borderRadius: const BorderRadius.all(
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
                                    const SizedBox(height: 3),
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
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.black,
                                    ),
                                    child: const Icon(
                                      CupertinoIcons.globe,
                                      color: Colors.white,
                                      size: 18,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                        ],
=======
                              Divider(
                                thickness: 1.15,
                                color: Colors.grey.shade400,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'Corporate Details',
                                    style: GoogleFonts.lexendDeca(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              GestureDetector(
                                onTap: () {
                                  _openDialPad(widget.telephone);
                                },
                                child: _infoContainer(
                                  'Telephone',
                                  widget.telephone,
                                  CupertinoIcons.phone,
                                ),
                              ),
                              SizedBox(height: 10),
                              GestureDetector(
                                onTap: () {
                                  _openDialPad(widget.phoneNumber);
                                },
                                child: _infoContainer(
                                  'Cell',
                                  widget.phoneNumber,
                                  CupertinoIcons.phone,
                                ),
                              ),
                              SizedBox(height: 10),
                              GestureDetector(
                                onTap: () {
                                  _openDefaultEmailClient(
                                      widget.companyAssignedEmail);
                                },
                                child: _infoContainer(
                                  'Corporate Email',
                                  widget.companyAssignedEmail,
                                  CupertinoIcons.mail,
                                ),
                              ),
                              SizedBox(height: 10),
                              GestureDetector(
                                onTap: () {
                                  _openDefaultEmailClient(widget.email);
                                },
                                child: _infoContainer(
                                  'Email',
                                  widget.email,
                                  CupertinoIcons.mail,
                                ),
                              ),
                              SizedBox(height: 10),
                              _infoContainer(
                                'Address',
                                widget.companyAddress,
                                CupertinoIcons.home,
                              ),
                              SizedBox(height: 10),
                              _infoContainer(
                                'Company Website',
                                widget.companyWebsite,
                                CupertinoIcons.globe,
                              ),
                              SizedBox(height: 10),
                            ],
                          ),
                        ),
>>>>>>> 77d214542d1a27d1bf6f4f7ac20b4c9a045d85e6
                      ),
                    ),
                  ],
                );
              },
            ),
    );
  }

  Widget _infoContainer(String title, String info, IconData icon) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: GoogleFonts.lexendDeca()),
              SizedBox(height: 3),
              Text(info, style: GoogleFonts.lexendDeca()),
            ],
          ),
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black,
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 18,
            ),
          ),
        ],
      ),
    );
  }

  void _openDialPad(String contactNumber) async {
    final url = 'tel:$contactNumber';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  void _openDefaultEmailClient(String contactEmail) async {
    final emailUrl = 'mailto:$contactEmail';
    if (await canLaunchUrl(Uri.parse(emailUrl))) {
      await launchUrl(Uri.parse(emailUrl));
    } else {
      throw 'Could not launch $emailUrl';
    }
  }
}
