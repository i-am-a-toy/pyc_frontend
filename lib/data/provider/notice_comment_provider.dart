import 'package:dio/dio.dart';
import 'package:pyc/common/libraries/auth_api_client.dart';
import 'package:pyc/data/model/notice_comment/request/create_notice_comment_request.dart';
import 'package:pyc/data/model/notice_comment/request/update_notice_comment_request.dart';

class NoticeCommentProvider {
  Future<Response> findAllComment(
    int noticeId,
    int offset,
    int limit,
  ) async {
    final client = await getAuthApiClient();
    Map<String, dynamic> queryParameter = {"offset": offset, "limit": limit};
    return client.get(
      '/api/v1/notice-comments/notices/$noticeId',
      queryParameters: queryParameter,
    );
  }

  Future<void> saveComment(int noticeId, String comment) async {
    final client = await getAuthApiClient();
    await client.post(
      '/api/v1/notice-comments/notices/$noticeId',
      data: CreateNoticeCommentRequest(comment).toJson(),
    );
  }

  Future<void> updateComment(int id, String comment) async {
    final client = await getAuthApiClient();
    await client.put(
      '/api/v1/notice-comments/$id',
      data: UpdateNoticeCommentRequest(comment).toJson(),
    );
  }

  Future<void> deleteComment(int id) async {
    final client = await getAuthApiClient();
    await client.delete('/api/v1/notice-comments/$id');
  }
}
