import 'package:pyc/data/model/notice/response/notice_response.dart';

class NoticeListResponse {
  final List<NoticeResponse> rows;
  final int count;

  NoticeListResponse({required this.rows, required this.count});

  NoticeListResponse.fromJSON(Map<String, dynamic> json)
      : rows = (json['rows'] as List<dynamic>)
            .map((e) => NoticeResponse.fromJSON(e))
            .toList(),
        count = json['count'];
}
