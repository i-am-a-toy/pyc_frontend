import 'dart:collection';
import 'dart:developer';

import 'package:pyc/data/model/calendar/response/calendar_response.dart';
import 'package:pyc/extension/date_time.dart';
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

  LinkedHashMap<DateTime, List<CalendarResponse>> toLinkedMap(DateTime day) {
    final int year = day.year;
    final int month = day.month;
    const int monthFirst = 1;
    final int monthLastDay = day.getLastDayOfMonth().day;

    // 달의 첫 날부터 마지막 날까지 반복문을 돌면서 Map을 만들어 제공한다.
    log('create EventMap $year-$month-($monthFirst ~ $monthLastDay)');
    final eventMap = LinkedHashMap<DateTime, List<CalendarResponse>>(equals: isSameDay);
    for (int i = monthFirst; i <= monthLastDay; i++) {
      final day = DateTime(year, month, i).dateOnly();
      final event = rows.where((e) => day.isBetween(e.start.dateOnly(), e.end.dateOnly())).toList();
      eventMap.addAll({day: event});
    }

    return eventMap;
  }
}
