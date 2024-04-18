import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tizibane/constants/constants.dart';
import 'dart:ui';
import 'package:flutter/cupertino.dart';

class ViewCurrentEmployeeDetails extends StatefulWidget {
  final String profile_path;
  final String firstName;
  final String lastName;
  final String positionName;
  final String companyLogo;
  const ViewCurrentEmployeeDetails({
    super.key,
    required this.profile_path,
    required this.firstName,
    required this.lastName,
    required this.positionName,
    required this.companyLogo,
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
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
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
            bottom:
                390, 
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
                        SizedBox(height: 5),
                        Text(widget.positionName),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom:
                0, 
            left: 0,
            right: 0,
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
                        'Coporate Details',
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
                            Text(
                              'Telephone',
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Text(
                              '226778890812',
                            )
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
                            Text(
                              'Cell',
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Text(
                              '0977889098',
                            )
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
                            Text(
                              'Email',
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Text(
                              'im@elisons.com',
                            )
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
                            Text(
                              'Address',
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Text(
                              '226644 Mpongwe Road Luanshya',
                            )
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
                            Text(
                              'Postal Address',
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Text(
                              'P.O. Box 90373, Luanshya',
                            )
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
                        SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 440,
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
