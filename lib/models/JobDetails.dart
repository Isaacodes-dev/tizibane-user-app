import 'package:tizibane/models/Company.dart';
import 'package:tizibane/models/Position.dart';

class JobDetails{
  int? id;
  String? open;
  String? closed;
  String? description;
  String? responsibilitiesAndDuties;
  String? qualificationsAndExperience;
  String? otherComment;
  String? positionId;
  int? companyId;
  String? createdAt;
  String? updatedAt;
  Company? company;
  Position? position;


  JobDetails(
      {this.id,
      this.open,
      this.closed,
      this.description,
      this.responsibilitiesAndDuties,
      this.qualificationsAndExperience,
      this.otherComment,
      this.positionId,
      this.companyId,
      this.createdAt,
      this.updatedAt,
      this.company,
      this.position});

  factory JobDetails.fromJson(Map<String, dynamic> json) {
    return JobDetails(
    id : json['id'] ?? 0,
    open : json['open'],
    closed : json['closed'],
    description : json['description'],
    responsibilitiesAndDuties : json['responsibilities_and_duties'],
    qualificationsAndExperience : json['qualifications_and_experience'],
    otherComment : json['other_comment'],
    positionId : json['position_id'].toString(),
    companyId : json['company_id'],
    createdAt : json['created_at'],
    updatedAt : json['updated_at'],
    company :
        json['company'] != null ? Company.fromJson(json['company']) : null,
    position : json['position'] != null
        ? Position.fromJson(json['position'])
        : null,
  );
  }

}