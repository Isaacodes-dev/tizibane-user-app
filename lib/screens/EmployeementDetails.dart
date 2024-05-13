import 'package:flutter/material.dart';
import 'package:tizibane/screens/ProfileScreen/EmployeeHistory.dart';
import 'package:tizibane/screens/ViewEmployeCurrentDetails.dart';
import 'package:tizibane/components/share/ShareUrlLink.dart';

class EmployeementDetails extends StatefulWidget {
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
  final String company_website;
  const EmployeementDetails(
      {super.key,
      required this.first_name,
      required this.last_name,
      required this.position_name,
      required this.company_name,
      required this.cell,
      required this.telephone,
      required this.email,
      required this.company_address,
      required this.company_website,
      required this.user_profile_pic,
      required this.company_logo_url});

  @override
  State<EmployeementDetails> createState() => _EmployeementDetailsState();
}

class _EmployeementDetailsState extends State<EmployeementDetails> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: null,
          backgroundColor: Colors.black,
          bottom: TabBar(
            indicatorColor: Colors.orange,
            labelColor: Colors.orange,
            unselectedLabelColor: Colors.white,
            tabs: [
              Tab(text: 'Employee Details', icon: Icon(Icons.file_copy)),
              Tab(text: 'Employee History', icon: Icon(Icons.history)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ViewEmployeeDetails(
              first_name: widget.first_name,
              last_name: widget.last_name,
              cell: widget.cell,
              telephone: widget.telephone,
              position_name: widget.position_name,
              company_address: widget.company_address,
              company_logo_url: widget.company_logo_url,
              company_name: widget.company_name,
              email: widget.email,
              user_profile_pic: widget.user_profile_pic,
              comapny_website: widget.company_website,
            ),
            EmployeeHistory()
          ],
        ),
        floatingActionButton: ShareUrlLink(),
      ),
      
    );
  }
}
