import 'package:dio/dio.dart';
import 'package:pyc/common/libraries/auth_api_client.dart';

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
}
