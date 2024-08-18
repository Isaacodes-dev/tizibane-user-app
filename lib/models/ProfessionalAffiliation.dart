class ProfessionalAffiliation {
  final int id;
  final String? organizationName;
  final String? membershipId;
  final String? role;
  final String? certificate;
  final DateTime validFrom;
  final DateTime validTo;
  final int verified;
  final String? verifiedBy;
  final int individualProfileId;
  final DateTime createdAt;
  final DateTime updatedAt;

  ProfessionalAffiliation({
    required this.id,
    required this.organizationName,
    required this.membershipId,
    required this.role,
    required this.certificate,
    required this.validFrom,
    required this.validTo,
    required this.verified,
    required this.verifiedBy,
    required this.individualProfileId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProfessionalAffiliation.fromJson(Map<String, dynamic> json) {
    return ProfessionalAffiliation(
      id: json['id'] ?? 0,
      organizationName: json['organization_name'] ?? '',
      membershipId: json['membership_id'] ?? '',
      role: json['role'] ?? '',
      certificate: json['certificate'] ?? '',
      validFrom: json['valid_from'] != null ? DateTime.parse(json['valid_from']) : DateTime.now(),
      validTo: json['valid_to'] != null ? DateTime.parse(json['valid_to']) : DateTime.now(),
      verified: json['verified'] ?? 0,
      verifiedBy: json['verified_by'] ?? '',
      individualProfileId: json['individual_profile_id'] ?? 0,
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : DateTime.now(),
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'organizationName': organizationName,
      'membershipId': membershipId,
      'role': role,
      'certificate': certificate,
      'validFrom': validFrom.toIso8601String(),
      'validTo': validTo.toIso8601String(),
      'verified': verified,
      'verifiedBy': verifiedBy,
      'individualProfileId': individualProfileId,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
