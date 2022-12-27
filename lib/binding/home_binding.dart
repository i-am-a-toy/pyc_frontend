import 'package:get/get.dart';
import 'package:pyc/controllers/home/home_controller.dart';
import 'package:pyc/controllers/notice/notice_controller.dart';
import 'package:pyc/controllers/user/fetch_me_controller.dart';
import 'package:pyc/data/provider/calendar_provider.dart';
import 'package:pyc/data/provider/notice_provider.dart';
import 'package:pyc/data/provider/user_provider.dart';
import 'package:pyc/data/repository/calendar_repository.dart';
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
    Get.put<CalendarRepository>(
      CalendarRepository(
        calendarProvider: CalendarProvider(),
      ),
    );

    //controller
    Get.put<FetchMeController>(
      FetchMeController(repo: userRepository),
    );
    Get.put(NoticeController(
      noticeRepository: noticeRepository,
    ));
    Get.put(HomeController());
  }
}
