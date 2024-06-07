class LoginUser{
  final String nrc;

  final String password;

  const LoginUser({
    required this.nrc,

    required this.password
  });

  factory LoginUser.fromJson(Map<String, dynamic>json)
  {
    return LoginUser(
      nrc: json['nrc'],
      password: json['password'] as String
    );
  }
    Map<String, dynamic> toJson() {
    return {
      'nrc': nrc,
      'password': password,
    };
  }
}

