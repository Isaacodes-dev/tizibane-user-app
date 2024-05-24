import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class JobCard extends StatelessWidget {
  final String position;
  final String company;
  final String address;
  final String salary;
  final String jobType;
  final String jobTime;
  final String experience;
  const JobCard({
    super.key, required this.position, required this.company, required this.address, required this.salary, required this.experience, required this.jobTime, required this.jobType
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 260,
      width: 500,
      child: Card(
        shape: RoundedRectangleBorder(
          side: BorderSide.merge(
            BorderSide(
                width: 1.5,
                color: Colors.white,
                style: BorderStyle.solid),
            BorderSide(
                width: 1.5,
                color: Colors.white,
                style: BorderStyle.solid),
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 15, vertical: 10),
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
                    child: Image.asset(
                      'assets/images/tizibaneicon.png',
                      height: 65,
                      width: 65,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(
                          position,
                          style: GoogleFonts.lexendDeca(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          company,
                          style: GoogleFonts.lexendDeca(
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Icon(Icons.location_pin,size: 18,),
                  SizedBox(
                    width: 5,
                  ),
                  Text(address,style: TextStyle(fontSize: 12),)
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Icon(Icons.currency_exchange,size: 18,),
                  SizedBox(
                    width: 5,
                  ),
                  Text(salary),
                  Text(
                    "/year",
                    style: TextStyle(color: Colors.grey,fontSize: 12),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Divider(),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.all(5.0),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 6),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      jobType,
                      style: TextStyle(fontSize: 10),
                    ),
                  ),
                  SizedBox(
                    width: 2,
                  ),
                  Container(
                    margin: const EdgeInsets.all(5.0),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 6),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      jobTime,
                      style: TextStyle(fontSize: 10),
                    ),
                  ),
                  SizedBox(
                    width: 2,
                  ),
                  Container(
                    margin: const EdgeInsets.all(5.0),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 6),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      experience,
                      style: TextStyle(fontSize: 10),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
