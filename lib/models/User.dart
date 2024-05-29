class User{
  final String nrc;
  final String first_name;
  final String last_name;
  final String phone_number;
  final String email;
  final String password;
  final String profilePicture;
  final String position_name;
  final String company_name;
  final String company_address;
  final String comapny_website;
  final String comapny_phone;
  final String company_assigned_email;
  final String companyEmail;
  final String telephone;
  final String company_logo_url;

  const User({
    required this.nrc,
    required this.first_name,
    required this.last_name,
    required this.phone_number,
    required this.email,
    required this.password,
    required this.profilePicture,
    required this.position_name,
    required this.company_name,
    required this.companyEmail,
    required this.comapny_website,
    required this.comapny_phone,
    required this.company_address,
    required this.company_assigned_email,
    required this.company_logo_url,
    required this.telephone,
  });

factory User.fromJson(Map<String, dynamic> json) {
  return User(
    nrc: json['nrc'] ?? '',
    first_name: json['first_name'] ?? '',
    last_name: json['last_name'] ?? '',
    phone_number: json['phone_number'] ?? '',
    email: json['user_email'] ?? '',
    password: json['password'] ?? '',
    profilePicture: json['profilePicture'] ?? '',
    position_name: json['position_name'] ?? '',
    company_name: json['company_name'] ?? '',
    company_address: json['company_address'] ?? '',
    comapny_phone: json['company_phone'] ?? '',
    companyEmail: json['company_email'] ?? '',
    company_assigned_email: json['company_assigned_email'] ?? '',
    telephone: json['telephone'] ?? '',
    company_logo_url: json['company_logo_url'] ?? '',
    comapny_website: json['company_website'] ?? '',
  );
}
    Map<String, dynamic> toJson() {
    return {
      'nrc': nrc,
      'first_name': first_name,
      'last_name': last_name,
      'phone_number': phone_number,
      'email': email,
      'password': password,
      'profilePicture': profilePicture,
      'position_name': position_name,
      'company_name': company_name
    };
  }
}

