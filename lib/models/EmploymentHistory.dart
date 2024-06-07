class EmploymentHistory {
  final String companyName;
  final String companyEmail;
  final String companyPhone;
  final String companyAddress;
  final String companyLogo;
  final String position;
  final DateTime startDate;
  final DateTime endDate;
  final String description;

  EmploymentHistory({
    required this.companyName,
    required this.companyEmail,
    required this.companyPhone,
    required this.companyAddress,
    required this.companyLogo,
    required this.position,
    required this.startDate,
    required this.endDate,
    required this.description,
  });

  factory EmploymentHistory.fromJson(Map<String, dynamic> json) {
    return EmploymentHistory(
      companyName: json['companyName'],
      companyEmail: json['companyEmail'],
      companyPhone: json['companyPhone'],
      companyAddress: json['companyAddress'],
      companyLogo: json['companyLogo'],
      position: json['position'],
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'companyName': companyName,
      'companyEmail': companyEmail,
      'position': position,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'description': description,
    };
  }
}
