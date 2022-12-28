import 'dart:collection';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pyc/data/model/calendar/request/create_calendar_request.dart';
import 'package:pyc/data/model/calendar/request/update_calendar_request.dart';
import 'package:pyc/data/model/calendar/response/calendar_response.dart';
import 'package:pyc/data/repository/calendar_repository.dart';
import 'package:pyc/extension/date_time.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarController2 extends GetxController {
  final CalendarRepository repository;
  CalendarController2({required this.repository});

  /// For Calendar
  bool _isLoading = true;
  DateTime _focusDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  LinkedHashMap<DateTime, List<CalendarResponse>> _event = LinkedHashMap<DateTime, List<CalendarResponse>>(equals: isSameDay);
  int _count = 0;

  /// For Bottom Modal
  bool _isAllDay = false;
  DateTime _start = DateTime.now().getUtcDateOnly();
  DateTime _end = DateTime.now().getUtcDateOnly();

  @override
  @mustCallSuper
  void onInit() async {
    super.onInit();
    final result = await repository.getMonthEvent(_selectedDay.year, _selectedDay.month);
    _event = result.toLinkedMap(DateTime.now());
    _count = result.count;
    _isLoading = false;
    update();
  }

  /// select
  ///
  /// 날짜가 선택될 때 해당 날짜에 Focusing을 해주기 위함
  selectDay(DateTime selectDay, DateTime focusDay) {
    if (isSameDay(selectedDay, focusDay)) return;
    log('Change select & focus: ${DateFormat('yyyy-MM-dd').format(_selectedDay)} to ${DateFormat('yyyy-MM-dd').format(selectDay)}');
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
  Future<void> updatePage(DateTime day) async {
    log('Change page ${DateFormat('yyyy-MM').format(_selectedDay)} to ${DateFormat('yyyy-MM').format(day)} ');
    final result = await repository.getMonthEvent(day.year, day.month);
    _event = result.toLinkedMap(day);
    _count = result.count;
    update();
    _selectedDay = day;
    _focusDay = day;
  }

  /// getEventsForDay
  ///
  /// 날짜가 선택되면 해당 날짜에 포함하는 Event의 List를 Return해주면 된다.
  /// day로 요청이 들어오는 건 현재 Calendar page 에서보여지는 전체 날짜이다.
  /// 인자로는 UTC Date가 들어온다.
  List<CalendarResponse> getEventsForDay(DateTime day) {
    return _event[day] ?? [];
  }

  /// addCalendar
  ///
  /// 일정의 제목과 본문을 받아 일정을 등록
  Future<void> addCalendar(BuildContext context, String title, String content) async {
    log('Hit Add Calendar with title: $title, content: $content, start:${DateFormat('yyyy-MM-dd').format(_start)}, end:${DateFormat('yyyy-MM-dd').format(_end)}, isAllDay: $_isAllDay');

    /// Data를 Server로 넘겨주면 DB에서 자동으로 UTC 변환을 하며 -9를 하게 된다.
    await repository.save(CreateCalendarRequest(title, content, _start, _end, _isAllDay));
    await repository.getMonthEvent(_focusDay.year, _focusDay.month).then((result) {
      _event = result.toLinkedMap(_focusDay);
      _count = result.count;
      update();
      Navigator.pop(context);
    });
  }

  /// addCalendar
  ///
  /// 일정의 제목과 본문을 받아 일정을 등록
  Future<void> updateCalendar(BuildContext context, int id, String title, String content) async {
    log('Hit Update Calendar with id: $id title: $title, content: $content, start:${DateFormat('yyyy-MM-dd').format(_start)}, end:${DateFormat('yyyy-MM-dd').format(_end)}, isAllDay: $_isAllDay');

    await repository.update(id, UpdateCalendarRequest(title, content, _start, _end, _isAllDay));
    await repository.getMonthEvent(_focusDay.year, _focusDay.month).then((result) {
      _event = result.toLinkedMap(_focusDay);
      _count = result.count;
      update();
      Navigator.pop(context);
    });
  }

  Future<void> deleteCalendar(BuildContext context, int id) async {
    log('Hit Delete Calendar with $id');
    await repository.delete(id);
    await repository.getMonthEvent(_focusDay.year, _focusDay.month).then((result) {
      _event = result.toLinkedMap(_focusDay);
      _count = result.count;
      update();
      Navigator.pop(context);
    });
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
    _start = _focusDay.getUtcDateOnly();
    _end = _focusDay.getUtcDateOnly();
    _isAllDay = false;
    log('Reset Calendar Bottom Sheet State start, end with ${_focusDay.getUtcDateOnly()}');
    update();
  }

  DateTime get focusDay => _focusDay;
  DateTime get selectedDay => _selectedDay;
  bool get isLoading => _isLoading;
  int get count => _count;

  bool get isAllDay => _isAllDay;
  DateTime get start => _start;
  DateTime get end => _end;
}
