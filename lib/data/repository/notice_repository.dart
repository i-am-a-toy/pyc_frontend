import 'package:get/get.dart';
import 'package:pyc/common/enum/sort_type.dart';
import 'package:pyc/data/model/notice/response/notice_list_response.dart';
import 'package:pyc/data/model/notice/response/notice_response.dart';
import 'package:pyc/data/provider/notice_provider.dart';

class NoticeRepository extends GetxService {
  final NoticeProvider noticeProvider;
  NoticeRepository({required this.noticeProvider});

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
}
