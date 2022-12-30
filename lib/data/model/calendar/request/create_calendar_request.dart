import 'package:pyc/extension/date_time.dart';

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
      'start': _isAllDay ? _start.dateOnly().toIso8601String() : _start.toIso8601String(),
      'end': _isAllDay ? _end.dateOnly().toIso8601String() : _end.toIso8601String(),
      'isAllDay': _isAllDay,
    };
  }
}
