import 'package:dio/dio.dart';
import 'package:pyc/common/libraries/auth_api_client.dart';
import 'package:pyc/data/model/notice_comment/request/create_comment_request.dart';
import 'package:pyc/data/model/notice_comment/response/notice_comment_response.dart';

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

  Future<Response> saveComment(int noticeId, String comment) async {
    final client = await getAuthApiClient();
    return client.post(
      '/api/v1/notice-comments/notices/$noticeId',
      data: CreateCommentRequest(comment).toJson(),
    );
  }
}
