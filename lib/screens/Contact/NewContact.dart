import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tizibane/Components/SubmitButton.dart';
import 'package:tizibane/Services/ContactService.dart';
import 'package:tizibane/constants/constants.dart';
import 'package:tizibane/screens/More.dart';

class NewContact extends StatefulWidget {
  final String contactNrc;
  final String fullNames;
  final String email;
  final String phoneNumber;
  final String profilePicture;

  const NewContact(
      {super.key,
      required this.contactNrc,
      required this.fullNames,
      required this.email,
      required this.phoneNumber,
      required this.profilePicture});

  @override
  State<NewContact> createState() => _NewContactState();
}

class _NewContactState extends State<NewContact> {
  String contactSaverNrc = nrcStorage.read('nrcNumber');

  final ContactService _contactService = Get.put(ContactService());
  @override
  Widget build(BuildContext context) {
    String defaultProfilePic = 'assets/images/user.jpg';
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
        title: Text('Add Contact'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 25.0),
        child: SingleChildScrollView(
          child: Center(
            child: Stack(
              children: [
                Column(
                  children: [
                    Container(
                      width: 140,
                      child: ClipOval(
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            child: widget.profilePicture != ''
                                ? Image.network(
                                    imageBaseUrl + widget.profilePicture,
                                    fit: BoxFit.cover,
                                    width: 150,
                                    height: 150,
                                  )
                                : Image.asset(
                                    defaultProfilePic,
                                    fit: BoxFit.cover,
                                    width: 150,
                                    height: 150,
                                  ),
                          ),
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
                                      child: Text(widget.fullNames),
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
                                      child: Text(widget.email),
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
                                    Text(widget.phoneNumber),
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
                                    Text(''),
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
                    SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Obx((){
                            return _contactService.isLoading.value
                          ? const CircularProgressIndicator()
                          :SubmitButton(
                              text: 'Save',
                              onTap: () async  {
                                Map<String, dynamic> contactBody = {
                                  'contact_saver': contactSaverNrc,
                                  'nrc': widget.contactNrc
                                };
                                  await _contactService.saveContact(contactBody);
                                  _contactService.contactDetails.refresh();
                                  
                              },
                            );
                          }
                        ),
                      ],
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
