class EmploymentHistory {
  final String companyName;
  final String companyEmail;
  final String companyPhone;
  final String companyAddress;
  final String companyLogo;
  final String position;
  final String startDate;
  final String endDate;
  final String companyWebsite;

  EmploymentHistory({
    required this.companyName,
    required this.companyEmail,
    required this.companyPhone,
    required this.companyAddress,
    required this.companyLogo,
    required this.position,
    required this.startDate,
    required this.endDate,
    required this.companyWebsite,
  });

  factory EmploymentHistory.fromJson(Map<String, dynamic> json) {
    return EmploymentHistory(
      companyName: json['company_name'] ?? '',
      companyEmail: json['company_email'] ?? '',
      companyPhone: json['company_phone'] ?? '',
      companyAddress: json['company_address'] ?? '',
      companyLogo: json['company_logo_url'] ?? '',
      companyWebsite: json['company_website'] ?? '',
      position: json['position_name'] ?? '',
      startDate: json['start_date'] ??'',
      endDate: json['end_date'] ??'',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'companyName': companyName,
      'companyEmail': companyEmail,
      'position': position,
      'startDate': startDate,
      'endDate': endDate,
    };
  }
}
