import 'package:get/get.dart';
import 'package:pyc/controllers/home/home_controller.dart';
import 'package:pyc/controllers/user/fetch_me_controller.dart';
import 'package:pyc/data/provider/user_provider.dart';
import 'package:pyc/data/repository/user_repository.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<FetchMeController>(
      FetchMeController(
        repo: UserRepository(userProvider: UserProvider()),
      ),
    );
    Get.put(HomeController());
  }
}
