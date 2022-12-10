import 'package:get/get.dart';
import 'package:pyc/controllers/notice/notice_detail_controller.dart';
import 'package:pyc/controllers/notice_comment/notice_comment_controller.dart';
import 'package:pyc/data/provider/notice_comment_provider.dart';
import 'package:pyc/data/repository/notice_comment_repository.dart';
import 'package:pyc/data/repository/notice_repository.dart';

class NoticeDetailBinding extends Bindings {
  @override
  void dependencies() {
    //service
    final noticeRepository = Get.find<NoticeRepository>();
    final noticeCommentRepository = Get.put(
      NoticeCommentRepository(
        provider: NoticeCommentProvider(),
      ),
    );

    //controller
    Get.put<NoticeDetailController>(
      NoticeDetailController(
        noticeRepository: noticeRepository,
        targetId: Get.arguments["targetId"], // get target argument
        autoFocus: Get.arguments["autoFocus"],
      ),
    );
    Get.put<NoticeCommentController>(
      NoticeCommentController(
        noticeCommentRepository: noticeCommentRepository,
        noticeId: Get.arguments["targetId"],
      ),
    );
  }
}
