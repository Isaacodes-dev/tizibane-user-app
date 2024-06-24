class ContactModel {
  final String nrc;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String email;
  final String? companyId;
  final String? positionId;
  final String roleId;
  final String createdAt;
  final String updatedAt;
  final String profilePicture;
  final String positionName;
  final String companyName;
  final String companyEmail;
  final String companyLogo;
  final String companyPhone;
  final String comapnyAddress;
  final String comapnyWebsite;
  final String companyAssignedEmail;
  final String telephone;

  ContactModel({
    required this.nrc,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.email,
    this.companyId,
    this.positionId,
    required this.roleId,
    required this.createdAt,
    required this.updatedAt,
    required this.profilePicture,
    required this.positionName,
    required this.companyName,
    required this.companyEmail,
    required this.companyLogo,
    required this.companyPhone,
    required this.comapnyAddress,
    required this.comapnyWebsite,
    required this.companyAssignedEmail,
    required this.telephone,
  });

  factory ContactModel.fromJson(Map<String, dynamic> json) {
    return ContactModel(
      nrc: json['nrc'] ?? '',
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      phoneNumber: json['phone_number'] ?? '',
      email: json['user_email'] ?? '',
      companyId: json['company_id']?.toString(),
      positionId: json['position_id']?.toString(),
      roleId: json['role_id'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      profilePicture: json['profile_picture'] ?? '',
      positionName: json['position_name'] ?? '',
      companyName: json['company_name'] ?? '',
      companyLogo: json['company_logo_url'] ?? '',
      companyEmail: json['company_email'] ?? '',
      companyPhone: json['company_phone'] ?? '',
      comapnyAddress: json['company_address'] ?? '',
      comapnyWebsite: json['company_website'] ?? '',
      companyAssignedEmail: json['company_assigned_email'] ?? '',
      telephone: json['telephone'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nrc': nrc,
      'first_name': firstName,
      'last_name': lastName,
      'phone_number': phoneNumber,
      'user_email': email,
      'company_id': companyId,
      'position_id': positionId,
      'role_id': roleId,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'profile_picture': profilePicture,
      'position_name': positionName,
      'company_name': companyName,
      'company_logo_url': companyLogo,
      'company_email': companyEmail,
      'company_phone': companyPhone,
      'company_address': comapnyAddress,
      'company_website': comapnyWebsite,
      'company_assigned_email': companyAssignedEmail,
      'telephone': telephone,
    };
  }
}
