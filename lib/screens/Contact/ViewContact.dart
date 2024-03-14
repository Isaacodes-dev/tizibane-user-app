import 'package:flutter/material.dart';

class ViewContact extends StatefulWidget {
  const ViewContact({super.key});

  @override
  State<ViewContact> createState() => _ViewContactState();
}

class _ViewContactState extends State<ViewContact> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Color.fromARGB(255, 0, 52, 105),
        title: Text('Contact Details'),
      ),
        body: Padding(
        padding: const EdgeInsets.only(top: 25.0),
        child: SingleChildScrollView(
          child: Center(
            child: Stack(
              children: [
                Column(
                  children: [
                    ClipOval(
                      child: Material(
                        child: Ink.image(
                          image: AssetImage('assets/images/user.jpg'),
                          fit: BoxFit.fill,
                          width: 128,
                          height: 128,
                        ),
                      ),
                    ),
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
                                      child: Image.asset('assets/images/samplelogo.png',
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
                                      child: Text("Isaac Mulenga"),
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
                                      child: Text("mulengaisaac10@gmail.com"),
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
                                    Text("+260973700796"),
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
                                    Text("Elisons"),
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
                                    Text("Software Developer"),
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
