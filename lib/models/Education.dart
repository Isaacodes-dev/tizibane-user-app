class Education {
  final int id;
  final String institutionName;
  final dynamic other;
  final String degree;
  final String fieldOfStudy;
  final DateTime startDate;
  final DateTime endDate;
  final String grade;
  final String certificate;
  final int verified;
  final dynamic verifiedBy;
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
      institutionName: json['institutionName'] ?? '',
      other: json['other'],
      degree: json['degree'] ?? '',
      fieldOfStudy: json['fieldOfStudy'] ?? '',
      startDate: json['startDate'] != null ? DateTime.parse(json['startDate']) : DateTime.now(),
      endDate: json['endDate'] != null ? DateTime.parse(json['endDate']) : DateTime.now(),
      grade: json['grade'] ?? '',
      certificate: json['certificate'] ?? '',
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
      'institutionName': institutionName,
      'other': other,
      'degree': degree,
      'fieldOfStudy': fieldOfStudy,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'grade': grade,
      'certificate': certificate,
      'verified': verified,
      'verifiedBy': verifiedBy,
      'individualProfileId': individualProfileId,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
