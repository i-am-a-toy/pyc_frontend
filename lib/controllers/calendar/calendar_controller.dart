import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pyc/common/utils/date/date.dart';
import 'package:pyc/data/model/calendar/request/create_calendar_request.dart';
import 'package:pyc/data/model/calendar/response/calendar_response.dart';
import 'package:pyc/data/repository/calendar_repository.dart';
import 'package:pyc/extension/date_time.dart';

class CalendarController extends GetxController {
  final CalendarRepository repository;
  CalendarController({required this.repository});

  // calendar
  bool _isLoading = true;
  DateTime _selectedDay = DateTime.now();
  DateTime _focusDay = DateTime.now();
  List<CalendarResponse> _rows = [];
  int _count = 0;

  // for create calendar
  DateTime _start = DateTime.now();
  DateTime _end = DateTime.now();
  bool _isAllDay = false;

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
  select(DateTime selectDay, DateTime focusDay) {
    _focusDay = focusDay;
    _selectedDay = selectDay;
    update();
  }

  /// getEventsForDay
  ///
  /// 날짜가 선택되면 해당 날짜에 포함하는 Event의 List를 Return해주면 된다.
  /// day로 요청이 들어오는 건 현재 Calendar page 에서보여지는 전체 날짜이다.
  List<CalendarResponse> getEventsForDay(DateTime day) {
    return _rows.where((e) => day.dateOnly().isBetween(e.start.dateOnly(), e.end.dateOnly())).toList();
  }

  /// updatePage
  ///
  /// Page가 변경될 때 해당 달의 이벤트들을 얻어와 rows에 넣어줘야함.
  Future<void> updatePage(DateTime day) async {
    final now = DateTime.now();
    if (now.month == day.month) {
      _selectedDay = now;
      _focusDay = now;
      final result = await repository.getMonthEvent(_selectedDay.year, _selectedDay.month);
      _rows = result.rows;
      _count = result.count;
      // _isLoading = false;
      update();
      return;
    }
    _selectedDay = day;
    _focusDay = day;

    await reFetchwithSelectDay();
    update();
  }

  Future<void> createCalendars(String title, String content) async {
    await repository.save(
      CreateCalendarRequest(
        title,
        content,
        _start,
        _end,
        _isAllDay,
      ),
    );

    await reFetchwithSelectDay();
    update();
    return;
  }

  Future<void> reFetchwithSelectDay() async {
    final result = await repository.getMonthEvent(_selectedDay.year, _selectedDay.month);
    _rows = result.rows;
    _count = result.count;
  }

  toggleIsAllDay(bool value) {
    _isAllDay = value;
    update();
  }

  void updateStart(DateTime? day) {
    _start = day!;
    if (_end.isBefore(_start)) _end = day;
    update();
  }

  void updateEnd(DateTime? day) {
    _end = day!;
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

  // for calendar
  bool get isLoading => _isLoading;
  DateTime get selectedDay => _selectedDay;
  DateTime get focusDay => _focusDay;
  List<CalendarResponse> get rows => _rows;
  int get count => _count;

  // for calendar CRUD
  DateTime get start => _start;
  DateTime get end => _end;
  bool get isAllDay => _isAllDay;
}
