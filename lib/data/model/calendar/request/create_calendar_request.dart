import 'package:pyc/common/utils/date/date.dart';

class CreateCalendarRequest {
  final String _title;
  final String _content;
  final DateTime _start;
  final DateTime _end;
  final bool _isAllDay;

  CreateCalendarRequest(
    this._title,
    this._content,
    this._start,
    this._end,
    this._isAllDay,
  );

  Map<String, dynamic> toJson() {
    return {
      'title': _title.replaceAll('\n', ' '),
      'content': _content.trim(),
      'start': _isAllDay ? getDateOnly(_start).toIso8601String() : _start.toIso8601String(),
      'end': _isAllDay ? getDateOnly(_end).toIso8601String() : _end.toIso8601String(),
      'isAllDay': _isAllDay,
    };
  }
}
