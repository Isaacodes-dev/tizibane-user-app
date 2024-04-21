import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tizibane/constants/constants.dart';

class EmployeeHistoryCard extends StatefulWidget {
  final String startDate;
  final String endDate;
  final String positionName;
  final String companyName;
  final String companyLogo;
  final String companyPhone;
  final String companyEmail;
  final String companyAddress;

 const EmployeeHistoryCard({
    Key? key,
    required this.startDate,
    required this.endDate,
    required this.positionName,
    required this.companyName,
    required this.companyLogo,
    required this.companyPhone,
    required this.companyEmail,
    required this.companyAddress,
  }) : super(key: key);

  @override
  State<EmployeeHistoryCard> createState() => _EmployeeHistoryCardState();
}

class _EmployeeHistoryCardState extends State<EmployeeHistoryCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 480,
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Container(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Image.network(
                        companyLogoUrl + widget.companyLogo,
                        height: 100,
                        width: 100,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Company Name:",
                      style: GoogleFonts.lexendDeca(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: Text(
                        widget.companyName,
                        style: GoogleFonts.lexendDeca(),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Email:",
                      style: GoogleFonts.lexendDeca(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: Text(
                        widget.companyEmail,
                        style: GoogleFonts.lexendDeca(),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Phone:",
                      style: GoogleFonts.lexendDeca(),
                    ),
                    Text(
                      widget.companyPhone,
                      style: GoogleFonts.lexendDeca(),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Position",
                      style: GoogleFonts.lexendDeca(),
                    ),
                    Text(
                      widget.positionName,
                      style: GoogleFonts.lexendDeca(),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Start Date:",
                      style: GoogleFonts.lexendDeca(),
                    ),
                    Text(
                      widget.startDate,
                      style: GoogleFonts.lexendDeca(),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "End Date:",
                      style: GoogleFonts.lexendDeca(),
                    ),
                    Text(
                      widget.endDate,
                      style: GoogleFonts.lexendDeca(),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
