class Education {
  final int id;
  final String? institutionName;
  final dynamic other;
  final String? degree;
  final String? fieldOfStudy;
  final DateTime startDate;
  final DateTime endDate;
  final String? grade;
  final String? certificate;
  final int verified;
  final String? verifiedBy;
  final int individualProfileId;
  final DateTime createdAt;
  final DateTime updatedAt;

  Education({
    required this.id,
    required this.institutionName,
    required this.other,
    required this.degree,
    required this.fieldOfStudy,
    required this.startDate,
    required this.endDate,
    required this.grade,
    required this.certificate,
    required this.verified,
    required this.verifiedBy,
    required this.individualProfileId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Education.fromJson(Map<String, dynamic> json) {
    return Education(
      id: json['id'] ?? 0,
      institutionName: json['institution_name'] ?? '',
      other: json['other'],
      degree: json['degree'] ?? '',
      fieldOfStudy: json['field_of_study'] ?? '',
      startDate: json['start_date'] != null ? DateTime.parse(json['start_date']) : DateTime.now(),
      endDate: json['end_date'] != null ? DateTime.parse(json['end_date']) : DateTime.now(),
      grade: json['grade'] ?? '',
      certificate: json['certificate'] ?? '',
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
      'institution_name': institutionName,
      'other': other,
      'degree': degree,
      'fieldOfStudy': fieldOfStudy,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'grade': grade,
      'certificate': certificate,
      'verified': verified,
      'verified_by': verifiedBy,
      'individualProfileId': individualProfileId,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
