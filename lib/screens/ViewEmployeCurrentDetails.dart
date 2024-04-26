import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tizibane/constants/constants.dart';

class ViewEmployeeDetails extends StatefulWidget {
  final String first_name;
  final String last_name;
  final String position_name;
  final String company_name;
  final String telephone;
  final String cell;
  final String email;
  final String company_address;
  final String user_profile_pic;
  final String company_logo_url;
  final String comapny_website;

  const ViewEmployeeDetails({
    Key? key,
    required this.first_name,
    required this.last_name,
    required this.position_name,
    required this.company_name,
    required this.cell,
    required this.telephone,
    required this.email,
    required this.company_address,
    required this.user_profile_pic,
    required this.company_logo_url,
    required this.comapny_website
  }) : super(key: key);

  @override
  State<ViewEmployeeDetails> createState() => _ViewEmployeeCurrentDetailsState();
}

class _ViewEmployeeCurrentDetailsState extends State<ViewEmployeeDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.company_logo_url == ''
          ? Center(child: Text('No Employee Details', style: GoogleFonts.lexendDeca()))
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
                          companyLogoUrl + widget.company_logo_url,
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
                  bottom: 318,
                  left: 0,
                  right: 0,
                  child: Container(
                    child: Column(
                      children: [
                        Center(
                          child: Column(
                            children: [
                              Text(
                                widget.first_name + ' ' + widget.last_name,
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 3),
                              Text(widget.position_name, style: GoogleFonts.lexendDeca()),
                              SizedBox(height: 3),
                              Text(widget.company_name, style: GoogleFonts.lexendDeca()),
                              
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
                                style: GoogleFonts.lexendDeca(textStyle: TextStyle(fontWeight: FontWeight.bold)),
                              ),
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
                                    Text('Telephone', style: GoogleFonts.lexendDeca()),
                                    SizedBox(height: 3),
                                    Text(widget.telephone, style: GoogleFonts.lexendDeca())
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
                                    Text('Cell', style: GoogleFonts.lexendDeca()),
                                    SizedBox(height: 3),
                                    Text(widget.cell, style: GoogleFonts.lexendDeca())
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
                                    Text('Email', style: GoogleFonts.lexendDeca()),
                                    SizedBox(height: 3),
                                    Text(widget.email, style: GoogleFonts.lexendDeca())
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
                                      CupertinoIcons.mail,
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
                                    Text('Address', style: GoogleFonts.lexendDeca()),
                                    SizedBox(height: 3),
                                    Text(widget.company_address, style: GoogleFonts.lexendDeca())
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
                                    Text('Company Website', style: GoogleFonts.lexendDeca()),
                                    SizedBox(height: 3),
                                    Text(widget.comapny_website, style: GoogleFonts.lexendDeca())
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
                          imageBaseUrl + widget.user_profile_pic, // User image path
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
