import 'package:tizibane/models/Education.dart';
import 'package:tizibane/models/Experience.dart';
import 'package:tizibane/models/Indentification.dart';
import 'package:tizibane/models/ProfessionalAffiliation.dart';
import 'package:tizibane/models/Skill.dart';

class IndividualProfile {
  final int id;
  final String title;
  final String phoneNumber;
  final String address;
  final String gender;
  final String profilePicture;
  final String about;
  final int openToWork;
  final int userId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<ProfessionalAffiliation> professionalAffiliations;
  final List<Experience> experience;
  final List<Education> education;
  final List<Skill> skills;
  final List<dynamic> resumes;
  final Identification identification;
  final List<dynamic> subscriptions;

  IndividualProfile({
    required this.id,
    required this.title,
    required this.phoneNumber,
    required this.address,
    required this.gender,
    required this.profilePicture,
    required this.about,
    required this.openToWork,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    required this.professionalAffiliations,
    required this.experience,
    required this.education,
    required this.skills,
    required this.resumes,
    required this.identification,
    required this.subscriptions,
  });

  factory IndividualProfile.fromJson(Map<String, dynamic> json) {
    return IndividualProfile(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      address: json['address'] ?? '',
      gender: json['gender'] ?? '',
      profilePicture: json['profilePicture'] ?? '',
      about: json['about'] ?? '',
      openToWork: json['openToWork'] ?? 0,
      userId: json['userId'] ?? 0,
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : DateTime.now(),
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : DateTime.now(),
      professionalAffiliations: (json['professionalAffiliations'] as List<dynamic>?)
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
      identification: Identification.fromJson(json['identification'] ?? {}),
      subscriptions: json['subscriptions'] ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'phoneNumber': phoneNumber,
      'address': address,
      'gender': gender,
      'profilePicture': profilePicture,
      'about': about,
      'openToWork': openToWork,
      'userId': userId,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'professionalAffiliations': professionalAffiliations.map((item) => item.toJson()).toList(),
      'experience': experience.map((item) => item.toJson()).toList(),
      'education': education.map((item) => item.toJson()).toList(),
      'skills': skills.map((item) => item.toJson()).toList(),
      'resumes': resumes,
      'identification': identification.toJson(),
      'subscriptions': subscriptions,
    };
  }
}
