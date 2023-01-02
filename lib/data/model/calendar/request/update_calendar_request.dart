import 'package:pyc/extension/date_time.dart';

class UpdateCalendarRequest {
  final String _title;
  final String _content;
  final DateTime _start;
  final DateTime _end;
  final bool _isAllDay;

  UpdateCalendarRequest(
    this._title,
    this._content,
    this._start,
    this._end,
    this._isAllDay,
  );

  /// toJson
  ///
  /// Request를 보낼 때 UTC로 변경하여 Server로 요청을 보낸다.
  /// Server에서는 FE에서 요청이 온 날짜 데이터에 -9를 하여 저장을 하게 된다.
  Map<String, dynamic> toJson() {
    return {
      'title': _title.replaceAll('\n', ' '),
      'content': _content.trim(),
      'start': _isAllDay
          ? _start.getUtcDateOnly().subtract(const Duration(hours: 9)).toIso8601String()
          : _start.subtract(const Duration(hours: 9)).toIso8601String(),
      'end': _isAllDay
          ? _end.getUtcDateOnly().subtract(const Duration(hours: 9)).toIso8601String()
          : _end.subtract(const Duration(hours: 9)).toIso8601String(),
      'isAllDay': _isAllDay,
    };
  }
}
