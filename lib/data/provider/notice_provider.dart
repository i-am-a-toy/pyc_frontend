import 'package:dio/dio.dart';
import 'package:pyc/common/enum/sort_type.dart';
import 'package:pyc/common/libraries/auth_api_client.dart';

class NoticeProvider {
  Future<Response> findAll(
    int offset,
    int limit, {
    SortType? sortType = SortType.desc,
  }) async {
    final client = await getAuthApiClient();
    Map<String, dynamic> queryParameter = {
      "offset": offset,
      "limit": limit,
      "sort": sortType!.code
    };
    return client.get('/api/v1/notices', queryParameters: queryParameter);
  }
}
