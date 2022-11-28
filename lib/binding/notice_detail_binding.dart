import 'package:get/get.dart';
import 'package:pyc/controllers/notice/notice_detail_controller.dart';
import 'package:pyc/data/repository/notice_repository.dart';

class NoticeDetailBinding extends Bindings {
  @override
  void dependencies() {
    //service
    final noticeRepository = Get.find<NoticeRepository>();

    //controller
    Get.put<NoticeDetailController>(
      NoticeDetailController(
        noticeRepository: noticeRepository,
        targetId: Get.arguments["targetId"], // get target argument
        autoFocus: Get.arguments["autoFocus"],
      ),
    );
  }
}
