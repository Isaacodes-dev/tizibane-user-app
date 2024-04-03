import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tizibane/Services/ProfileService.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tizibane/Services/UserService.dart';
import 'package:tizibane/constants/constants.dart';
import 'package:tizibane/screens/ProfileScreen/EmployeeHistory.dart';
import 'package:tizibane/screens/ProfileScreen/UserProfile.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

final UserService _userService = Get.put(UserService());

class _ProfileState extends State<Profile> {
  final UserService _userService = Get.put(UserService());

  final ProfileService _profileService = Get.put(ProfileService());

  File? imageFile;

  XFile? pickedFile;

  final picker = ImagePicker();

  late Future<String?> userProfilePicFuture;

  @override
  void initState() {
    super.initState();
    _profileService.getImagePath();
  }

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ProfileService());
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
            
            tabs:[
            Tab(
              text: 'Profile',
              icon: Icon(Icons.person)
            ),
            Tab(
              text: 'Employee History',
              icon: Icon(Icons.history)
            ),
          ],
          
          ),
        ),
        body: TabBarView(
          children: [
            UserProfile(),
            EmployeeHistory()
          ],
        ),
      ),
    );
  }
}
