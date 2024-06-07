import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tizibane/Services/ProfileService.dart';
import 'package:tizibane/Services/UserService.dart';
import 'package:tizibane/constants/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:tizibane/screens/EmployeementDetails.dart';
import 'package:tizibane/screens/Groups/Groups.dart';
import 'package:tizibane/components/share/ShareUrlLink.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final UserService _userService = Get.put(UserService());
  final ProfileService _profileService = Get.put(ProfileService());
  bool isLoading = true;
  final box = GetStorage();

  @override
  void initState() {
    super.initState();
    _profileService.getImagePath();
    _profileService.isVisible.value = false;
    _loadLocalData();
    _fetchUserData();
  }

  Future<void> _loadLocalData() async {
    if (box.hasData('user_data')) {
      _userService.userObj.value = box.read('user_data');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _fetchUserData() async {
    try {
      await _userService.getUser();
      box.write('user_data', _userService.userObj.value);
      setState(() {
        isLoading = false;
      });
      _refreshIfDataChanged();
    } catch (error) {
      print('Error fetching user data: $error');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _refreshIfDataChanged() async {
    try {
      await _userService.getUser();
      if (_userService.userObj.value != box.read('user_data')) {
        box.write('user_data', _userService.userObj.value);
        setState(() {});
      }
    } catch (error) {
      print('Error checking for data changes: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
        ),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    final user = _userService.userObj.value.isNotEmpty
        ? _userService.userObj.value[0]
        : null;

    if (user == null) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
        ),
        body: const Center(
          child: Text('User data not available'),
        ),
      );
    }

    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Image.asset(
              'assets/images/tizibaneicon.png',
              width: 50,
              height: 50,
            ),
          ),
        ),
        body: _userService.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  color: Colors.white,
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                      Container(
                        width: 160,
                        height: 160,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 4,
                            ),
                          ],
                          border: Border.all(
                            color: Colors.orange,
                            width: 2.0,
                          ),
                        ),
                        child: ClipOval(
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              child: Image.network(
                                imageBaseUrl + _profileService.imagePath.value,
                                fit: BoxFit.cover,
                                width: 150,
                                height: 150,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Column(
                        children: [
                          Text(
                            '${_userService.userObj.value[0].first_name} ${_userService.userObj.value[0].last_name}',
                            style: GoogleFonts.lexendDeca(
                              textStyle: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                          ),
                          if (_userService
                                  .userObj.value[0].company_name.isNotEmpty &&
                              _userService
                                  .userObj.value[0].position_name.isNotEmpty)
                            const SizedBox(height: 5),
                          if (_userService
                                  .userObj.value[0].company_name.isNotEmpty &&
                              _userService
                                  .userObj.value[0].position_name.isNotEmpty)
                            GestureDetector(
                              onTap: () {
                                Get.to(EmployeementDetails(
                                  cell: _userService
                                      .userObj.value[0].phone_number,
                                  first_name:
                                      _userService.userObj.value[0].first_name,
                                  last_name:
                                      _userService.userObj.value[0].last_name,
                                  position_name: _userService
                                      .userObj.value[0].position_name,
                                  email: _userService
                                      .userObj.value[0].companyEmail,
                                  user_profile_pic:
                                      _profileService.imagePath.value,
                                  company_logo_url: _userService
                                      .userObj.value[0].company_logo_url,
                                  company_address: _userService
                                      .userObj.value[0].company_address,
                                  telephone: _userService
                                      .userObj.value[0].comapny_phone,
                                  company_name: _userService
                                      .userObj.value[0].company_name,
                                  company_website: _userService
                                      .userObj.value[0].comapny_website,
                                ));
                              },
                              child: Text(
                                  _userService.userObj.value[0].position_name,
                                  style: GoogleFonts.lexendDeca()),
                            ),
                          if (_userService
                                  .userObj.value[0].company_name.isNotEmpty &&
                              _userService
                                  .userObj.value[0].position_name.isNotEmpty)
                            const SizedBox(height: 3),
                          if (_userService
                                  .userObj.value[0].company_name.isNotEmpty &&
                              _userService
                                  .userObj.value[0].position_name.isNotEmpty)
                            Text(
                              _userService.userObj.value[0].company_name,
                              style: GoogleFonts.lexendDeca(),
                            ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Divider(
                        thickness: 1.15,
                        indent: MediaQuery.of(context).size.width * 0.1,
                        endIndent: MediaQuery.of(context).size.width * 0.1,
                        color: Colors.grey.shade400,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.12,
                            height: 20,
                          ),
                          Text('Personal Details',
                              style: GoogleFonts.lexendDeca()),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      if (_userService.userObj.value[0].phone_number.isNotEmpty)
                        Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          padding: const EdgeInsets.fromLTRB(20, 10, 1, 10),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            border: Border.all(color: Colors.grey.shade200),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Phone',
                                      style: GoogleFonts.lexendDeca()),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  Text(
                                      _userService
                                          .userObj.value[0].phone_number,
                                      style: GoogleFonts.lexendDeca())
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.07,
                                  height:
                                      MediaQuery.of(context).size.width * 0.07,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.black,
                                  ),
                                  child: const Icon(
                                    CupertinoIcons.phone,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      if (_userService.userObj.value[0].email.isNotEmpty)
                        const SizedBox(
                          height: 10,
                        ),
                      if (_userService.userObj.value[0].email.isNotEmpty)
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            padding: const EdgeInsets.fromLTRB(20, 10, 1, 10),
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(20),
                              ),
                              color: Colors.grey.shade100,
                              border: Border.all(
                                color: Colors.grey.shade200,
                                width: 1,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Email',
                                        style: GoogleFonts.lexendDeca()),
                                    const SizedBox(
                                      height: 3,
                                    ),
                                    Text(_userService.userObj.value[0].email,
                                        style: GoogleFonts.lexendDeca()),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.07,
                                    height: MediaQuery.of(context).size.width *
                                        0.07,
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.black),
                                    child: const Icon(
                                      CupertinoIcons.mail,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      if (_userService.userObj.value[0].nrc.isNotEmpty)
                        const SizedBox(
                          height: 10,
                        ),
                      if (_userService.userObj.value[0].nrc.isNotEmpty)
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            padding: const EdgeInsets.fromLTRB(20, 10, 1, 10),
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(20),
                              ),
                              color: Colors.grey.shade100,
                              border: Border.all(
                                color: Colors.grey.shade200,
                                width: 1,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Nrc',
                                        style: GoogleFonts.lexendDeca()),
                                    const SizedBox(
                                      height: 3,
                                    ),
                                    Text(
                                        formatNrc(
                                            _userService.userObj.value[0].nrc),
                                        style: GoogleFonts.lexendDeca()),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.07,
                                    height: MediaQuery.of(context).size.width *
                                        0.07,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.black,
                                    ),
                                    child: const Icon(
                                      Icons.credit_card,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      const SizedBox(
                        height: 20,
                      ),
                      Divider(
                        indent: MediaQuery.of(context).size.width * 0.1,
                        endIndent: MediaQuery.of(context).size.width * 0.1,
                        color: Colors.grey.shade400,
                        thickness: 1,
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.to(const Groups());
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.12,
                              height: 20,
                            ),
                            Text('Groups', style: GoogleFonts.lexendDeca()),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Divider(
                        indent: MediaQuery.of(context).size.width * 0.1,
                        endIndent: MediaQuery.of(context).size.width * 0.1,
                        color: Colors.grey.shade400,
                        thickness: 1,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.12,
                            height: 20,
                          ),
                          Text('Social', style: GoogleFonts.lexendDeca()),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      // Add your social media widgets here
                      const SizedBox(
                        height: 5,
                      ),
                      Divider(
                        indent: MediaQuery.of(context).size.width * 0.1,
                        endIndent: MediaQuery.of(context).size.width * 0.1,
                        color: Colors.grey.shade400,
                        thickness: 1,
                      ),
                    ],
                  ),
                ),
              ),
        floatingActionButton: const ShareUrlLink(),
      );
    });
  }

  String formatNrc(String userNrc) {
    String formattedNrc =
        '${userNrc.substring(0, 6)}/${userNrc.substring(6, 8)}/${userNrc.substring(8)}';
    return formattedNrc;
  }
}
