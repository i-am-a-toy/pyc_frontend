import 'package:dio/dio.dart';
import 'package:pyc/common/libraries/auth_api_request.dart';
import 'package:pyc/data/model/user/response/user_response.dart';

class UserProvider {
  Future<Response> fetchMe() async {
    final client = await getDioClient();
    return client.get<UserResponse>('/api/v1/users/me');
  }
}
