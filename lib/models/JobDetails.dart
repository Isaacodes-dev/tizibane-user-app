import 'package:tizibane/models/Company.dart';

class JobDetails{
  int? id;
  String? open;
  String? closed;
  String? description;
  String? responsibilitiesAndDuties;
  String? qualificationsAndExperience;
  String? otherComment;
  String? position;
  String? createdAt;
  String? updatedAt;
  Company? company;

  JobDetails(
      {this.id,
      this.open,
      this.closed,
      this.description,
      this.responsibilitiesAndDuties,
      this.qualificationsAndExperience,
      this.otherComment,
      this.position,
      this.createdAt,
      this.updatedAt,
      this.company,
      });

factory JobDetails.fromJson(Map<String, dynamic> json) {
  return JobDetails(
    id: json['id'] ?? 0,
    open: json['open'],
    closed: json['closed'],
    description: json['description'],
    responsibilitiesAndDuties: json['responsibilities_and_duties'],
    qualificationsAndExperience: json['qualifications_and_experience'],
    otherComment: json['other_comment'],
    position: json['position'],
    createdAt: json['created_at'],
    updatedAt: json['updated_at'],
    company: json['company'] != null && json['company'] is Map<String, dynamic>
        ? Company.fromJson(json['company'])
        : null,
  );
}
}