class Identification {
  final int id;
  final String? identificationType;
  final String? identificationFile;
  final int verified;
  final String? verifiedBy;
  final int individualProfileId;

  Identification({
    required this.id,
    required this.identificationType,
    required this.identificationFile,
    required this.verified,
    required this.verifiedBy,
    required this.individualProfileId,
  });

  factory Identification.fromJson(Map<String, dynamic> json) {
    return Identification(
      id: json['id'] ?? 0,
      identificationType: json['identification_type'] ?? '',
      identificationFile: json['identification_file'] ?? '',
      verified: json['verified'] ?? 0,
      verifiedBy: json['verified_by'] ?? '',
      individualProfileId: json['individual_profile_id'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'identificationType': identificationType,
      'identification_file': identificationFile,
      'verified': verified,
      'verifiedBy': verifiedBy,
      'individualProfileId': individualProfileId,
    };
  }
}
