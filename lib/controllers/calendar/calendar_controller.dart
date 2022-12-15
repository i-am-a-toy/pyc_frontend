import 'package:get/get.dart';
import 'package:pyc/data/model/calendar/response/calendar_response.dart';
import 'package:pyc/data/model/calendar/response/mock_calendar.dart';
import 'package:pyc/extension/date_time.dart';

class CalendarController extends GetxController {
  bool _isLoading = false;
  DateTime _selectedDay = DateTime.now();
  DateTime _focusDay = DateTime.now();
  Map<DateTime, List<CalendarResponse>> _event = {};
  List<CalendarResponse> _rows = calendarList.rows;
  int _count = calendarList.count;

  select(DateTime selectDay, DateTime focusDay) {
    _focusDay = focusDay;
    _selectedDay = selectDay;
    update();
  }

  updateLoading() {
    _isLoading = false;
    update();
  }

  /// getEventsForDay
  ///
  /// 날짜가 선택되면 해당 날짜에 포함하는 Event의 List를 Return해주면 된다.
  /// day로 요청이 들어오는 건 현재 Calendar page 에서보여지는 전체 날짜이다.
  List<CalendarResponse> getEventsForDay(DateTime day) {
    return _rows.where((e) {
      print('start: ${e.start.toLocal()}');
      print('day: ${day.toLocal()}');
      print('end: ${e.end.toLocal()}');
      print('resutl: ${day.isBetween(e.start, e.end)}');
      return day.isBetween(e.start, e.end);
    }).toList();
  }

  bool get isLoading => _isLoading;
  DateTime get selectedDay => _selectedDay;
  DateTime get focusDay => _focusDay;
  List<CalendarResponse> get rows => _rows;
  int get count => _count;
}
