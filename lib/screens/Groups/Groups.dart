import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tizibane/Services/GroupsService.dart';
import 'package:tizibane/models/Group.dart';
import 'package:tizibane/screens/Groups/GroupCard/GroupMembershipCard.dart';

class Groups extends StatefulWidget {
  final int? employeeIndex;
  const Groups({super.key,this.employeeIndex});

  @override
  State<Groups> createState() => _GroupsState();
}

final ScrollController _scrollController = ScrollController();
double _previousOffset = 0.0;
final GroupsService _groupService = Get.put(GroupsService());
class _GroupsState extends State<Groups> {
  @override
  void initState() {
    // TODO: implement initState
        WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.employeeIndex != null) {
        scrollToCard(widget.employeeIndex!);
      }
    });

    _scrollController.addListener(_onScroll);
    _groupService.getGroups(); 
  }
  @override
  Widget build(BuildContext context) {
    
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
        ),
        body: _groupService.isLoading.value
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
                child: _groupService.groupsList.isNotEmpty
                    ? ListView.builder(
                        controller: _scrollController,
                        scrollDirection: Axis.horizontal,
                        itemCount: _groupService.groupsList.length,
                        itemBuilder: (context, index) {
                          Group group = _groupService.groupsList[index];
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 400,
                                child: GroupMembershipCard(group_name: group.group_name,group_logo: group.group_logo,group_phone_number: group.group_phone_number,group_email: group.group_email,),
                              ),
                            ],
                          );
                        },
                      )
                    : Center(
                        child: Padding(
                          padding: const EdgeInsets.all(30),
                          child: Text('No Group History to Display',
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
