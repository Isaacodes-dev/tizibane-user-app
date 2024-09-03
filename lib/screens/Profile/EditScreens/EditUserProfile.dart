import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tizibane/Services/ProfileServices/IndividualProfileService.dart';
import 'package:tizibane/components/SubmitButton.dart';

class EditUserProfile extends StatefulWidget {
  final String selectedTitle;
  final String phoneNumber;
  final String address;
  final String about;
  final String selectedStatus;
  final String gender;
  final String imagePath;
  final String country;
  final String province;
  final String town;

  const EditUserProfile({
    Key? key,
    required this.selectedTitle,
    required this.phoneNumber,
    required this.address,
    required this.about,
    required this.selectedStatus,
    required this.gender,
    required this.imagePath,
    required this.country,
    required this.province,
    required this.town,
  }) : super(key: key);

  @override
  State<EditUserProfile> createState() => _EditUserProfileState();
}

class _EditUserProfileState extends State<EditUserProfile> {
  final ImagePicker _picker = ImagePicker();
  XFile? _image;
  final _formKey = GlobalKey<FormState>();
  IndividualProfileService _individualProfileService =
      Get.put(IndividualProfileService());

  final List<String> _titles = [
    'Project Manager',
    'Software Developer'
  ]; // Example titles
  final List<String> _workStatus = ['Yes', 'No'];
  final List<String> _genders = ['Male', 'Female'];
  final List<String> _countries = ['Zambia', 'Kenya']; // Example countries
  final List<String> _provinces = ['Lusaka', 'Copperbelt']; // Example provinces
  final List<String> _towns = ['Lusaka', 'Kitwe']; // Example towns

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _aboutController = TextEditingController();

  String? _selectedTitle;
  String? _selectedStatus;
  String? _selectedGender;
  String? _selectedCountry;
  String? _selectedProvince;
  String? _selectedTown;

  Future<void> _pickImage() async {
    final pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = pickedImage;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.selectedTitle;
    _phoneNumberController.text = widget.phoneNumber;
    _addressController.text = widget.address;
    _aboutController.text = widget.about;
    _selectedStatus = widget.selectedStatus;
    _selectedGender = widget.gender;
    _selectedCountry = widget.country;
    _selectedProvince = widget.province;
    _selectedTown = widget.town;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Edit Profile', style: GoogleFonts.lexendDeca()),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              GestureDetector(
                onTap: _pickImage,
                child: Stack(
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
                        child: _image == null
                            ? Image.asset(
                                'assets/images/user.jpg',
                                fit: BoxFit.cover,
                              )
                            : Image.file(
                                File(_image!.path),
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 15,
                      child: Icon(
                        Icons.camera_alt,
                        color: const Color.fromARGB(255, 171, 170, 170),
                        size: 30,
                      ),
                    ),
                  ],
                ),
              ),
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
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  hintText: 'Select Gender',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select your gender';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: _selectedTitle,
                onChanged: (value) {
                  setState(() {
                    _selectedTitle = value;
                  });
                },
                items: _titles.map((title) {
                  return DropdownMenuItem<String>(
                    value: title,
                    child: Text(title),
                  );
                }).toList(),
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  hintText: 'Select Title',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _phoneNumberController,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  hintText: 'Phone Number',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                    return 'Please enter a valid phone number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _addressController,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  hintText: 'Address',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _aboutController,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  hintText: 'About',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter something about yourself';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: _selectedStatus,
                onChanged: (value) {
                  setState(() {
                    _selectedStatus = value;
                  });
                },
                items: _workStatus.map((status) {
                  return DropdownMenuItem<String>(
                    value: status,
                    child: Text(status),
                  );
                }).toList(),
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  hintText: 'Open to Work',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select your work status';
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
                items: _countries.map((country) {
                  return DropdownMenuItem<String>(
                    value: country,
                    child: Text(country),
                  );
                }).toList(),
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  hintText: 'Select Country',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select your country';
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
                items: _provinces.map((province) {
                  return DropdownMenuItem<String>(
                    value: province,
                    child: Text(province),
                  );
                }).toList(),
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  hintText: 'Select Province',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select your province';
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
                items: _towns.map((town) {
                  return DropdownMenuItem<String>(
                    value: town,
                    child: Text(town),
                  );
                }).toList(),
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  hintText: 'Select Town',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select your town';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              SubmitButton(
                text: 'Update Profile',
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    // Handle form submission
                    final profileData = {
                      'title': _selectedTitle,
                      'phone_number': _phoneNumberController.text,
                      'address': _addressController.text,
                      'about': _aboutController.text,
                      'open_to_work': _selectedStatus,
                      'gender': _selectedGender,
                      'country': _selectedCountry,
                      'province': _selectedProvince,
                      'town': _selectedTown,
                      'image': _image?.path,
                    };
                    _individualProfileService.updateProfile(
                        profileData, _image);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
