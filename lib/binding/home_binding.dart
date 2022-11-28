import 'package:get/get.dart';
import 'package:pyc/controllers/home/home_controller.dart';
import 'package:pyc/controllers/notice/index_notice_controller.dart';
import 'package:pyc/controllers/user/fetch_me_controller.dart';
import 'package:pyc/data/provider/notice_provider.dart';
import 'package:pyc/data/provider/user_provider.dart';
import 'package:pyc/data/repository/notice_repository.dart';
import 'package:pyc/data/repository/user_repository.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    //service
    final userRepository = Get.put<UserRepository>(
      UserRepository(
        userProvider: UserProvider(),
      ),
    );
    final noticeRepository = Get.put<NoticeRepository>(
      NoticeRepository(
        noticeProvider: NoticeProvider(),
      ),
    );

    //controller
    Get.put<FetchMeController>(
      FetchMeController(repo: userRepository),
    );
    Get.put<IndexNoticeController>(
      IndexNoticeController(noticeRepository: noticeRepository),
    );
    Get.put(HomeController());
  }
}