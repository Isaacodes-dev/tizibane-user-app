import 'package:flutter/material.dart';
import 'package:tizibane/screens/Contact/ContactEmployeeHistory.dart';
import 'package:tizibane/screens/Contact/ViewCurrentEmployeeDetails.dart';
import 'package:tizibane/screens/ProfileScreen/EmployeeHistory.dart';
import 'package:tizibane/screens/ViewEmployeCurrentDetails.dart';

class ContactEmploymentDetails extends StatefulWidget {
  final String nrc;
  final String profile_path;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String positionName;
  final String companyName;
  final String companyLogo;
  final String telephone;
  final String companyAssignedEmail;
  final String comapnyAddress;
  final String comapnyWebsite;
  const ContactEmploymentDetails({super.key,    required this.profile_path,
    required this.nrc,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.companyName,
    required this.positionName,
    required this.companyLogo,
    required this.telephone,
    required this.comapnyWebsite,
    required this.companyAssignedEmail,
    required this.comapnyAddress});

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
            bottom: TabBar(
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
              comapnyAddress: widget.comapnyAddress,
              companyLogo: widget.companyLogo,
              companyName: widget.companyName,
              companyWebsite: widget.comapnyWebsite,
              companyAssignedEmail: widget.companyAssignedEmail,
              profile_path: widget.profile_path,
            ),
            ContactEmployeeHistory(contactNrc: widget.nrc)
          ],
        ),
        ));
  }
}
