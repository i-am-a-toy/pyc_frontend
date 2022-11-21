import 'package:get/get.dart';
import 'package:pyc/data/model/user/response/user_response.dart';
import 'package:pyc/data/provider/user_provider.dart';

class UserRepository extends GetxService {
  final UserProvider userProvider;

  UserRepository({required this.userProvider});

  Future<UserResponse> fetchMe() async {
    final result = await userProvider.fetchMe();
    UserResponse response = UserResponse.fromJson(result.data);
    print(response.toString());
    return response;
  }
}
