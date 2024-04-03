import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tizibane/Services/ContactService.dart';
import 'package:tizibane/Services/ProfileService.dart';
import 'package:tizibane/Services/UserService.dart';
import 'package:tizibane/components/bottommenu/BottomMenuBar.dart';
import 'package:tizibane/constants/constants.dart';
import 'package:tizibane/models/Contact.dart';
import 'package:tizibane/screens/Contact/ViewContact.dart';
import 'package:tizibane/models/User.dart';
import 'package:flutter/cupertino.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final nrcStorage = GetStorage();

  final UserService _userService = Get.put(UserService());

  final ProfileService _profileService = Get.put(ProfileService());

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _profileService.getImagePath();
    _userService.getUser().then((_) {
      setState(() {
        isLoading = false;
      });
    }).catchError((error) {
      setState(() {
        isLoading = false;
      });
      print('Error fetching user data: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: _profileService.imagePath.value == '' &&
              _userService.isLoading.value
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
                              color:
                                  Colors.black.withOpacity(0.5), 
                              spreadRadius: 5,
                              blurRadius: 4, 
                              
                            ),
                          ],
                          border: Border.all(
                            color: Colors.orange,
                            width: 2.0,
                          )),
                      child: ClipOval(
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                              child: Image.network(
                            imageBaseUrl + _profileService.imagePath.value,
                            fit: BoxFit.cover,
                            width: 150,
                            height: 150,
                          )),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(_userService.userObj.value.first_name + ' ' + _userService.userObj.value.last_name,
                        style: GoogleFonts.lexendDeca(
                            textStyle: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18))),
                    SizedBox(
                      height: 5,
                    ),
                    Text('Position', style: GoogleFonts.lexendDeca()),
                    SizedBox(
                      height: 3,
                    ),
                    Text('Company', style: GoogleFonts.lexendDeca()),
                    SizedBox(
                      height: 15,
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
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      padding: EdgeInsets.fromLTRB(20, 10, 1, 10),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        border: Border.all(color: Colors.grey.shade200),
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Phone', style: GoogleFonts.lexendDeca()),
                              SizedBox(
                                height: 3,
                              ),
                              Text(_userService.userObj.value.phone_number,
                                  style: GoogleFonts.lexendDeca())
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.07,
                              height: MediaQuery.of(context).size.width * 0.07,
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
                    GestureDetector(
                      onTap: () {},
                      child: Container(
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Email', style: GoogleFonts.lexendDeca()),
                                SizedBox(
                                  height: 3,
                                ),
                                Text(_userService.userObj.value.email,
                                    style: GoogleFonts.lexendDeca()),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.07,
                                height:
                                    MediaQuery.of(context).size.width * 0.07,
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
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Nrc', style: GoogleFonts.lexendDeca()),
                                SizedBox(
                                  height: 3,
                                ),
                                Text(formatNrc(_userService.userObj.value.nrc),
                                    style: GoogleFonts.lexendDeca()),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.07,
                                height:
                                    MediaQuery.of(context).size.width * 0.07,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.black,
                                ),
                                child: Icon(
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
                    SizedBox(
                      height: 20,
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
                        Text('Groups', style: GoogleFonts.lexendDeca()),
                      ],
                    ),
                    SizedBox(
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
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: 0,
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.09,
                            height: MediaQuery.of(context).size.width * 0.09,
                            child: Image(
                              image: AssetImage('assets/images/fb1.png'),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.09,
                            height: MediaQuery.of(context).size.width * 0.09,
                            child: Image(
                              image: AssetImage('assets/images/x.png'),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.1,
                            height: MediaQuery.of(context).size.width * 0.1,
                            child: Image(
                              image: AssetImage('assets/images/linkedIn.png'),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.1,
                            height: MediaQuery.of(context).size.width * 0.1,
                            child: Image(
                              image: AssetImage('assets/images/insta-logo.png'),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.1,
                            height: MediaQuery.of(context).size.width * 0.1,
                            child: Image(
                              image: AssetImage('assets/images/git.png'),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
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

// class CurvePainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     var paint = Paint();
//     paint.style = PaintingStyle.fill;
//     paint.shader = LinearGradient(colors: [
//       Color.fromARGB(255, 0, 52, 105),
//       Color.fromARGB(255, 0, 52, 105),
//       Color.fromARGB(255, 0, 52, 105)
//     ], begin: Alignment.topLeft, end: Alignment.bottomRight)
//         .createShader(
//       Rect.fromLTRB(
//         size.width * 0.15,
//         size.height * 0.15,
//         size.width,
//         size.height * 0.1,
//       ),
//     );
//     var path = Path();
//     path.moveTo(0, size.height * 0.15);
//     path.quadraticBezierTo(
//         size.width * 0.48, size.height * 0.38, size.width, size.height * 0.25);
//     path.quadraticBezierTo(
//         size.width * 0.9, size.height * 0.38, size.width, size.height * 0.25);
//     path.lineTo(size.width, 0);
//     path.lineTo(0, 0);
//     canvas.drawPath(path, paint);
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) {
//     // TODO: implement shouldRepaint
//     return true;
//   }
// }
