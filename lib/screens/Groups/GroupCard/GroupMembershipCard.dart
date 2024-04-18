import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GroupMembershipCard extends StatefulWidget {
  
  final String group_name;
  
  final String group_logo;

  final String group_phone_number;

  final String group_email;

  const GroupMembershipCard({super.key,required this.group_name,required this.group_logo, required this.group_email, required this.group_phone_number});

  @override
  State<GroupMembershipCard> createState() => _GroupMembershipCardState();
}

class _GroupMembershipCardState extends State<GroupMembershipCard> {
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
                      child: Image.asset(
                        'assets/images/samplelogo.png',
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
                      "Group Name:",
                      style: GoogleFonts.lexendDeca(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: Text(
                        widget.group_name,
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
                        widget.group_email,
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
                      widget.group_phone_number,
                      style: GoogleFonts.lexendDeca(),
                    ),
                  ],
                ),
                // SizedBox(
                //   height: 10,
                // ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Text(
                //       "Position",
                //       style: GoogleFonts.lexendDeca(),
                //     ),
                //     Text(
                //       widget.positionName,
                //       style: GoogleFonts.lexendDeca(),
                //     ),
                //   ],
                // ),
                // SizedBox(
                //   height: 10,
                // ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Text(
                //       "Start Date:",
                //       style: GoogleFonts.lexendDeca(),
                //     ),
                //     Text(
                //       widget.startDate,
                //       style: GoogleFonts.lexendDeca(),
                //     ),
                //   ],
                // ),
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