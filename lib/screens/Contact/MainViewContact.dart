import 'package:flutter/material.dart';
import 'package:tizibane/screens/Contact/ContactEmployeeHistory.dart';
import 'package:tizibane/screens/Contact/ViewContact.dart';

class MainViewContact extends StatefulWidget {
    final String contactNrc;
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String profilePicture;
  final String positionName;
  final String companyName;
  const MainViewContact({super.key,      required this.contactNrc,
      required this.firstName,
      required this.lastName,
      required this.email,
      required this.phoneNumber,
      required this.profilePicture,
      required this.positionName,
      required this.companyName,
      });

  @override
  State<MainViewContact> createState() => _MainViewContactState();
}

class _MainViewContactState extends State<MainViewContact> {
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
              Tab(text: 'Contact Profile', icon: Icon(Icons.person)),
              Tab(text: 'Employee History', icon: Icon(Icons.history)),
            ],
          ),
        ),
        body: TabBarView(
          children: [ViewContact(contactNrc: widget.contactNrc,firstName: widget.firstName,lastName: widget.lastName,phoneNumber: widget.phoneNumber,email: widget.email,positionName: widget.positionName,profilePicture: widget.profilePicture,companyName: widget.companyName,), ContactEmployeeHistory(contactNrc: widget.contactNrc,)],
        ),
      ),
    );
  }
}
