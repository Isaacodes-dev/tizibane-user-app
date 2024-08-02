class Experience {
  final int id;
  final String companyName;
  final String jobTitle;
  final DateTime startDate;
  final DateTime endDate;
  final String responsibilities;
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
      companyName: json['companyName'] ?? '',
      jobTitle: json['jobTitle'] ?? '',
      startDate: json['startDate'] != null ? DateTime.parse(json['startDate']) : DateTime.now(),
      endDate: json['endDate'] != null ? DateTime.parse(json['endDate']) : DateTime.now(),
      responsibilities: json['responsibilities'] ?? '',
      individualProfileId: json['individualProfileId'] ?? 0,
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : DateTime.now(),
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : DateTime.now(),
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
