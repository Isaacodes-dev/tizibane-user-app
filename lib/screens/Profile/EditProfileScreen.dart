import 'package:flutter/material.dart';
import 'package:tizibane/screens/Profile/EditBasicDetails.dart';
import 'package:tizibane/screens/Profile/EditJobProfile.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
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
              Tab(text: 'Edit User Details', icon: Icon(Icons.person)),
              Tab(text: 'Edit Job Profile', icon: Icon(Icons.work)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            EditBasicDetails(),
            EditJobProfile()
          ],
        ),
      ),
    );
  }
}
