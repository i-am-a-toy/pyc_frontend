import 'package:get/get.dart';
import 'package:pyc/data/model/notice/response/notice_list_response.dart';
import 'package:pyc/data/provider/notice_provider.dart';

class NoticeRepository extends GetxService {
  final NoticeProvider noticeProvider;
  NoticeRepository({required this.noticeProvider});

  Future<NoticeListResponse> findNotices(int offset, int limit) async {
    final result = await noticeProvider.findAll(offset, limit);
    NoticeListResponse response = NoticeListResponse.fromJSON(result.data);
    return response;
  }
}
