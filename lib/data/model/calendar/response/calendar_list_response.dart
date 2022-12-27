import 'dart:collection';

import 'package:pyc/data/model/calendar/response/calendar_response.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarListResponse {
  final List<CalendarResponse> rows;
  final int count;

  CalendarListResponse(
    this.rows,
    this.count,
  );

  CalendarListResponse.fromJSON(Map<String, dynamic> json)
      : rows = (json['rows'] as List<dynamic>).map((e) => CalendarResponse.fromJSON(e)).toList(),
        count = json['count'];

  // TODO: 이벤트 불러와서 Map으로 만든 후 제공
  LinkedHashMap<DateTime, List<CalendarListResponse>> toLinkedMap(DateTime day) {
    return LinkedHashMap<DateTime, List<CalendarListResponse>>(equals: isSameDay, hashCode: _getHashCode);
  }

  int _getHashCode(DateTime key) {
    return key.day * 1000000 + key.month * 10000 + key.year;
  }
}
