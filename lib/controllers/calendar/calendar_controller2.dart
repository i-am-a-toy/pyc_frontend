import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pyc/common/utils/date/date.dart';
import 'package:pyc/data/model/calendar/request/create_calendar_request.dart';
import 'package:pyc/data/model/calendar/response/calendar_response.dart';
import 'package:pyc/data/repository/calendar_repository.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:pyc/extension/date_time.dart';

class CalendarController2 extends GetxController {
  final CalendarRepository repository;
  CalendarController2({required this.repository});

  /// For Calendar
  bool _isLoading = true;
  DateTime _focusDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  List<CalendarResponse> _rows = [];
  int _count = 0;

  /// For Bottom Modal
  bool _isAllDay = false;
  DateTime _start = DateTime.now();
  DateTime _end = DateTime.now();

  @override
  @mustCallSuper
  void onInit() async {
    super.onInit();
    final result = await repository.getMonthEvent(_selectedDay.year, _selectedDay.month);
    _rows = result.rows;
    _count = result.count;
    _isLoading = false;
    update();
  }

  /// select
  ///
  /// 날짜가 선택될 때 해당 날짜에 Focusing을 해주기 위함
  selectDay(DateTime selectDay, DateTime focusDay) {
    if (isSameDay(selectedDay, focusDay)) return;
    log('Change select & focuse: ${DateFormat('yyyy-MM-dd').format(_selectedDay)} to ${DateFormat('yyyy-MM-dd').format(selectDay)}');
    _selectedDay = selectDay;
    _focusDay = selectDay;
    log('Change start & end: ${DateFormat('yyyy-MM-dd').format(_selectedDay)} to ${DateFormat('yyyy-MM-dd').format(selectDay)}');
    _start = selectDay;
    _end = selectDay;
    update();
  }

  /// updatePage
  ///
  /// https://github.com/aleksanderwozniak/table_calendar#updating-focusedday
  /// TODO: Map으로 만들어 놓은 Map Data에서 인자로 들어오는 DateTime으로 바로 접근하기
  Future<void> updatePage(DateTime day) async {
    final result = await repository.getMonthEvent(day.year, day.month);
    _rows = result.rows;
    _count = result.count;
    update();
    _selectedDay = day;
    _focusDay = day;
  }

  /// getEventsForDay
  ///
  /// 날짜가 선택되면 해당 날짜에 포함하는 Event의 List를 Return해주면 된다.
  /// day로 요청이 들어오는 건 현재 Calendar page 에서보여지는 전체 날짜이다.
  List<CalendarResponse> getEventsForDay(DateTime day) {
    return _rows.where((e) => day.dateOnly().isBetween(e.start.dateOnly(), e.end.dateOnly())).toList();
  }

  /// addCalendar
  ///
  /// 일정의 제목과 본문을 받아 일정을 등록
  Future<void> addCalendar(BuildContext context, String title, String content) async {
    log('Hit Add Calendar with title: $title, content: $content');
    repository.save(CreateCalendarRequest(title, content, _start, _end, _isAllDay));
    Navigator.pop(context);
  }

  /// For Bottom Sheet
  void toggleIsAllDay(bool? val) {
    _isAllDay = val!;
    update();
  }

  void updateStart(DateTime? val) {
    log('Update Start ${DateFormat('yyyy-MM-dd').format(_start)} to ${DateFormat('yyyy-MM-dd').format(val!)}');
    if (_end.isBefore(val)) {
      log('Update End with Start ${DateFormat('yyyy-MM-dd').format(_end)} to ${DateFormat('yyyy-MM-dd').format(val)}');
      _end = val;
    }
    _start = val;
    update();
  }

  void updateEnd(DateTime? val) {
    log('Update End ${DateFormat('yyyy-MM-dd').format(_end)} to ${DateFormat('yyyy-MM-dd').format(val!)}');
    _end = val;
    update();
  }

  void resetBottomSheet() {
    final currentFocusing = getDateOnly(_focusDay).toLocal();
    _start = currentFocusing;
    _end = currentFocusing;
    _isAllDay = false;
    log('Reset Calendar Bottom Sheet State start, end with $currentFocusing');
    update();
  }

  DateTime get focusDay => _focusDay;
  DateTime get selectedDay => _selectedDay;
  bool get isLoading => _isLoading;
  List<CalendarResponse> get rows => _rows;
  int get count => _count;

  bool get isAllDay => _isAllDay;
  DateTime get start => _start;
  DateTime get end => _end;
}
