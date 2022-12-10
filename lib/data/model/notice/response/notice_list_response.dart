import 'package:pyc/data/model/notice/response/notice_response.dart';

/// NoticeListResponse
///
/// 공지사항에 대한 리스트를 요청하였을 때 서버로 응답을 받는 ResponseBody
/// [rows] 공지사항 List
/// [count] 공지사항의 Total Count
class NoticeListResponse {
  final List<NoticeResponse> rows;
  final int count;

  NoticeListResponse({required this.rows, required this.count});

  NoticeListResponse.fromJSON(Map<String, dynamic> json)
      : rows = (json['rows'] as List<dynamic>).map((e) => NoticeResponse.fromJSON(e)).toList(),
        count = json['count'];
}
