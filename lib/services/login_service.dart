import 'package:pyc/common/dto/auth/requests/login_request.dart';
import 'package:pyc/common/dto/auth/responses/login_response.dart';
import 'package:pyc/common/dto/common/validate_response.dart';
import 'package:pyc/common/libraries/api_request.dart';

class LoginService {
  Future<ValidateResponse> isValidated(String token) async {
    ApiRequest request = ApiRequest(
        url: '/api/v1/auth/token/validate',
        header: {'Authorization': 'Bearer $token'});

    final resp = await request.get();
    return ValidateResponse.fromJson(resp.data);
  }

  Future<LoginResponse> login(String id, String password) async {
    ApiRequest request = ApiRequest(
      url: '/api/v1/auth/login',
      data: LoginRequest(name: id, password: password).toJson(),
    );

    final resp = await request.post();
    return LoginResponse.fromJson(resp.data);
  }
}
