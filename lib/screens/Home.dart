import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tizibane/Services/ProfileService.dart';
import 'package:tizibane/Services/UserService.dart';
import 'package:tizibane/components/bottommenu/BottomMenuBar.dart';
import 'package:tizibane/constants/constants.dart';
import 'package:tizibane/screens/Contact/ViewContact.dart';
import 'package:tizibane/models/User.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final nrcStorage = GetStorage();

  final UserService _userService = Get.put(UserService());

  final ProfileService _profileService = Get.put(ProfileService());
  //late Future<String?> userProfilePicFuture; // Declare Future<String?>

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    // Call the function to make the network request
    _profileService.getImagePath();
    _userService.getUser().then((_) {
      // Once the user data is fetched, set isLoading to false
      setState(() {
        isLoading = false;
      });
    }).catchError((error) {
      // Handle error if the user data couldn't be fetched
      setState(() {
        isLoading = false;
      });
      print('Error fetching user data: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    String defaultProfilePic = 'assets/images/user.jpg';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 0, 52, 105),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                color: Color.fromARGB(255, 0, 52, 105),
                child: Padding(
                  padding: EdgeInsets.only(
                      top: 15.0, left: 20.0, right: 20.0, bottom: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 140,
                        child: ClipOval(
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              child: _profileService.imagePath.value != '' ? Image.network(imageBaseUrl+_profileService.imagePath.value,fit: BoxFit.cover,width: 150,height: 150,):
                              Image.asset(defaultProfilePic, fit: BoxFit.cover,width: 150,height: 150,),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        child: Column(
                          children: [
                            Text(
                              _userService.userObj.value.full_names,
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              _userService.userObj.value.phone_number,
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              _userService.userObj.value.email,
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 15.0, left: 20.0),
                child: Row(
                  children: [
                    Text(
                      'Recent Contacts',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  children: [
                    ListTile(
                      title: Text('Isaac Mulenga'),
                      subtitle: Text('0973700796'),
                      leading: CircleAvatar(
                        child: Text('IM'),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ViewContact(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
