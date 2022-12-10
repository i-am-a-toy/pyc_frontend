import 'package:dio/dio.dart';
import 'package:pyc/common/enum/sort_type.dart';
import 'package:pyc/common/libraries/auth_api_client.dart';
import 'package:pyc/data/model/notice/request/create_notice_request.dart';
import 'package:pyc/data/model/notice/request/update_notice_request.dart';

class NoticeProvider {
  Future<Response> findAll(
    int offset,
    int limit, {
    SortType? sortType = SortType.desc,
  }) async {
    final client = await getAuthApiClient();
    Map<String, dynamic> queryParameter = {"offset": offset, "limit": limit, "sort": sortType!.code};
    return client.get('/api/v1/notices', queryParameters: queryParameter);
  }

  Future<Response> findOneById(int id) async {
    final client = await getAuthApiClient();
    return client.get('/api/v1/notices/$id');
  }

  Future<void> save(CreateNoticeRequest req) async {
    final client = await getAuthApiClient();
    await client.post('/api/v1/notices', data: req.toJson());
  }

  Future<void> update(int id, UpdateNoticeRequest req) async {
    final client = await getAuthApiClient();
    await client.put('/api/v1/notices/$id', data: req.toJson());
  }

  Future<void> delete(int id) async {
    final client = await getAuthApiClient();
    await client.delete('/api/v1/notices/$id');
  }
}
