class Skill {
  final int id;
  final String? skillName;
  final String? proficiencyLevel;
  final int individualProfileId;
  final DateTime createdAt;
  final DateTime updatedAt;

  Skill({
    required this.id,
    required this.skillName,
    required this.proficiencyLevel,
    required this.individualProfileId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Skill.fromJson(Map<String, dynamic> json) {
    return Skill(
      id: json['id'] ?? 0,
      skillName: json['skill_name'] ?? '',
      proficiencyLevel: json['proficiency_level'] ?? '',
      individualProfileId: json['individual_profile_id'] ?? 0,
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : DateTime.now(),
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'skillName': skillName,
      'proficiencyLevel': proficiencyLevel,
      'individualProfileId': individualProfileId,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
