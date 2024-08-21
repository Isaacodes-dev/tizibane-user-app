import 'package:tizibane/models/Education.dart';
import 'package:tizibane/models/Experience.dart';
import 'package:tizibane/models/Indentification.dart';
import 'package:tizibane/models/ProfessionalAffiliation.dart';
import 'package:tizibane/models/Skill.dart';

class IndividualProfile {
  final int id;
  final String? title;
  final String? phoneNumber;
  final String? address;
  final String? gender;
  final String? profilePicture;
  final String? about;
  final int? openToWork;
  final int? userId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<ProfessionalAffiliation>? professionalAffiliations;
  final List<Experience>? experience;
  final List<Education>? education;
  final List<Skill>? skills;
  final List<dynamic>? resumes;
  final Identification? identification;
  final List<dynamic>? subscriptions;

  IndividualProfile({
    required this.id,
    this.title,
    this.phoneNumber,
    this.address,
    this.gender,
    this.profilePicture,
    this.about,
    required this.openToWork,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    this.professionalAffiliations,
    this.experience,
    this.education,
    this.skills,
    this.resumes,
    this.identification,
    this.subscriptions,
  });

  factory IndividualProfile.fromJson(Map<String, dynamic> json) {
    return IndividualProfile(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      phoneNumber: json['phone_number'] ?? '',
      address: json['address'] ?? '',
      gender: json['gender'] ?? '',
      profilePicture: json['profile_picture'] ?? '',
      about: json['about'] ?? '',
      openToWork: json['open_to_work'] ?? 0,
      userId: json['user_id'] ?? 0,
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : DateTime.now(),
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : DateTime.now(),
      professionalAffiliations: (json['professional_affiliations'] as List<dynamic>?)
              ?.map((item) => ProfessionalAffiliation.fromJson(item))
              .toList() ??
          [],
      experience: (json['experience'] as List<dynamic>?)
              ?.map((item) => Experience.fromJson(item))
              .toList() ??
          [],
      education: (json['education'] as List<dynamic>?)
              ?.map((item) => Education.fromJson(item))
              .toList() ??
          [],
      skills: (json['skills'] as List<dynamic>?)
              ?.map((item) => Skill.fromJson(item))
              .toList() ??
          [],
      resumes: json['resumes'] ?? [],
      identification: json['identification'] != null 
          ? Identification.fromJson(json['identification']) 
          : null,
      subscriptions: json['subscriptions'] ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'phone_number': phoneNumber,
      'address': address,
      'gender': gender,
      'profile_picture': profilePicture,
      'about': about,
      'open_to_work': openToWork,
      'user_id': userId,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'professional_affiliations': professionalAffiliations?.map((item) => item.toJson()).toList(),
      'experience': experience?.map((item) => item.toJson()).toList(),
      'education': education?.map((item) => item.toJson()).toList(),
      'skills': skills?.map((item) => item.toJson()).toList(),
      // 'resumes': resumes,
      // 'identification': identification?.toJson(),
      // 'subscriptions': subscriptions,
    };
  }
}
