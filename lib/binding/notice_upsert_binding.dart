import 'package:get/get.dart';
import 'package:pyc/controllers/notice/notice_upsert.controller.dart';
import 'package:pyc/data/repository/notice_repository.dart';

class NoticeUpsertBinding extends Bindings {
  @override
  void dependencies() {
    final repository = Get.find<NoticeRepository>();
    Get.put<NoticeUpserController>(NoticeUpserController(repository: repository));
  }
}
