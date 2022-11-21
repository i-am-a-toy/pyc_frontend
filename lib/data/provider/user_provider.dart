import 'package:dio/dio.dart';
import 'package:pyc/common/libraries/auth_api_client.dart';

class UserProvider {
  Future<Response> fetchMe() async {
    final client = await getAuthApiClient();
    return client.get('/api/v1/users/me');
  }
}
