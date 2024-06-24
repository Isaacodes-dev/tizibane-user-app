import 'package:cached_network_image/cached_network_image.dart';
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
    return SizedBox(
      width: 480,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                            50), // Adjust the value as needed
                        child: CachedNetworkImage(
                        imageUrl:  companyLogoUrl + widget.companyLogo,
                          height: 100,
                          width: 100,
                          fit: BoxFit
                              .cover, // Ensure the image fills the container
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
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
                const SizedBox(
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
                const SizedBox(
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
                const SizedBox(
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
                const SizedBox(
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
                const SizedBox(
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
                const SizedBox(
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
