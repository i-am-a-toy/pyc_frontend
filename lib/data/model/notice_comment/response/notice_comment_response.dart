import 'package:pyc/data/model/creator/creator_dto.dart';

class NoticeCommentResponse {
  final int id;
  final int churchId;
  final int noticeId;
  final String comment;
  final Creator creator;
  final DateTime createdAt;
  final DateTime lastModifiedAt;

  NoticeCommentResponse({
    required this.id,
    required this.churchId,
    required this.noticeId,
    required this.comment,
    required this.creator,
    required this.createdAt,
    required this.lastModifiedAt,
  });

  NoticeCommentResponse.fromJSON(Map<String, dynamic> json)
      : id = json['id'],
        churchId = json['churchId'],
        noticeId = json['noticeId'],
        comment = json['comment'],
        creator = Creator.fromJSON(
          json['creator'] as Map<String, dynamic>,
        ),
        createdAt = DateTime.parse(json['createdAt']),
        lastModifiedAt = DateTime.parse(json['lastModifiedAt']);
}
