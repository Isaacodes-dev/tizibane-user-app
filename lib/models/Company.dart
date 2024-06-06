class Company{
  String? companyName;
  String? companyPhone;
  String? companyEmail;
  String? companyAddress;
  String? companyWebsite;
  String? companyLogoUrl;

  Company(
      {
      this.companyName,
      this.companyPhone,
      this.companyEmail,
      this.companyAddress,
      this.companyWebsite,
      this.companyLogoUrl,
});


factory Company.fromJson (Map<String, dynamic> json){
  return Company(
    companyName: json['company_name'] ?? '',
    companyPhone: json['company_phone'] ?? '',
    companyEmail: json['company_email'] ?? '',
    companyAddress: json['company_address'] ?? '',
    companyWebsite: json['company_website'] ?? '',
    companyLogoUrl: json['company_logo_url'] ?? '',
  );
}

}