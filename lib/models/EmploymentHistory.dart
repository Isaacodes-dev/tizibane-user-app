class EmploymentHistory {
  final String startDate;
  final String endDate;
  final String positionName;
  final String companyName;
  final String companyPhone;
  final String companyEmail;
  final String companyAddress;

  EmploymentHistory({
    required this.startDate,
    required this.endDate,
    required this.positionName,
    required this.companyName,
    required this.companyPhone,
    required this.companyEmail,
    required this.companyAddress,
  });

  factory EmploymentHistory.fromJson(Map<String, dynamic> json) {
    return EmploymentHistory(
      startDate: json['start_date'],
      endDate: json['end_date'],
      positionName: json['position_name'],
      companyName: json['company_name'],
      companyPhone: json['company_phone'],
      companyEmail: json['company_email'],
      companyAddress: json['company_address'],
    );
  }
}
