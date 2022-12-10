import 'package:dio/dio.dart';
import 'package:pyc/common/enum/sort_type.dart';
import 'package:pyc/common/libraries/auth_api_client.dart';
import 'package:pyc/data/model/notice/request/create_notice_request.dart';
import 'package:pyc/data/model/notice/request/update_notice_request.dart';

class NoticeProvider {
  /// findAll - 공지사항의 리스트를 요청하는 method 기본적으로 정렬 타입은 [SortType.desc]이다.
  Future<Response> findAll(
    int offset,
    int limit, {
    SortType? sortType = SortType.desc,
  }) async {
    final client = await getAuthApiClient();
    Map<String, dynamic> queryParameter = {"offset": offset, "limit": limit, "sort": sortType!.code};
    return client.get('/api/v1/notices', queryParameters: queryParameter);
  }

  /// findOneById - 공지사항의 [id]값을 받아 Detail을 조회하는 method
  Future<Response> findOneById(int id) async {
    final client = await getAuthApiClient();
    return client.get('/api/v1/notices/$id');
  }

  /// save - [CreateNoticeRequest]를 받아 공지사항을 생성하는 method
  Future<void> save(CreateNoticeRequest req) async {
    final client = await getAuthApiClient();
    await client.post('/api/v1/notices', data: req.toJson());
  }

  /// update - [id]와 [UpdateNoticeRequest]를 받아 공지사항을 수정하는 method
  Future<void> update(int id, UpdateNoticeRequest req) async {
    final client = await getAuthApiClient();
    await client.put('/api/v1/notices/$id', data: req.toJson());
  }

  /// delete - [id]를 받아 공지사항을 삭제하는 method
  Future<void> delete(int id) async {
    final client = await getAuthApiClient();
    await client.delete('/api/v1/notices/$id');
  }
}
