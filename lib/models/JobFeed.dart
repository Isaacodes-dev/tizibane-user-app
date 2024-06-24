class JobsFeed {
  int? id;
  String? closed;
  String? companyLogoUrl;
  String? companyName;
  String? companyAddress;
  String? position;

  JobsFeed(
      {
      this.id,
      this.closed,
      this.companyLogoUrl,
      this.companyName,
      this.companyAddress,
      this.position}
    );

    factory JobsFeed.fromJson(Map<String, dynamic> json) {
      return JobsFeed(
        id: json['id'] ?? 0,
        closed: json['closed'] ?? '',
        companyName: json['company_name'] ?? '',
        companyLogoUrl: json['company_logo_url'] ?? '',
        companyAddress: json['company_address'] ?? '',
        position: json['position'] ?? '',
      );
  }

  Map<String, dynamic> toJson(){
    return {
      'id' : id,
      'closed' : closed,
      'company_name' : companyName,
      'company_logo_url': companyLogoUrl,
      'company_address': companyAddress,
      'position' : position
    };
  }

}
