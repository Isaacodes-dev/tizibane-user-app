import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tizibane/Services/EmploymentHistoryService.dart';
import 'package:tizibane/models/EmploymentHistory.dart';
import 'package:tizibane/screens/Contact/ViewContactEmployeeHistory/ContactEmployeeCard.dart';

class ContactEmployeeHistory extends StatefulWidget {
  final int? employeeIndex;
  final String contactNrc;
  const ContactEmployeeHistory(
      {super.key, required this.contactNrc, this.employeeIndex});

  @override
  State<ContactEmployeeHistory> createState() => _ContactEmployeeHistoryState();
}

final _employeeHistoryService =
    Get.put(EmployeeHistoryService(), permanent: true);

class _ContactEmployeeHistoryState extends State<ContactEmployeeHistory> {
  final ScrollController _scrollController = ScrollController();
  double _previousOffset = 0.0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.employeeIndex != null) {
        scrollToCard(widget.employeeIndex!);
      }
    });

    _scrollController.addListener(_onScroll);
    _employeeHistoryService.getContactEmploymentHistory(widget.contactNrc);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        body: _employeeHistoryService.isLoading.value
            ? const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: CircularProgressIndicator(),
                  ),
                ],
              )
            : SizedBox(
                height: 350,
                child: _employeeHistoryService
                            .contactEmployeeHistoryDetails.isNotEmpty
                    ? ListView.builder(
                        controller: _scrollController,
                        scrollDirection: Axis.horizontal,
                        itemCount: _employeeHistoryService
                            .contactEmployeeHistoryDetails.length,
                        itemBuilder: (context, index) {
                          EmploymentHistory employeeHistory =
                              _employeeHistoryService
                                  .contactEmployeeHistoryDetails[index];
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 400,
                                child: ContactEmployeeCard(
                                    startDate: employeeHistory.startDate,
                                    endDate: employeeHistory.endDate,
                                    positionName: employeeHistory.positionName,
                                    companyName: employeeHistory.companyName,
                                    companyEmail: employeeHistory.companyEmail,
                                    companyPhone: employeeHistory.companyPhone,
                                    companyAddress: employeeHistory.companyAddress,
                                    companyLogo: employeeHistory.companyLogo),
                              ),
                            ],
                          );
                        },
                      )
                    : Center(
                        child: Padding(
                          padding: const EdgeInsets.all(30),
                          child: Text('No Employee History to display',
                              style: GoogleFonts.lexendDeca()),
                        ),
                      ),
              ),
      );
    });
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
      const double cardWidth = 400; // Width of each card
      final double offset = index * cardWidth;
      _scrollController.animateTo(
        offset,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }
}
