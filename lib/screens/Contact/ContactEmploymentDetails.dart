import 'package:flutter/material.dart';
import 'package:tizibane/screens/Contact/ContactEmployeeHistory.dart';
import 'package:tizibane/screens/Contact/ViewCurrentEmployeeDetails.dart';

class ContactEmploymentDetails extends StatefulWidget {
  final String nrc;
  final String profilePath;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String positionName;
  final String email;
  final String companyName;
  final String companyLogo;
  final String telephone;
  final String companyAssignedEmail;
  final String companyAddress;
  final String companyWebsite;
  const ContactEmploymentDetails({super.key,    required this.profilePath,
    required this.nrc,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.companyName,
    required this.email,
    required this.positionName,
    required this.companyLogo,
    required this.telephone,
    required this.companyWebsite,
    required this.companyAssignedEmail,
    required this.companyAddress});

  @override
  State<ContactEmploymentDetails> createState() =>
      _ContactEmploymentDetailsState();
}

class _ContactEmploymentDetailsState extends State<ContactEmploymentDetails> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            bottom: const TabBar(
              indicatorColor: Colors.orange,
              labelColor: Colors.orange,
              unselectedLabelColor: Colors.white,
              tabs: [
                Tab(text: 'Employment Details', icon: Icon(Icons.file_copy)),
                Tab(text: 'Employee History', icon: Icon(Icons.history)),
              ],
            ),
          ),
                  body: TabBarView(
          children: [
            ViewCurrentEmployeeDetails(
              firstName: widget.firstName,
              lastName: widget.lastName,
              phoneNumber: widget.phoneNumber,
              telephone: widget.telephone,
              positionName: widget.positionName,
              companyAddress: widget.companyAddress,
              email: widget.email,
              companyLogo: widget.companyLogo,
              companyName: widget.companyName,
              companyWebsite: widget.companyWebsite,
              companyAssignedEmail: widget.companyAssignedEmail,
              profilePath: widget.profilePath,
            ),
            ContactEmployeeHistory(contactNrc: widget.nrc)
          ],
        ),
        ));
  }
}
