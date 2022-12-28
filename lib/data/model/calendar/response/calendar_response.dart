import 'package:pyc/data/model/creator/creator_dto.dart';
import 'package:pyc/data/model/last_modifier/last_modifier_dto.dart';

class CalendarResponse {
  final int id;
  final int churchId;
  final DateTime start;
  final DateTime end;
  final bool isAllDay;
  final String title;
  final String content;
  final Creator creator;
  final DateTime createdAt;
  final LastModifier lastModifier;
  final DateTime lastModifiedAt;

  CalendarResponse(
    this.id,
    this.churchId,
    this.start,
    this.end,
    this.isAllDay,
    this.title,
    this.content,
    this.creator,
    this.createdAt,
    this.lastModifier,
    this.lastModifiedAt,
  );

  CalendarResponse.fromJSON(Map<String, dynamic> json)
      : id = json['id'],
        churchId = json['churchId'],
        start = DateTime.parse(json['start']).add(const Duration(hours: 9)),
        end = DateTime.parse(json['end']).add(const Duration(hours: 9)),
        isAllDay = json['isAllDay'],
        title = json['title'],
        content = json['content'],
        creator = Creator.fromJSON(
          json['creator'] as Map<String, dynamic>,
        ),
        lastModifier = LastModifier.fromJSON(
          json['lastModifier'] as Map<String, dynamic>,
        ),
        createdAt = DateTime.parse(json['createdAt']),
        lastModifiedAt = DateTime.parse(json['lastModifiedAt']);
}
