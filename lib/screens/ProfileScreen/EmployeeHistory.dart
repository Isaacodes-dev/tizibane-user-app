import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tizibane/Services/EmploymentHistoryService.dart';
import 'package:tizibane/models/EmploymentHistory.dart';
import 'package:tizibane/screens/ProfileScreen/EmployeeHistoryCard/EmployeeHistoryCard.dart';

class EmployeeHistory extends StatefulWidget {
  final int? employeeIndex; // Make the employeeIndex parameter optional

  EmployeeHistory({Key? key, this.employeeIndex}) : super(key: key);

  @override
  _EmployeeHistoryState createState() => _EmployeeHistoryState();
}

class _EmployeeHistoryState extends State<EmployeeHistory> {
  final ScrollController _scrollController = ScrollController();
  double _previousOffset = 0.0;
  
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      if (widget.employeeIndex != null) {
        scrollToCard(widget.employeeIndex!);
      }
    });

    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    final _employeeHistoryService = Get.put(EmployeeHistoryService(), permanent: true);
    return Obx((){
        return Scaffold(
          body: _employeeHistoryService.isLoading.value
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ],
                )
              : Container(
                  height: 350,
                  child: _employeeHistoryService.employeeHistoryDetails.length > 0
                      ? ListView.builder(
                          controller: _scrollController,
                          scrollDirection: Axis.horizontal,
                          itemCount:
                              _employeeHistoryService.employeeHistoryDetails.length,
                          itemBuilder: (context, index) {
                            EmploymentHistory employeeHistory = _employeeHistoryService.employeeHistoryDetails[index];
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 400,
                                  child: EmployeeHistoryCard(startDate: employeeHistory.startDate, endDate: employeeHistory.endDate,positionName: employeeHistory.positionName, companyName: employeeHistory.companyName, companyEmail: employeeHistory.companyEmail, companyPhone: employeeHistory.companyPhone, companyAddress: employeeHistory.companyAddress,),
                                ),
                              ],
                            );
                          },
                        )
                      : Center(
                        child: Padding(
                            padding: EdgeInsets.all(30),
                            child: Text('No Employee History to display',
                                style: GoogleFonts.lexendDeca()),
                          ),
                      ),
                ),
        );
      }
    );
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.offset != _previousOffset) {
      setState(() {
        _previousOffset = _scrollController.offset;
      });
    }
  }

  void scrollToCard(int index) {
    if (_scrollController.hasClients) {
      final double cardWidth = 400; // Width of each card
      final double offset = index * cardWidth;
      _scrollController.animateTo(
        offset,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }
}