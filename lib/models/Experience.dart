class Experience {
  final int id;
  final String? companyName;
  final String? jobTitle;
  final DateTime startDate;
  final DateTime endDate;
  final String? responsibilities;
  final int individualProfileId;
  final DateTime createdAt;
  final DateTime updatedAt;

  Experience({
    required this.id,
    required this.companyName,
    required this.jobTitle,
    required this.startDate,
    required this.endDate,
    required this.responsibilities,
    required this.individualProfileId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Experience.fromJson(Map<String, dynamic> json) {
    return Experience(
      id: json['id'] ?? 0,
      companyName: json['company_name'] ?? '',
      jobTitle: json['job_title'] ?? '',
      startDate: json['start_date'] != null ? DateTime.parse(json['start_date']) : DateTime.now(),
      endDate: json['end_date'] != null ? DateTime.parse(json['end_date']) : DateTime.now(),
      responsibilities: json['responsibilities'] ?? '',
      individualProfileId: json['individual_profile_id'] ?? 0,
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : DateTime.now(),
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'companyName': companyName,
      'jobTitle': jobTitle,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'responsibilities': responsibilities,
      'individualProfileId': individualProfileId,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
