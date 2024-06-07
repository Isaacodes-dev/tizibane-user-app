import 'dart:convert';

class Employee {
  final String firstName;
  final String lastName;
  final String positionName;
  final String companyName;
  final String telephone;
  final String cell;
  final String email;
  final String companyAddress;
  final String userProfilePic;
  final String companyLogoUrl;
  final String companyWebsite;

  Employee({
    required this.firstName,
    required this.lastName,
    required this.positionName,
    required this.companyName,
    required this.telephone,
    required this.cell,
    required this.email,
    required this.companyAddress,
    required this.userProfilePic,
    required this.companyLogoUrl,
    required this.companyWebsite,
  });

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      firstName: json['first_name'],
      lastName: json['last_name'],
      positionName: json['position_name'],
      companyName: json['company_name'],
      telephone: json['telephone'],
      cell: json['cell'],
      email: json['email'],
      companyAddress: json['company_address'],
      userProfilePic: json['user_profile_pic'],
      companyLogoUrl: json['company_logo_url'],
      companyWebsite: json['company_website'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'position_name': positionName,
      'company_name': companyName,
      'telephone': telephone,
      'cell': cell,
      'email': email,
      'company_address': companyAddress,
      'user_profile_pic': userProfilePic,
      'company_logo_url': companyLogoUrl,
      'company_website': companyWebsite,
    };
  }
}
