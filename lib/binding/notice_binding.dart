import 'package:get/get.dart';
import 'package:pyc/controllers/notice/notice_controller.dart';
import 'package:pyc/data/repository/notice_repository.dart';

class NoticeBinding extends Bindings {
  @override
  void dependencies() {
    //service
    final noticeRepository = Get.find<NoticeRepository>();

    //controller
    Get.put<NoticeController>(
      NoticeController(noticeRepository: noticeRepository),
    );
  }
}
