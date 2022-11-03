class ValidateResponse {
  final bool result;

  ValidateResponse({required this.result});
  ValidateResponse.fromJson(Map<String, dynamic> json)
      : result = json["result"];
}
