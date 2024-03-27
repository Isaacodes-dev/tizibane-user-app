import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tizibane/Services/ProfileService.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tizibane/Services/UserService.dart';
import 'package:tizibane/constants/constants.dart';

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

  // Future<void> _changeProfilePicture() async {
  //   final pickedFile = await picker.pickImage(source: ImageSource.gallery);
  //   if (pickedFile != null) {
  //     setState(() {
  //       imageFile = File(pickedFile.path);
  //     });
  //   }
  // }
  

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ProfileService());
    String defaultProfilePic = 'assets/images/user.jpg';
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 0, 52, 105),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 25.0),
        child: SingleChildScrollView(
          child: Center(
            child: Stack(
              children: [
                Column(
                  children: [
                    GetBuilder<ProfileService>(builder: (ProfileService) {
                      return Container(
                        width: 140,
                        child: ClipOval(
                          child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                  onTap: () {
                                    ProfileService.changeProfilePicture();
                                  },
                                  child: ProfileService.pickedFile != null
                                      ? Image.file(
                                          File(ProfileService.pickedFile!.path),
                                          width: 100,
                                          height: 100,
                                          fit: BoxFit.contain)
                                      : Image.network(imageBaseUrl+_profileService.imagePath.value,fit: BoxFit.cover,width: 150,height: 150,))),
                        ),
                      );
                    }),
                    const SizedBox(
                      height: 24,
                    ),
                    Container(
                      width: 400,
                      height: 300,
                      child: Card(
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Container(
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      child: Image.asset(
                                        'assets/images/samplelogo.png',
                                        height: 100,
                                        width: 100,
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Name:"),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 12.0),
                                      child: Text(_userService
                                          .userObj.value.full_names),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Email:"),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 12.0),
                                      child: Text(
                                          _userService.userObj.value.email),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Phone:"),
                                    Text(_userService
                                        .userObj.value.phone_number),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Company:"),
                                    Text(""),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Position:"),
                                    Text(""),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: GestureDetector(
                        child: Text('Upload'),
                        onTap:()=> Get.find<ProfileService>().upload(),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
