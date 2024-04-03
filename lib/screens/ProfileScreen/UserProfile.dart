import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tizibane/Components/SubmitButton.dart';
import 'package:tizibane/Services/ProfileService.dart';
import 'package:tizibane/Services/UserService.dart';
import 'package:tizibane/constants/constants.dart';
import 'package:tizibane/screens/ProfileScreen/ProfileEdit/PersonalDetailsEdit.dart';

class UserProfile extends StatelessWidget {
  UserProfile({super.key});

  final UserService _userService = Get.put(UserService());

  final ProfileService _profileService = Get.put(ProfileService());

  File? imageFile;

  XFile? pickedFile;

  final picker = ImagePicker();

  late Future<String?> userProfilePicFuture;
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ProfileService());

    return Scaffold(
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
                        width: 160,
                        height: 160,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.orange,
                              width: 2.0,
                            )),
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
                                      width: 150,
                                      height: 150,
                                      fit: BoxFit.cover)
                                  : Image.network(
                                      imageBaseUrl +
                                          _profileService.imagePath.value,
                                      fit: BoxFit.cover,
                                      width: 150,
                                      height: 150,
                                    ),
                            ),
                          ),
                        ),
                      );
                    }),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                        _userService.userObj.value.first_name +
                            ' ' +
                            _userService.userObj.value.last_name,
                        style: GoogleFonts.lexendDeca(
                            textStyle: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18))),
                    SizedBox(
                      height: 15,
                    ),
                    Center(
                      child: Obx(
                        () => Visibility(
                          visible: _profileService.isVisible.value,
                          child: GestureDetector(
                            child: Text('Upload'),
                            onTap: () => Get.find<ProfileService>().upload(),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      width: 400,
                      height: 300,
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Container(
                          child: Column(
                            children: [
                              Divider(
                                thickness: 1.15,
                                indent: MediaQuery.of(context).size.width * 0.1,
                                endIndent:
                                    MediaQuery.of(context).size.width * 0.1,
                                color: Colors.grey.shade400,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text('Personal Details',
                                      style: GoogleFonts.lexendDeca()),
                                  GestureDetector(
                                    onTap: () {
                                      Get.to(PersonalDetailsEdit(
                                          firstName: _userService
                                              .userObj.value.first_name,
                                          lastName: _userService
                                              .userObj.value.last_name,
                                          phoneNumber: _userService
                                              .userObj.value.phone_number,
                                          email: _userService
                                              .userObj.value.email));
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 5),
                                      decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Text('Edit',
                                          style: GoogleFonts.lexendDeca(
                                              textStyle: TextStyle(
                                                  color: Colors.white))),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.8,
                                padding: EdgeInsets.fromLTRB(20, 10, 1, 10),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  border:
                                      Border.all(color: Colors.grey.shade200),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('Phone',
                                            style: GoogleFonts.lexendDeca()),
                                        SizedBox(
                                          height: 3,
                                        ),
                                        Text(
                                            _userService
                                                .userObj.value.phone_number,
                                            style: GoogleFonts.lexendDeca())
                                      ],
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 8.0),
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.07,
                                        height:
                                            MediaQuery.of(context).size.width *
                                                0.07,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.black,
                                        ),
                                        child: Icon(
                                          CupertinoIcons.phone,
                                          color: Colors.white,
                                          size: 18,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.8,
                                padding: EdgeInsets.fromLTRB(20, 10, 1, 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20),
                                  ),
                                  color: Colors.grey.shade100,
                                  border: Border.all(
                                    color: Colors.grey.shade200,
                                    width: 1,
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('Email',
                                            style: GoogleFonts.lexendDeca()),
                                        SizedBox(
                                          height: 3,
                                        ),
                                        Text(_userService.userObj.value.email,
                                            style: GoogleFonts.lexendDeca()),
                                      ],
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 8.0),
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.07,
                                        height:
                                            MediaQuery.of(context).size.width *
                                                0.07,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.black),
                                        child: Icon(
                                          CupertinoIcons.mail,
                                          color: Colors.white,
                                          size: 16,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.8,
                                padding: EdgeInsets.fromLTRB(20, 10, 1, 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20),
                                  ),
                                  color: Colors.grey.shade100,
                                  border: Border.all(
                                    color: Colors.grey.shade200,
                                    width: 1,
                                  ),
                                ),
                                // child: Row(
                                //   mainAxisAlignment:
                                //       MainAxisAlignment.spaceBetween,
                                //   children: [
                                //     Column(
                                //       crossAxisAlignment:
                                //           CrossAxisAlignment.start,
                                //       children: [
                                //         Text('Nrc',
                                //             style: GoogleFonts.lexendDeca()),
                                //         SizedBox(
                                //           height: 3,
                                //         ),
                                //         Text(
                                //             formatNrc(
                                //                 _userService.userObj.value.nrc),
                                //             style: GoogleFonts.lexendDeca()),
                                //       ],
                                //     ),
                                //     Padding(
                                //       padding:
                                //           const EdgeInsets.only(right: 8.0),
                                //       child: Container(
                                //         width:
                                //             MediaQuery.of(context).size.width *
                                //                 0.07,
                                //         height:
                                //             MediaQuery.of(context).size.width *
                                //                 0.07,
                                //         decoration: BoxDecoration(
                                //           shape: BoxShape.circle,
                                //           color: Colors.black,
                                //         ),
                                //         child: Icon(
                                //           Icons.credit_card,
                                //           color: Colors.white,
                                //           size: 16,
                                //         ),
                                //       ),
                                //     ),
                                //   ],
                                // ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String formatNrc(String userNrc) {
    String formattedNrc = userNrc.substring(0, 6) +
        '/' +
        userNrc.substring(6, 8) +
        '/' +
        userNrc.substring(8);

    return formattedNrc;
  }
}
