class Group {
  final String group_id;
  final String group_logo;
  final String group_name;
  final String group_phone_number;
  final String group_email;
  

  Group({
    required this.group_id,
    required this.group_logo,
    required this.group_name,
    required this.group_phone_number,
    required this.group_email,
    
  });

  factory Group.fromJson(Map<String, dynamic> json) {
    return Group(
        group_id: json['group_id'] ?? '',
        group_logo: json['group_logo'] ?? '',
        group_name: json['group_name'] ?? '',
        group_phone_number: json['group_phone_number'] ?? '',
        group_email: json['group_email'] ?? '',
  );
  }
}
