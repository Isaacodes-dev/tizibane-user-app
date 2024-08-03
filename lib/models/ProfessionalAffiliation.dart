class ProfessionalAffiliation {
  final int id;
  final String organizationName;
  final String membershipId;
  final String role;
  final String certificate;
  final DateTime validFrom;
  final DateTime validTo;
  final int verified;
  final dynamic verifiedBy;
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
      organizationName: json['organizationName'] ?? '',
      membershipId: json['membershipId'] ?? '',
      role: json['role'] ?? '',
      certificate: json['certificate'] ?? '',
      validFrom: json['validFrom'] != null ? DateTime.parse(json['validFrom']) : DateTime.now(),
      validTo: json['validTo'] != null ? DateTime.parse(json['validTo']) : DateTime.now(),
      verified: json['verified'] ?? 0,
      verifiedBy: json['verifiedBy'],
      individualProfileId: json['individualProfileId'] ?? 0,
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : DateTime.now(),
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : DateTime.now(),
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
