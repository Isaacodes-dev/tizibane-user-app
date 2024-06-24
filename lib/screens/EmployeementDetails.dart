import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:tizibane/Services/EmployeeService.dart';
import 'package:tizibane/Services/EmploymentHistoryService.dart';
import 'package:tizibane/components/share/ShareUrlLink.dart';
import 'package:tizibane/models/Employee.dart';
import 'package:tizibane/models/EmploymentHistory.dart';
import 'package:tizibane/screens/ProfileScreen/EmployeeHistory.dart';
import 'package:tizibane/screens/ViewEmployeCurrentDetails.dart';

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

  const EmployeementDetails({
    super.key,
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
    required this.company_logo_url,
  });

  @override
  State<EmployeementDetails> createState() => _EmployeementDetailsState();
}

class _EmployeementDetailsState extends State<EmployeementDetails> {
  final EmployeeService _employeeService = Get.put(EmployeeService());
  final EmployeeHistoryService _employeeHistoryService =
      Get.put(EmployeeHistoryService());
  final box = GetStorage();
  final nrcStorage = GetStorage();
  @override
  void initState() {
    super.initState();
    // _loadLocalData();
    // _fetchEmployeeData();
    _fetchEmployeeHistory();
  }

  // Future<void> _loadLocalData() async {
  //   if (box.hasData('employee_data')) {
  //     final localData = box.read('employee_data');
  //     _employeeService.employeeDetails.value = Employee.fromJson(localData);
  //     setState(() {});
  //   }
  //   if (box.hasData('employee_history_data')) {
  //     final localHistoryData = box.read('employee_history_data');
  //     _employeeHistoryService.employeeHistoryDetails.value =
  //         (localHistoryData as List)
  //             .map((e) => EmploymentHistory.fromJson(e))
  //             .toList();
  //     setState(() {});
  //   }
  // }

  // Future<void> _fetchEmployeeData() async {
  //   String nrc = nrcStorage.read('nrcNumber');
  //   try {
  //     await _employeeService.getEmployeeDetails(nrc);
  //     box.write(
  //         'employee_data', _employeeService.employeeDetails.value!.toJson());
  //     setState(() {});
  //     _refreshIfDataChanged();
  //   } catch (error) {
  //     print('Error fetching employee data: $error');
  //   }
  // }

  Future<void> _fetchEmployeeHistory() async {
    try {
      await _employeeHistoryService.getEmploymentHistory();
      box.write(
          'employee_history_data',
          _employeeHistoryService.employeeHistoryDetails
              .map((e) => e.toJson())
              .toList());
      setState(() {});
      _refreshHistoryIfDataChanged();
    } catch (error) {
      print('Error fetching employee history: $error');
    }
  }

  // Future<void> _refreshIfDataChanged() async {
  //   try {
  //     await _employeeService.getEmployeeDetails(widget.email);
  //     final newEmployeeData = _employeeService.employeeDetails.value!.toJson();
  //     if (newEmployeeData != box.read('employee_data')) {
  //       box.write('employee_data', newEmployeeData);
  //       setState(() {});
  //     }
  //   } catch (error) {
  //     print('Error checking for data changes: $error');
  //   }
  // }

  Future<void> _refreshHistoryIfDataChanged() async {
    try {
      await _employeeHistoryService.getEmploymentHistory();
      final newHistoryData = _employeeHistoryService.employeeHistoryDetails
          .map((e) => e.toJson())
          .toList();
      if (newHistoryData != box.read('employee_history_data')) {
        box.write('employee_history_data', newHistoryData);
        setState(() {});
      }
    } catch (error) {
      print('Error checking for history data changes: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: null,
          backgroundColor: Colors.black,
          bottom: const TabBar(
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
            const EmployeeHistory(),
          ],
        ),
        floatingActionButton: const ShareUrlLink(),
      ),
    );
  }
}
