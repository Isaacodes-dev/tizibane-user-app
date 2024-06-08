class EmploymentHistory {
  final String companyName;
  final String companyEmail;
  final String companyPhone;
  final String companyAddress;
  final String companyLogo;
  final String position;
  final String startDate;
  final String endDate;
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
      companyName: json['companyName'] ?? '',
      companyEmail: json['companyEmail'] ?? '',
      companyPhone: json['companyPhone'] ?? '',
      companyAddress: json['companyAddress'] ?? '',
      companyLogo: json['company_logo_url'] ?? '',
      position: json['position_name'] ?? '',
      startDate: json['start_date'] ??'',
      endDate: json['end_date'] ??'',
      description: json['description'] ??'',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'companyName': companyName,
      'companyEmail': companyEmail,
      'position': position,
      'startDate': startDate,
      'endDate': endDate,
      'description': description,
    };
  }
}
