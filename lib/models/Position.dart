class Position{
  String? positionId;
  String? positionName;
  String? createdAt;
  String? updatedAt;
  Null? deletedAt;

  Position(
      {this.positionId,
      this.positionName,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  factory Position.fromJson(Map<String, dynamic> json){
    return Position(
      positionId: json['position_id'].toString(),
      positionName: json['position_name'] ?? '',
    );
  }
}