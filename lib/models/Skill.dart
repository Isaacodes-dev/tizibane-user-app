class Skill {
  final int id;
  final String skillName;
  final String proficiencyLevel;
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
      skillName: json['skillName'] ?? '',
      proficiencyLevel: json['proficiencyLevel'] ?? '',
      individualProfileId: json['individualProfileId'] ?? 0,
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : DateTime.now(),
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : DateTime.now(),
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
