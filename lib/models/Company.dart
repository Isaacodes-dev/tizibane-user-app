class Company {
  int id;
  String companyName;
  String companyPhone;
  String companyEmail;
  String? hrEmail;
  String? jobPortalLink;
  String companyAddress;
  String companyWebsite;
  String companyLogoUrl;
  int townId;
  int provinceId;
  int countryId;
  int sectorId;
  int userId;
  DateTime createdAt;
  DateTime updatedAt;

  Company({
    required this.id,
    required this.companyName,
    required this.companyPhone,
    required this.companyEmail,
    this.hrEmail,
    this.jobPortalLink,
    required this.companyAddress,
    required this.companyWebsite,
    required this.companyLogoUrl,
    required this.townId,
    required this.provinceId,
    required this.countryId,
    required this.sectorId,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      id: json['id'],
      companyName: json['company_name'],
      companyPhone: json['company_phone'],
      companyEmail: json['company_email'],
      hrEmail: json['hr_email'],
      jobPortalLink: json['job_portal_link'],
      companyAddress: json['company_address'],
      companyWebsite: json['company_website'],
      companyLogoUrl: json['company_logo_url'],
      townId: json['town_id'],
      provinceId: json['province_id'],
      countryId: json['country_id'],
      sectorId: json['sector_id'],
      userId: json['user_id'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'company_name': companyName,
      'company_phone': companyPhone,
      'company_email': companyEmail,
      'hr_email': hrEmail,
      'job_portal_link': jobPortalLink,
      'company_address': companyAddress,
      'company_website': companyWebsite,
      'company_logo_url': companyLogoUrl,
      'town_id': townId,
      'province_id': provinceId,
      'country_id': countryId,
      'sector_id': sectorId,
      'user_id': userId,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
