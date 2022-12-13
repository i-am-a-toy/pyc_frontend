import 'package:get/get.dart';
import 'package:pyc/common/enum/sort_type.dart';
import 'package:pyc/data/model/notice/request/create_notice_request.dart';
import 'package:pyc/data/model/notice/request/update_notice_request.dart';
import 'package:pyc/data/model/notice/response/notice_list_response.dart';
import 'package:pyc/data/model/notice/response/notice_response.dart';
import 'package:pyc/data/provider/notice_provider.dart';

class NoticeRepository extends GetxService {
  final NoticeProvider noticeProvider;
  NoticeRepository({required this.noticeProvider});

  Future<void> save(CreateNoticeRequest req) async {
    await noticeProvider.save(req);
  }

  Future<NoticeListResponse> findNotices(
    int offset,
    int limit, {
    SortType? sort = SortType.desc,
  }) async {
    final result = await noticeProvider.findAll(offset, limit, sortType: sort);
    NoticeListResponse response = NoticeListResponse.fromJSON(result.data);
    return response;
  }

  Future<NoticeResponse> findOneById(int id) async {
    final result = await noticeProvider.findOneById(id);
    NoticeResponse response = NoticeResponse.fromJSON(result.data);
    return response;
  }

  Future<void> update(int id, UpdateNoticeRequest req) async {
    await noticeProvider.update(id, req);
  }

  Future<void> delete(int id) async {
    await noticeProvider.delete(id);
  }
}
