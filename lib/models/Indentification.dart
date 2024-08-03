class Identification {
  final int id;
  final String identificationType;
  final String identificationFile;
  final int verified;
  final dynamic verifiedBy;
  final int individualProfileId;
  final DateTime createdAt;
  final DateTime updatedAt;

  Identification({
    required this.id,
    required this.identificationType,
    required this.identificationFile,
    required this.verified,
    required this.verifiedBy,
    required this.individualProfileId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Identification.fromJson(Map<String, dynamic> json) {
    return Identification(
      id: json['id'] ?? 0,
      identificationType: json['identificationType'] ?? '',
      identificationFile: json['identificationFile'] ?? '',
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
      'identificationType': identificationType,
      'identificationFile': identificationFile,
      'verified': verified,
      'verifiedBy': verifiedBy,
      'individualProfileId': individualProfileId,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
