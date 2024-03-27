class ContactModel {
  final String nrc;
  final String fullNames;
  final String phoneNumber;
  final String email;
  final String? companyId;
  final String? positionId;
  final String roleId;
  final String createdAt;
  final String updatedAt;
  final String profilePicture;

  ContactModel({
    required this.nrc,
    required this.fullNames,
    required this.phoneNumber,
    required this.email,
    this.companyId,
    this.positionId,
    required this.roleId,
    required this.createdAt,
    required this.updatedAt,
    required this.profilePicture,
  });

  factory ContactModel.fromJson(Map<String, dynamic> json) {
    return ContactModel(
      nrc: json['nrc'] ?? '',
      fullNames: json['full_names'] ?? '',
      phoneNumber: json['phone_number'] ?? '',
      email: json['email'] ?? '',
      companyId: json['company_id'],
      positionId: json['position_id'],
      roleId: json['role_id'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      profilePicture: json['profile_picture'] ?? '',
    );
  }
}
