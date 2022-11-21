class TokenResponse {
  final String accessToken;

  TokenResponse({required this.accessToken});
  TokenResponse.fromJSON(Map<String, dynamic> json)
      : accessToken = json['accessToken'];
}
