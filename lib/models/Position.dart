class Position{
  String? positionId;
  String? positionName;
  int? chartLevel;
  int? departmentId;
  String? createdAt;
  String? updatedAt;
  Null? deletedAt;

  Position(
      {this.positionId,
      this.positionName,
      this.chartLevel,
      this.departmentId,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  factory Position.fromJson(Map<String, dynamic> json){
    return Position(
      positionId: json['position_id'].toString(),
      positionName: json['position_name'] ?? '',
      chartLevel: json['chart_level'] ?? 0,
      departmentId: json['department_id'] ?? 0,
    );
  }
}