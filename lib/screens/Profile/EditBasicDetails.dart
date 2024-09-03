import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tizibane/Services/AuthService.dart';
import 'package:tizibane/Services/ProfileService.dart';
import 'package:tizibane/Services/ProfileServices/IndividualProfileService.dart';
import 'package:tizibane/components/SubmitButton.dart';
import 'package:tizibane/models/IndividualProfile.dart';

class EditBasicDetails extends StatefulWidget {
  const EditBasicDetails({super.key});

  @override
  State<EditBasicDetails> createState() => _EditBasicDetailsState();
}

class _EditBasicDetailsState extends State<EditBasicDetails> {
  final ImagePicker _picker = ImagePicker();
  XFile? _image;
  final TextEditingController _selectedTitle = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _about = TextEditingController();
  final ProfileService _profileService = Get.put(ProfileService());
  IndividualProfileService _individualProfileService =
      Get.put(IndividualProfileService());
  final List<String> _titles = ['Mr', 'Ms', 'Miss', 'Mrs'];
  final List<String> _workStatus = ['Yes', 'No'];
  final List<String> _genders = ['Male', 'Female'];
  final List<String> _countries = [];
  final List<String> _provinces = ['Lusaka', 'Copperbelt'];
  final List<String> _towns = ['Lusaka', 'Ndola'];

  // String? _selectedTitle;
  String? _selectedWorkStatus;
  String? _selectedGender;
  String? _selectedCountry;
  String? _selectedProvince;
  String? _selectedTown;

  final _formKey = GlobalKey<FormState>();

