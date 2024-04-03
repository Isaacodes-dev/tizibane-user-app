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
    required this.positionName
  });

  factory ContactModel.fromJson(Map<String, dynamic> json) {
    return ContactModel(
      nrc: json['nrc'] ?? '',
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      phoneNumber: json['phone_number'] ?? '',
      email: json['email'] ?? '',
      companyId: json['company_id'],
      positionId: json['position_id'],
      roleId: json['role_id'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      profilePicture: json['profile_picture'] ?? '',
      positionName: json['position_name'] ?? '',
    );
  }
}
