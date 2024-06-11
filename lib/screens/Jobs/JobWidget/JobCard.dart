import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tizibane/constants/constants.dart';

class JobCard extends StatefulWidget {
  final String position;
  final String company;
  final String address;
  final String companyLogo;
  final String closing;
  final String? status;
  const JobCard(
      {super.key,
      required this.position,
      required this.company,
      required this.address,
      required this.companyLogo,
      required this.closing,
      this.status
      });

  @override
  State<JobCard> createState() => _JobCardState();
}

class _JobCardState extends State<JobCard> {
@override
void initState() {
  super.initState();
  
}

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SizedBox(
      height: 205,
      width: width,
      child: Card(
        shape: RoundedRectangleBorder(
          side: BorderSide.merge(
            BorderSide(
                width: 1.5, color: Colors.white, style: BorderStyle.solid),
            BorderSide(
                width: 1.5, color: Colors.white, style: BorderStyle.solid),
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(60),
                    child: Image.network(
                      companyLogoUrl + widget.companyLogo,
                      height: 65,
                      width: 65,
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.position,
                            style: GoogleFonts.lexendDeca(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            widget.company,
                            style: GoogleFonts.lexendDeca(
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Icon(
                    Icons.location_pin,
                    size: 18,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    widget.address,
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Icon(
                    Icons.date_range,
                    size: 18,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Closing date: ${widget.closing}",
                    style: TextStyle(fontSize: 12),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    size: 18,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Not Applied",
                    style: TextStyle(fontSize: 12),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
