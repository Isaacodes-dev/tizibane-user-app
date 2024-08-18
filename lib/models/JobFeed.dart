import 'package:tizibane/models/Company.dart';

class JobListing {
  String id;
  int positionId;
  String title;
  String description;
  String responsibilities;
  String employmentType;
  String? salaryRange;
  DateTime applicationDeadline;
  String status;
  int experience;
  String experiencePeriod;
  bool phd;
  bool masters;
  String? degree;
  String? diploma;
  String qualificationField;
  String? certificate;
  String? forwardEmail1;
  String? forwardEmail2;
  String? forwardEmail3;
  int countryId;
  int provinceId;
  int townId;
  int companyId;
  DateTime createdAt;
  DateTime updatedAt;
  Company company;

  JobListing({
    required this.id,
    required this.positionId,
    required this.title,
    required this.description,
    required this.responsibilities,
    required this.employmentType,
    this.salaryRange,
    required this.applicationDeadline,
    required this.status,
    required this.experience,
    required this.experiencePeriod,
    required this.phd,
    required this.masters,
    this.degree,
    this.diploma,
    required this.qualificationField,
    this.certificate,
    this.forwardEmail1,
    this.forwardEmail2,
    this.forwardEmail3,
    required this.countryId,
    required this.provinceId,
    required this.townId,
    required this.companyId,
    required this.createdAt,
    required this.updatedAt,
    required this.company,
  });

  factory JobListing.fromJson(Map<String, dynamic> json) {
    return JobListing(
      id: json['id'],
      positionId: json['position_id'],
      title: json['title'],
      description: json['description'],
      responsibilities: json['responsibilities'],
      employmentType: json['employment_type'],
      salaryRange: json['salary_range'],
      applicationDeadline: DateTime.parse(json['application_deadline']),
      status: json['status'],
      experience: json['experience'],
      experiencePeriod: json['experience_period'],
      phd: json['phd'] == 1,
      masters: json['masters'] == 1,
      degree: json['degree'],
      diploma: json['diploma'],
      qualificationField: json['qualification_field'],
      certificate: json['certificate'],
      forwardEmail1: json['forward_email_1'],
      forwardEmail2: json['forward_email_2'],
      forwardEmail3: json['forward_email_3'],
      countryId: json['country_id'],
      provinceId: json['province_id'],
      townId: json['town_id'],
      companyId: json['company_id'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      company: Company.fromJson(json['company']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'position_id': positionId,
      'title': title,
      'description': description,
      'responsibilities': responsibilities,
      'employment_type': employmentType,
      'salary_range': salaryRange,
      'application_deadline': applicationDeadline.toIso8601String(),
      'status': status,
      'experience': experience,
      'experience_period': experiencePeriod,
      'phd': phd ? 1 : 0,
      'masters': masters ? 1 : 0,
      'degree': degree,
      'diploma': diploma,
      'qualification_field': qualificationField,
      'certificate': certificate,
      'forward_email_1': forwardEmail1,
      'forward_email_2': forwardEmail2,
      'forward_email_3': forwardEmail3,
      'country_id': countryId,
      'province_id': provinceId,
      'town_id': townId,
      'company_id': companyId,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'company': company.toJson(),
    };
  }
}