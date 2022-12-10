import 'package:get/get.dart';
import 'package:pyc/data/model/notice_comment/response/notice_comment_list_response.dart';
import 'package:pyc/data/provider/notice_comment_provider.dart';

class NoticeCommentRepository extends GetxService {
  final NoticeCommentProvider provider;
  NoticeCommentRepository({required this.provider});

  Future<NoticeCommentListResponse> findComments({
    required int noticeId,
    required int offset,
    required int limit,
  }) async {
    final result = await provider.findAllComment(noticeId, offset, limit);
    NoticeCommentListResponse response = NoticeCommentListResponse.fromJSON(result.data);
    return response;
  }

  Future<void> saveComment({required int noticeId, required String comment}) async {
    await provider.saveComment(noticeId, comment);
  }

  Future<void> updateComment({required int id, required String comment}) async {
    await provider.updateComment(id, comment);
  }

  Future<void> deleteComment({required int id}) async {
    await provider.deleteComment(id);
  }
}
