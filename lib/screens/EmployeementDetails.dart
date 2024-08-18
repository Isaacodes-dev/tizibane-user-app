// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:tizibane/Services/Connectivity.dart';

// import 'package:tizibane/Services/EmployeeService.dart';
// import 'package:tizibane/Services/EmploymentHistoryService.dart';
// import 'package:tizibane/components/share/ShareUrlLink.dart';
// import 'package:tizibane/models/Employee.dart';
// import 'package:tizibane/models/EmploymentHistory.dart';
// import 'package:tizibane/screens/ProfileScreen/EmployeeHistory.dart';
// import 'package:tizibane/screens/ViewEmployeCurrentDetails.dart';

// class EmployeementDetails extends StatefulWidget {
//   final String first_name;
//   final String last_name;
//   final String position_name;
//   final String company_name;
//   final String telephone;
//   final String cell;
//   final String email;
//   final String company_address;
//   final String user_profile_pic;
//   final String company_logo_url;
//   final String company_website;

//   const EmployeementDetails({
//     super.key,
//     required this.first_name,
//     required this.last_name,
//     required this.position_name,
//     required this.company_name,
//     required this.cell,
//     required this.telephone,
//     required this.email,
//     required this.company_address,
//     required this.company_website,
//     required this.user_profile_pic,
//     required this.company_logo_url,
//   });

//   @override
//   State<EmployeementDetails> createState() => _EmployeementDetailsState();
// }

// class _EmployeementDetailsState extends State<EmployeementDetails> {
//   final EmployeeService _employeeService = Get.put(EmployeeService());
//   ConnectivityService _connectivityService = Get.put(ConnectivityService());
//   final EmployeeHistoryService _employeeHistoryService =
//       Get.put(EmployeeHistoryService());
//   final box = GetStorage();
//   final nrcStorage = GetStorage();
//   @override
//   void initState() {
//     super.initState();
//     _initializeAsync();
//   }

//   void _initializeAsync() {
//     _checkConnectivityAndFetchData();
//   }

//   Future<void> _checkConnectivityAndFetchData() async {
//     bool isConnected = await _connectivityService.checkConnectivity();
//     if (isConnected) {
//       String employeeId = await getStoredNrc();
//       print(employeeId);
//       _employeeService.getEmployeeDetails(employeeId);
//     } else {
//       _employeeService.loadLocalEmployee();
//     }
//   }

//   Future<String> getStoredNrc() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getString('nrcNumber') ?? '';
//   }

//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       initialIndex: 0,
//       length: 2,
//       child: Scaffold(
//         appBar: AppBar(
//           leading: null,
//           backgroundColor: Colors.black,
//           bottom: const TabBar(
//             indicatorColor: Colors.orange,
//             labelColor: Colors.orange,
//             unselectedLabelColor: Colors.white,
//             tabs: [
//               Tab(text: 'Employee Details', icon: Icon(Icons.file_copy)),
//               Tab(text: 'Employee History', icon: Icon(Icons.history)),
//             ],
//           ),
//         ),
//         body: TabBarView(
//           children: [
//             ViewEmployeeDetails(
//               first_name: widget.first_name,
//               last_name: widget.last_name,
//               cell: widget.cell,
//               telephone: widget.telephone,
//               position_name: widget.position_name,
//               company_address: widget.company_address,
//               company_logo_url: widget.company_logo_url,
//               company_name: widget.company_name,
//               email: widget.email,
//               user_profile_pic: widget.user_profile_pic,
//               comapny_website: widget.company_website,
//             ),
//             const EmployeeHistory(),
//           ],
//         ),
//         floatingActionButton: const ShareUrlLink(),
//       ),
//     );
//   }
// }
