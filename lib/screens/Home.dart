import 'package:flutter/material.dart';
import 'package:tizibane/Services/UserService.dart';
import 'package:tizibane/components/bottommenu/BottomMenuBar.dart';
import 'package:tizibane/screens/Contact/ViewContact.dart';
import 'package:tizibane/models/User.dart';

class Home extends StatefulWidget {
  final String nrc;
  const Home({super.key, required this.nrc});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late User user = User(nrc: '',fullNames: '',phoneNumbers: '',email: '',profilePic: '',password: ''); // Provide a default value

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    // Call the function to make the network request
    loadUser(widget.nrc);
  }

  loadUser(String nrc) async {
    try {
      isLoading = true;
      // Fetch user data
      User userData = await UserService().getUser(nrc);
      setState(() {
        user = userData;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      // Handle error
      print('Error fetching user data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
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
                            child: isLoading
                                ? CircularProgressIndicator() // Show loading indicator
                                : Image.network(
                                    'http://192.168.0.109:8000/api/${user.profilePic}'),
                          ),
                        ),
                      ),
                      Container(
                        child: Column(
                          children: [
                            Text(
                              user.fullNames,
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              user.phoneNumbers,
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              user.email,
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
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                    ListTile(
                      title: Text('James Mulenga'),
                      subtitle: Text('0973700797'),
                      leading: CircleAvatar(child: Text('JM')),
                    ),
                    ListTile(
                      title: Text('Mutale Phiri'),
                      subtitle: Text('0973700596'),
                      leading: CircleAvatar(child: Text('MP')),
                    ),
                    ListTile(
                      title: Text('Banda Phiri'),
                      subtitle: Text('0973701798'),
                      leading: CircleAvatar(child: Text('BP')),
                    ),
                    ListTile(
                      title: Text('Kennedy Mulenga'),
                      subtitle: Text('0973704797'),
                      leading: CircleAvatar(child: Text('KM')),
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