  Future<void> _pickImage() async {
    final pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = pickedImage;
      });
    }
  }

  Future<void> _uploadImage() async {
    if (_image != null) {
      await _profileService.uploadImage(_image!);
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchCountries();
  }

  Future<void> _fetchCountries() async {
    try {
      final countries = await _profileService.getCountries();
      setState(() {
        _countries.clear(); // Clear existing data
        _countries.addAll(_countries); // Add new data
      });
    } catch (e) {
      print('Error fetching countries: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Center(
                child: Column(
                  children: [
                    RichText(
                      text: TextSpan(
                        style: GoogleFonts.lexendDeca(),
                        children: [
                          TextSpan(
                            text: 'Upload Profile Picture',
                            style: TextStyle(
                                color: Colors.black), // or any other color
                          ),
                          TextSpan(
                            text: ' *',
                            style: TextStyle(color: Colors.red),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Stack(
                      children: [
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
                                child: _image == null
                                    ? Image.asset(
                                        'assets/images/user.jpg',
                                        fit: BoxFit.cover,
                                        width: 150,
                                        height: 150,
                                      )
                                    : Image.file(
                                        File(_image!.path),
                                        fit: BoxFit.cover,
                                        width: 150,
                                        height: 150,
                                      ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 15,
                          child: InkWell(
                            onTap: _pickImage,
                            child: Icon(
                              Icons.camera_alt,
                              color: const Color.fromARGB(255, 171, 170, 170),
                              size: 30,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Divider(color: Colors.black),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    // DropdownButtonFormField<String>(
                    //   value: _selectedTitle,
                    //   onChanged: (value) {
                    //     setState(() {
                    //       _selectedTitle = value;
                    //     });
                    //   },
                    //   items: _titles.map((title) {
                    //     return DropdownMenuItem<String>(
                    //       value: title,
                    //       child: Text(title),
                    //     );
                    //   }).toList(),
                    //   decoration: InputDecoration(
                    //     contentPadding: const EdgeInsets.symmetric(
                    //       vertical: 10.0,
                    //       horizontal: 15.0,
                    //     ),
                    //     focusedBorder: OutlineInputBorder(
                    //       borderSide: const BorderSide(color: Colors.black),
                    //       borderRadius: BorderRadius.circular(40.0),
                    //     ),
                    //     hintText: 'Title',
                    //     border: OutlineInputBorder(
                    //       borderRadius: BorderRadius.circular(20.0),
                    //     ),
                    //   ),
                    //   validator: (value) {
                    //     if (value == null || value.isEmpty) {
                    //       return 'Please select a title';
                    //     }
                    //     return null;
                    //   },
                    // ),
                    const SizedBox(height: 20),
                    DropdownButtonFormField<String>(
                      value: _selectedGender,
                      onChanged: (value) {
                        setState(() {
                          _selectedGender = value;
                        });
                      },
                      items: _genders.map((gender) {
                        return DropdownMenuItem<String>(
                          value: gender,
                          child: Text(gender),
                        );
                      }).toList(),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 10.0,
                          horizontal: 15.0,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(40.0),
                        ),
                        hintText: 'Gender',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select your gender';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller:
                          _selectedTitle, // Ensure this controller matches the purpose of the field
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 10.0,
                          horizontal: 15.0,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(40.0),
                        ),
                        suffixIcon: const Icon(
                          Icons
                              .title, // Ensure this icon is appropriate for the field
                          color: Colors.black,
                        ),
                        hintText:
                            'Title eg Project Manager, Software Developer', // Make sure the hint text matches the field's purpose
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          // Ensure the validation message matches the purpose of the field
                          return 'Please enter a title';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _about,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 10.0,
                          horizontal: 15.0,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(40.0),
                        ),
                        suffixIcon: const Icon(
                          Icons.info,
                          color: Colors.black,
                        ),
                        hintText: 'About',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter something about yourself';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _phoneNumber,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 10.0,
                          horizontal: 15.0,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(40.0),
                        ),
                        suffixIcon: const Icon(
                          Icons.phone,
                          color: Colors.black,
                        ),
                        hintText: 'Phone Number',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your phone number';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    DropdownButtonFormField<String>(
                      value: _selectedWorkStatus,
                      onChanged: (value) {
                        setState(() {
                          _selectedWorkStatus = value;
                        });
                      },
                      items: _workStatus.map((status) {
                        return DropdownMenuItem<String>(
                          value: status,
                          child: Text(status),
                        );
                      }).toList(),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 10.0,
                          horizontal: 15.0,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(40.0),
                        ),
                        hintText: 'Open to work',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select your work status';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _address,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 10.0,
                          horizontal: 15.0,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(40.0),
                        ),
                        suffixIcon: const Icon(
                          Icons.home,
                          color: Colors.black,
                        ),
                        hintText: 'Address',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your address';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    DropdownButtonFormField<String>(
                      value: _selectedCountry,
                      onChanged: (value) {
                        setState(() {
                          _selectedCountry = value;
                        });
                      },
                      items: _countries.map((status) {
                        return DropdownMenuItem<String>(
                          value: status,
                          child: Text(status),
                        );
                      }).toList(),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 10.0,
                          horizontal: 15.0,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(40.0),
                        ),
                        hintText: 'Country',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select your Country';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 20),
                    DropdownButtonFormField<String>(
                      value: _selectedProvince,
                      onChanged: (value) {
                        setState(() {
                          _selectedProvince = value;
                        });
                      },
                      items: _provinces.map((status) {
                        return DropdownMenuItem<String>(
                          value: status,
                          child: Text(status),
                        );
                      }).toList(),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 10.0,
                          horizontal: 15.0,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(40.0),
                        ),
                        hintText: 'Province',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select your Province';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    DropdownButtonFormField<String>(
                      value: _selectedTown,
                      onChanged: (value) {
                        setState(() {
                          _selectedTown = value;
                        });
                      },
                      items: _towns.map((status) {
                        return DropdownMenuItem<String>(
                          value: status,
                          child: Text(status),
                        );
                      }).toList(),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 10.0,
                          horizontal: 15.0,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(40.0),
                        ),
                        hintText: 'Town',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select your Town';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 20),
                    Obx(() {
                      return _individualProfileService.isLoading.value
                          ? const CircularProgressIndicator()
                          : SubmitButton(
                              text: 'Submit',
                              onTap: () async {
                                if (_formKey.currentState!.validate()) {
                                  final prefs =
                                      await SharedPreferences.getInstance();
                                  int? userId = prefs.getInt('userId');
                                  var profileData = {
                                    'title': _selectedTitle.text,
                                    'phone_number': _phoneNumber.text,
                                    'address': _address.text,
                                    'gender': _selectedGender,
                                    'about': _about.text,
                                    'open_to_work':
                                        _selectedWorkStatus == 'Yes' ? 1 : 0,
                                    'user_id': userId,
                                  };
                                  await _individualProfileService.createProfile(
                                      profileData, _image);
                                }
                              },
                            );
                    }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
