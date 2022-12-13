import 'package:pyc/data/model/creator/creator_dto.dart';
import 'package:pyc/data/model/last_modifier/last_modifier_dto.dart';

/// NoticeResponse
///
/// 공지사항 조회를 하였을 때 서버로 부터 응답을 받는 ResponseBody
class NoticeResponse {
  final int id;
  final String title;
  final String content;
  final Creator creator;
  final LastModifier lastModifer;
  final DateTime createdAt;
  final DateTime lastModifiedAt;

  NoticeResponse({
    required this.id,
    required this.title,
    required this.content,
    required this.creator,
    required this.createdAt,
    required this.lastModifer,
    required this.lastModifiedAt,
  });

  NoticeResponse.fromJSON(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        content = json['content'],
        creator = Creator.fromJSON(
          json['creator'] as Map<String, dynamic>,
        ),
        lastModifer = LastModifier.fromJSON(
          json['lastModifier'] as Map<String, dynamic>,
        ),
        createdAt = DateTime.parse(json['createdAt']),
        lastModifiedAt = DateTime.parse(json['lastModifiedAt']);
}
