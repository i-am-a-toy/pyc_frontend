class LoginRequest {
  final String _name;
  final String _password;

  LoginRequest({required String name, required String password})
      : _name = name,
        _password = password;

  Map<String, dynamic> toJson() {
    return {
      'name': _name,
      'password': _password,
    };
  }
}
