class LoginResponse {
  final String token;

  LoginResponse({required this.token});
  LoginResponse.fromJson(Map<String, dynamic> json)
      : token = json["accessToken"];
}
